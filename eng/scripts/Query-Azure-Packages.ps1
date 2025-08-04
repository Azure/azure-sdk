[CmdletBinding()]
param (
  [string] $language = "all",
  [string] $github_pat = $env:GITHUB_PAT,
  [string] $nuget_pat = $env:NUGET_PAT,
  [boolean] $updateDeprecated = $false,
  [switch] $RunDeprecationOnly
)
Set-StrictMode -Version 3

. (Join-Path $PSScriptRoot PackageList-Helpers.ps1)

function Get-android-Packages
{
  # Rest API docs https://search.maven.org/classic/#api
  $baseMavenQueryUrl = "https://search.maven.org/solrsearch/select?q=g:com.azure.android&rows=100&wt=json"
  $mavenQuery = Invoke-RestMethod "https://search.maven.org/solrsearch/select?q=g:com.azure.android&rows=2000&wt=json" -MaximumRetryCount 3

  Write-Host "Found $($mavenQuery.response.numFound) android packages on maven packages"

  $packages = @()
  $count = 0
  while ($count -lt $mavenQuery.response.numFound)
  {
    $packages += $mavenQuery.response.docs | Foreach-Object { CreatePackage $_.a $_.latestVersion $_.g }
    $count += $mavenQuery.response.docs.count

    $mavenQuery = Invoke-RestMethod ($baseMavenQueryUrl + "&start=$count") -MaximumRetryCount 3
  }

  return $packages
}

function Get-java-Packages
{
  # Rest API docs https://search.maven.org/classic/#api
  $baseMavenQueryUrl = "https://search.maven.org/solrsearch/select?q=g:com.microsoft.azure*%20OR%20g:com.azure*%20OR%20g:io.clientcore&rows=100&wt=json"
  $mavenQuery = Invoke-RestMethod $baseMavenQueryUrl -MaximumRetryCount 3

  Write-Host "Found $($mavenQuery.response.numFound) java packages on maven packages"

  $packages = @()
  $count = 0
  while ($count -lt $mavenQuery.response.numFound)
  {
    $packages += $mavenQuery.response.docs | Foreach-Object { if ($_.g -ne "com.azure.android") { CreatePackage $_.a $_.latestVersion $_.g } }
    $count += $mavenQuery.response.docs.count

    $mavenQuery = Invoke-RestMethod ($baseMavenQueryUrl + "&start=$count") -MaximumRetryCount 3
  }

  $repoTags = GetPackageVersions "java"
  
  foreach ($tag in $repoTags.Keys)
  {
    if ($packages.Package -notcontains $tag) {
      $version = [AzureEngSemanticVersion]::SortVersions($repoTags[$tag].Versions)[0]
      Write-Warning "${tag}_${version} - Didn't find this package using the maven search $baseMavenQueryUrl"
    }
  }

  foreach ($package in $packages)
  {
    # If package is in com.azure.resourcemanager groupid and we shipped it recently because it is in the last months repo tags
    # then treat it as a new mgmt library
    if ($package.GroupId -eq "com.azure.resourcemanager" `
        -and $package.Package -match "^azure-resourcemanager-(?<serviceName>.*?)$" `
        -and $repoTags.ContainsKey($package.Package))
    {
      $serviceName = (Get-Culture).TextInfo.ToTitleCase($matches["serviceName"])
      $package.Type = "mgmt"
      $package.New = "true"
      # $package.RepoPath = $matches["serviceName"].ToLower() -- Should be set by the pipelines now so lets not guess at the repo path
      $package.ServiceName = $serviceName
      $package.DisplayName = "Resource Management - $serviceName"
      Write-Verbose "Marked package $($package.Package) as new mgmt package with version $($package.VersionGA + $package.VersionPreview)"
    }
  }

  return $packages
}

function Get-dotnet-Packages
{
  # Rest API docs
  # https://docs.microsoft.com/nuget/api/search-query-service-resource
  # https://docs.microsoft.com/nuget/consume-packages/finding-and-choosing-packages#search-syntax
  $nugetQuery = Invoke-RestMethod "https://azuresearch-usnc.nuget.org/query?q=owner:azure-sdk&prerelease=true&semVerLevel=2.0.0&take=1000" -MaximumRetryCount 3

  Write-Host "Found $($nugetQuery.totalHits) nuget packages"
  $packages = $nugetQuery.data | Foreach-Object { CreatePackage $_.id $_.version }

  $repoTags = GetPackageVersions "dotnet"

  foreach ($package in $packages)
  {
    # If package starts with Azure.ResourceManager. and we shipped it recently because it is in the last months repo tags
    # then treat it as a new mgmt library
    if ($package.Package -match "^Azure.ResourceManager.(?<serviceName>.*?)$" -and $repoTags.ContainsKey($package.Package))
    {
      $serviceName = (Get-Culture).TextInfo.ToTitleCase($matches["serviceName"])
      $package.Type = "mgmt"
      $package.New = "true"
      # $package.RepoPath = $matches["serviceName"].ToLower() -- Should be set by the pipelines now so lets not guess at the repo path
      $package.ServiceName = $serviceName
      $package.DisplayName = "Resource Management - $serviceName"
      Write-Verbose "Marked package $($package.Package) as new mgmt package with version $($package.VersionGA + $package.VersionPreview)"
    }

    # If package starts with Azure.Provisioning. and we shipped it recently because it is in the last months repo tags
    # then treat it as a new mgmt library
    if ($package.Package -match "^Azure.Provisioning.(?<serviceName>.*?)$" -and $repoTags.ContainsKey($package.Package))
    {
      $serviceName = (Get-Culture).TextInfo.ToTitleCase($matches["serviceName"])
      $package.Type = "mgmt" # provisioning is a special case of mgmt so this is the correct type.
      $package.New = "true"
      $package.RepoPath = "provisioning"
      $package.ServiceName = $serviceName
      $package.DisplayName = "Provisioning - $serviceName"
      Write-Verbose "Marked package $($package.Package) as new mgmt package with version $($package.VersionGA + $package.VersionPreview)"
    }
  }

  return $packages
}

function Get-js-Packages
{
  $from = 0
  $npmPackages = @()

  do
  {
    # Rest API docs https://github.com/npm/registry/blob/master/docs/REGISTRY-API.md
    # max size returned is 250 so we have to do some basic paging.
    $npmQuery = Invoke-RestMethod "https://registry.npmjs.com/-/v1/search?text=maintainer:azure-sdk&size=250&from=$from" -MaximumRetryCount 3

    if ($npmQuery.objects.Count -ne 0) {
      $npmPackages += $npmQuery.objects.package
    }
    $from += $npmQuery.objects.Count
  } while ($npmQuery.objects.Count -ne 0);

  $publishedPackages = $npmPackages | Where-Object { $_.publisher.username -eq "azure-sdk" -or $_.publisher.username -eq "microsoft1es" }
  $otherPackages = $npmPackages | Where-Object { !($_.publisher.username -eq "azure-sdk" -or $_.publisher.username -eq "microsoft1es") }

  foreach ($otherPackage in $otherPackages) {
    Write-Verbose "Not updating package $($otherPackage.name) because the publisher is $($otherPackage.publisher.username) and not azure-sdk"
  }

  Write-Host "Found $($publishedPackages.Count) npm packages"
  $packages = $publishedPackages | Foreach-Object { CreatePackage $_.name $_.version }

  $repoTags = GetPackageVersions "js"

  foreach ($package in $packages)
  {
    # If package starts with arm- and we shipped it recently because it is in the last months repo tags
    # then treat it as a new mgmt library
    if ($package.Package -match "^@azure/arm-(?<serviceName>.*?)(-profile.*)?$" -and $repoTags.ContainsKey($package.Package))
    {
      $serviceName = (Get-Culture).TextInfo.ToTitleCase($matches["serviceName"])
      $package.Type = "mgmt"
      $package.New = "true"
      # $package.RepoPath = $matches["serviceName"].ToLower() -- Should be set by the pipelines now so lets not guess at the repo path
      $package.ServiceName = $serviceName
      $package.DisplayName = "Resource Management - $serviceName"
      Write-Verbose "Marked package $($package.Package) as new mgmt package with version $($package.VersionGA + $package.VersionPreview)"
    }
  }

  return $packages
}

function Get-python-Packages
{
  $pythonQuery = "import xmlrpc.client; [print(pkg[1]) for pkg in xmlrpc.client.ServerProxy('https://pypi.org/pypi').user_packages('<OWNER>')]"
  $azurePackageNames = (python -c ("$pythonQuery" -replace "<OWNER>","azure-sdk"))
  $microsoftPackageNames = (python -c ("$pythonQuery" -replace "<OWNER>","microsoft"))

  $microsoftPythonPackages = $microsoftPackageNames | Foreach-Object {
    try { (Invoke-RestMethod "https://pypi.org/pypi/$_/json" -MaximumRetryCount 3) } catch { } }

  # Filter to only microsoft owned packages with "azure sdk" keyword or any packages
  # owned/maintained by the azure-sdk account
  $pythonPackages = $microsoftPythonPackages | Where-Object {
    $_.info.keywords -match "azure sdk" -or $azurePackageNames -contains $_.info.name }

  Write-Host "Found $($azurePackageNames.Count) azure-sdk owned python packages"
  Write-Host "Found $($pythonPackages.Count) total packages"

  $packages = @()
  foreach ($package in $pythonPackages)
  {
    $packageVersion = $package.info.Version
    $packageReleases = @($package.releases.PSObject.Properties.Name)

    # Python info.Version only takes last stable version so we need to sort the releases.
    # Only use the sorted releases if they are all valid sem versions otherwise we might have
    # an incorrect sort. We determine that if the list of sorted versions match the count of the versions
    $versions = [AzureEngSemanticVersion]::SortVersionStrings($packageReleases)
    if ($versions.Count -eq $packageReleases.Count)
    {
      $packageVersion = $versions[0]
      $packages += CreatePackage $package.info.name $packageVersion
    }
  }

  $repoTags = GetPackageVersions "python"

  foreach ($package in $packages)
  {
    # If package starts with azure-mgmt- and we shipped it recently because it is in the last months repo tags
    # then treat it as a new mgmt library
    if ($package.Package -match "^azure-mgmt-(?<serviceName>.*?)?$" -and $repoTags.ContainsKey($package.Package))
    {
      $serviceName = (Get-Culture).TextInfo.ToTitleCase($matches["serviceName"])
      $package.Type = "mgmt"
      $package.New = "true"
      # $package.RepoPath = $matches["serviceName"].ToLower() -- Should be set by the pipelines now so lets not guess at the repo path
      $package.ServiceName = $serviceName
      $package.DisplayName = "Resource Management - $serviceName"
      Write-Verbose "Marked package $($package.Package) as new mgmt package with version $($package.VersionGA + $package.VersionPreview)"
    }
  }

  return $packages
}

function Get-cpp-Packages
{
  $packages = @()
  $repoTags = GetPackageVersions "cpp"

  Write-Host "Found $($repoTags.Count) recent tags in cpp repo"

  foreach ($tag in $repoTags.Keys)
  {
    $versions = [AzureEngSemanticVersion]::SortVersions($repoTags[$tag].Versions)
    $packages += CreatePackage $tag $versions[0]
  }

  return $packages
}

function Get-go-Packages
{
  $packages = @()
  $repoTags = GetPackageVersions "go"

  Write-Host "Found $($repoTags.Count) recent tags in go repo"

  foreach ($tag in $repoTags.Keys)
  {
    $versions = [AzureEngSemanticVersion]::SortVersions($repoTags[$tag].Versions)

    $package = CreatePackage $tag $versions[0]

    # We should keep this regex in sync with what is in the go repo at https://github.com/Azure/azure-sdk-for-go/blob/main/eng/scripts/Language-Settings.ps1#L40
    if ($package.Package -match "(?<modPath>(sdk|profile)/(?<serviceDir>(.*?(?<serviceName>[^/]+)/)?(?<modName>[^/]+$)))")
    {
      #$modPath = $matches["modPath"] Not using modPath currently here but keeping the capture group to be consistent with the go repo
      $modName = $matches["modName"]
      $serviceDir = $matches["serviceDir"]
      $serviceName = $matches["serviceName"]
      if (!$serviceName) { $serviceName = $modName }

      if ($modName.StartsWith("arm"))
      {
        # Skip arm packages that aren't in the resourcemanager service folder
        if (!$serviceDir.StartsWith("resourcemanager")) { continue }
        $package.Type = "mgmt"
        $package.New = "true"
        $modName = $modName.Substring(3); # Remove arm from front
        $package.DisplayName = "Resource Management - $((Get-Culture).TextInfo.ToTitleCase($modName))"
        Write-Verbose "Marked package $($package.Package) as new mgmt package with version $($package.VersionGA + $package.VersionPreview)"
      }
      elseif ($modName.StartsWith("az"))
      {
        $package.Type = "client"
        $package.New = "true"
        $modName = $modName.Substring(2); # Remove az from front
        $package.DisplayName = $((Get-Culture).TextInfo.ToTitleCase($modName))
      }

      $package.ServiceName = (Get-Culture).TextInfo.ToTitleCase($serviceName)
      $package.RepoPath = $serviceDir.ToLower()

      $packages += $package
    }
  }

  return $packages
}

function Get-rust-Packages
{
  $packages = @()
  # https://crates.io/api/v1/users/azure-sdk to find user id
  $next_page = '?user_id=313465&per_page=100'
  $crates = while ($next_page) {
      $page = Invoke-RestMethod "https://crates.io/api/v1/crates$next_page"
      $next_page = $page.meta.next_page
      $page.crates
  }

  Write-Host "Found $($crates.Count) crates belonging to azure-sdk"

  $packages = @()
  foreach ($crate in $crates)
  {
    $packages += CreatePackage $crate.name $crate.max_version
  }

  return $packages
}

function Write-Latest-Versions($lang)
{
  $packageList = Get-PackageListForLanguage $lang

  if ($null -eq $packageList) { $packageList = @() }

  $LangFunction = "Get-$lang-Packages"
  $queriedPackages = &$LangFunction

  $packageLookup = GetPackageLookup $packageList

  foreach ($queriedPkg in $queriedPackages)
  {
    $pkgEntry = LookupMatchingPackage $queriedPkg $packageLookup

    if (!$pkgEntry) {
      # alpha packages are not yet fully supported versions so skip adding them to the list yet.
      if ($queriedPkg.VersionPreview -notmatch "-alpha") {
        # Add new package
        $packageList += $queriedPkg
        Write-Host "Adding new package $($queriedPkg.Package)"
      }
    }
    else {
      if ($queriedPkg.Type -and $queriedPkg.Type -ne $pkgEntry.Type) {
        $pkgEntry.Type = $queriedPkg.Type
      }

      if ($queriedPkg.New -ne "false" -and $queriedPkg.New -ne $pkgEntry.New) {
        $pkgEntry.New = $queriedPkg.New
      }

      if ($pkgEntry.VersionGA.StartsWith("0")) {
        $pkgEntry.VersionGA = ""
      }

      # Update version of package
      if ($queriedPkg.VersionGA) {
        $pkgEntry.VersionGA = $queriedPkg.VersionGA

        $gaSemVer = ToSemVer $pkgEntry.VersionGA
        $previewSemVer = ToSemVer $pkgEntry.VersionPreview
        if ($gaSemVer -and $previewSemVer -and $gaSemVer -gt $previewSemVer) {
          $pkgEntry.VersionPreview = ""
        }
      }
      else {
        $pkgEntry.VersionPreview = $queriedPkg.VersionPreview
      }
    }
  }

  # Keep package managers up to date with package deprecations
  if($updateDeprecated -eq $true -and $lang -eq 'dotnet')
  {
    Write-Nuget-Deprecated-Packages($packageList)
  }

  # Clean out packages that are no longer in the query we use for the package manager
  foreach ($existingPkg in $packageList)
  {
    # Skip the package entries that don't have a Package value as they are just placeholders
    if ($existingPkg.Package -eq "") { continue }

    $pkgEntry = LookupMatchingPackage $existingPkg $packageLookup

    if (!$pkgEntry) {
      Write-Verbose "Found package $($existingPkg.Package) in the CSV which could be removed"
    }
  }

  Set-PackageListForLanguage $lang $packageList
}

function Write-Nuget-Deprecated-Packages($packageList)
{
  $hitException = $false
  # Automatically update nuget.org with deprecation messages for
  # packages that have been marked as deprecated in our CSV files.
  # To do this we have to:
  #    1) Get the nuget service index
  #    2) Use the package status query service to get the package index
  #    3) Update the package to reflect deprecation status
  #    3b) Requires querying the package content service to get package version list
  $linkTemplates = GetLinkTemplates "dotnet"
  $nugetServiceIndex = $linkTemplates["nuget_service_index_url"]
  $nugetRegistrationServiceName = $linkTemplates["nuget_registration_service"]
  $nugetDeprecationServiceName = $linkTemplates["nuget_deprecation_service"]
  $nugetPackaceContentServiceName = $linkTemplates["nuget_package_content_service"]

  # 1) Get the nuget service index
  try
  {
    $responseContent = Invoke-RestMethod -Uri $nugetServiceIndex -Method Get -ErrorAction SilentlyContinue -MaximumRetryCount 3
  }
  catch
  {
    $statusCode = $_.Exception.Response.StatusCode.value__
    Write-Host "Failed: Nuget service index query - Exception: $statusCode"
    Write-Host "URI: $nugetServiceIndex"
    Write-Host $_.Exception.ToString()
    Write-Host "=================================="
    return $true
  }

  $nugetRegistrationService = $responseContent.resources | Where-Object { $_.'@type' -eq "$nugetRegistrationServiceName" }
  $registrationUrl = $nugetRegistrationService.'@id'
  $registrationUrl = $registrationUrl.TrimEnd('/')
  $nugetDeprecationService = $responseContent.resources | Where-Object { $_.'@type' -eq "$nugetDeprecationServiceName" }
  $deprecationUrl = $nugetDeprecationService.'@id'
  $deprecationUrl = $deprecationUrl.TrimEnd('/')
  $nugetPackageContentService = $responseContent.resources | Where-Object { $_.'@type' -eq "$nugetPackaceContentServiceName" }
  $contentUrl = $nugetPackageContentService.'@id'
  $contentUrl = $contentUrl.TrimEnd('/')

  foreach ($pkg in $packageList)
  {
    if ($pkg.Support -ne "deprecated") { continue }

    $package = $pkg.Package
    $packageName = $package.ToLowerInvariant()

    # 2) Use the package status query service to get the package index
    $packageIndex = "$registrationUrl/$packageName/index.json"
    try
    {
      $responseContent = Invoke-RestMethod -Uri $packageIndex -Method Get -ErrorAction SilentlyContinue -MaximumRetryCount 3
    }
    catch
    {
      $statusCode = $_.Exception.Response.StatusCode.value__
      Write-Host "Failed: NuGet package index query - Exception: $statusCode"
      Write-Host "URI: $packageIndex"
      Write-Host $_.Exception.ToString()
      Write-Host "=================================="
      $hitException = $true
      continue
    }

    # Get all the items from each of the pages as there could be more then one depending on how many versions there are
    # See docs at https://learn.microsoft.com/en-us/nuget/api/registration-base-url-resource#registration-page-object
    $allItems = @()
    foreach ($regPage in $responseContent.items)
    {
      if ($regPage.PSObject.Properties.Name -contains "items")
      {
        $allItems += $regPage.items
      }
      else
      {
          $regPageContent = Invoke-RestMethod $regPage.'@id' -MaximumRetryCount 3
          $allItems += $regPageContent.items
      }
    }
    $EOLDate = $pkg.EOLDate ?? "NA"
    $replacementPackage = $pkg.Replace ?? "NA"
    $migrationGuide = $pkg.ReplaceGuide ?? "NA"

    # 3b) Query the package content service to get package version list
    $packageContent = "$contentUrl/$packageName/index.json"
    try
    {
      $responseContent = Invoke-RestMethod -Uri $packageContent -Method Get -ErrorAction SilentlyContinue -MaximumRetryCount 3
    }
    catch
    {
      $statusCode = $_.Exception.Response.StatusCode.value
      Write-Host "Failed: NuGet package content query - Exception: $statusCode"
      Write-Host "URI: $packageContent"
      Write-Host $_.Exception.ToString()
      Write-Host "=================================="
      $hitException = $true
      continue
    }
    $versions = $responseContent.versions

    # Package versions that don't match.
    $versionMap = @{
      "Microsoft.Azure.DocumentDB" = @("2.6.0-RC1")
      "Microsoft.Azure.DocumentDB.Core" = @("2.6.0-RC1")
      "Microsoft.Azure.Management.Blueprint" = @("0.9.0-Preview", "0.9.1-Preview")
      "Microsoft.Azure.Management.Network" = @("20.6.1-Beta", "20.6.1-Beta.1", "20.6.1-Beta.2", "22.1.0-Beta.1")
      "Microsoft.Azure.Management.SampleProjectPublish" = @("0.9.0-Preview")
      "Microsoft.Azure.ServiceBus" = @("1.0.0-RC1")
    }

    # Workaround temp bug version comparision is case sensitive see https://github.com/NuGet/NuGetGallery/issues/10242
    if ($versionMap.ContainsKey($packageName)) {
      $versions = $versions | ForEach-Object {
        foreach ($v in $versionMap[$packageName]) {
          # compare is case insensitive but we want the matching case version if it exists in the map
          if ($v -eq $_) { 
            return $v
          } 
        }
        return $_
      }
    }

    # 3) update the package to reflect deprecation status
    if ((Get-Date $pkg.EOLDate) -lt (Get-Date))
    {
      $deprecationMsg = "Please note, this package is obsolete as of $EOLDate and is no longer maintained or monitored."
      $markAsLegacy = "true"
      $markAsOther = "false"
    }
    else
    {
      $deprecationMsg = "Please note, this package is obsolete and will no longer be maintained"
      if ($EOLDate -and ($EOLDate -ne "NA"))
      {
        $deprecationMsg += " after $EOLDate."
      }
      else
      {
        $deprecationMsg += "."
      }
      $markAsLegacy = "false"
      $markAsOther = "true"
    }

    $deprecationReplacement = ""
    if ($replacementPackage -and ($replacementPackage -ne "NA"))
    {
      $packageArray = $replacementPackage.Split(",")
      if ($packageArray.Count -gt 1)
      {
        $deprecationMsg += " Microsoft encourages you to upgrade to one of the following replacement packages, depending on your use case:`n"
        foreach ($newPackage in $packageArray)
        {
          $deprecationMsg += "    $newPackage`n"
        }
        $deprecationReplacement = $packageArray[0]
      }
      else
      {
        if ($replacementPackage -ne $package)
        {
            $deprecationMsg += " Microsoft encourages you to upgrade to the replacement package, $replacementPackage, to continue receiving updates."
            $deprecationReplacement = $replacementPackage
        }
        else
        {
            $deprecationMsg += " Microsoft encourages you to upgrade to the latest version to continue receiving updates."
            $deprecationReplacement = ""
        }
      }
    }

    if ($migrationGuide -and ($migrationGuide -ne "NA"))
    {
        $deprecationMsg += " Refer to the migration guide ($migrationGuide) for guidance on upgrading."
    }

    $deprecationMsg += " Refer to our deprecation policy (https://aka.ms/azsdk/support-policies) for more details."
    $headers = @{
      "X-NuGet-ApiKey" = "$nuget_pat"
      "User-Agent" = "Query-Azure-Packages.ps1 (Azure SDK GH repo)"
    }

    $body = @{
      'versions'= @($versions)
      'isLegacy' = "$markAsLegacy"
      'isOther' = "$markAsOther"
      'message' = "$deprecationMsg"
      'alternatePackageId' = "$deprecationReplacement"
    } | ConvertTo-Json

    $retry = 3;
    while ($retry -gt 0)
    {
      try
      {
        Write-Host "============================"
        Write-Host "Deprecating NuGet package:"
        Write-Host $packageName
        Write-Verbose "URI: $deprecationUrl/$packageName/deprecations"
        Write-Verbose $body
        $response = Invoke-WebRequest -Uri $deprecationUrl/$packageName/deprecations -Method Put -Headers $headers -Body $body -ContentType "application/json"
        Write-Host "Succeeded in deprecating package $packageName - with status code $($response.StatusCode)"
        Write-Host "============================"
        break;
      }
      catch
      {
        $statusCode = $_.Exception.Response.StatusCode.value__
    
        if ($statusCode -eq 429)
        {
          $retry--;
          if ($retry -eq 0)
          {
            Write-Host "Failed: Nuget package deprecation failed for package $packageName with status code 429 after 3 failed attempts"
            Write-Host $_.Exception.ToString()
            Write-Host "=================================="
            $hitException = $true
            break;
          }

          $retryAfter = 60;
          if ($_.Exception.Response.Headers.RetryAfter.Delta) {
            $retryAfter = $_.Exception.Response.Headers.RetryAfter.Delta
          }

          Write-Host "Retrying after $retryAfter"
          Start-Sleep -Seconds $retryAfter.TotalSeconds
        }
        else {
          Write-Host "Failed: Nuget package deprecation failed for package $packageName with status code $statusCode"
          Write-Host $_.Exception.ToString()
          Write-Host "=================================="
          $hitException = $true
          break;
        }
      }
    }
  }

  return $hitException
}

if ($RunDeprecationOnly) {
  $packageList = Get-PackageListForLanguage "dotnet"
  if (Write-Nuget-Deprecated-Packages $packageList) {
    Write-Error "Encounted an exception while deprecating packages. See logs for details" 
    exit 1
  } else {
    exit 0
  }
}

switch($language)
{
  "all" {
    Write-Latest-Versions "js"
    Write-Latest-Versions "dotnet"
    Write-Latest-Versions "python"
    Write-Latest-Versions "cpp"
    Write-Latest-Versions "go"
    Write-Latest-Versions "rust"

    # Maven search api has lots of reliability issues so keeping this error
    # handling here to keep it from failing the pipeline all the time.
    try {
      Write-Latest-Versions "java"
      Write-Latest-Versions "android"
    }
    catch {
      Write-Host "Exception: $_"
      Write-Host "Maven search appears to be down currently, so java and android updates might not complete successfully. See https://status.maven.org/ for current status."
    }
    break
  }
  "java" {
    Write-Latest-Versions $language
    break
  }
  "js" {
    Write-Latest-Versions $language
    break
  }
  "dotnet" {
    Write-Latest-Versions $language
    break
  }
  "python" {
    Write-Latest-Versions $language
    break
  }
  "cpp" {
    Write-Latest-Versions $language
    break
  }
  "go" {
    Write-Latest-Versions $language
    break
  }
  "android" {
    Write-Latest-Versions $language
    break
  }
  "rust" {
    Write-Latest-Versions $language
    break
  }
  default {
    Write-Host "Unrecognized Language: $language"
    exit 1
  }
}
