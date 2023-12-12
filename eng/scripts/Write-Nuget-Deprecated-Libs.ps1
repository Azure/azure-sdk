[CmdletBinding()]
param (
  [string] $nuget_pat = "<PAT goes here>", #nuget.org
    [string] $language = "dotnet"
)

. (Join-Path $PSScriptRoot PackageList-Helpers.ps1)

function Get-PackageListForLanguage($lang)
{
  $csvPath = GetPackagePathForLanguage $lang
  if (!(Test-Path $csvPath)) { return $null }
  return Import-Csv $csvPath
}

function GetPackagePathForLanguage($lang)
{
  $packagePath = Join-Path $PSScriptRoot "..\.." "_data\releases\latest"
  return Join-Path $packagePath "$lang-packages.csv"
}

function Write-Nuget-Deprecated-Packages($packageList)
{
# Automatically update nuget.org with deprecation messages for
# packages that have been marked as deprecated in our CSV files.
# To do this we have to:
#    1) Get the nuget service index
#    2) Use the package status query service to get the package index
#    3) Use the package index to get the package metadata
#    4) Parse the metadata to see if the package has already been deprecated
#    5) If not, update the package to reflect deprecation status
#    5b) Requires querying the package content service to get package version list  
  $linkTemplates = GetLinkTemplates "dotnet"
  $nugetServiceIndex = $linkTemplates["nuget_service_index_url"]
  $nugetRegistrationServiceName = $linkTemplates["nuget_registration_service"]
  $nugetDeprecationServiceName = $linkTemplates["nuget_deprecation_service"]
  $nugetPackaceContentServiceName = $linkTemplates["nuget_package_content_service"]

  # 1) Get the nuget service index
  try
  {
    $responseContent = Invoke-RestMethod -Uri $nugetServiceIndex -Method Get -ErrorAction SilentlyContinue
  }
  catch
  {
    $statusCode = $_.Exception.Response.StatusCode.value__
    Write-Host "Nuget service index query - Exception: $statusCode"
    Write-Host $_
    Write-Host "URI: $nugetServiceIndex"
    Write-Host "=================================="
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
    if($pkg.Support -eq "deprecated")
    {
      # Is it safe to assume there will always be either a
      # VersionGA or VersionPreview value?
      if($pkg.VersionGA)
      {
        $version = $pkg.VersionGA
      }
      else
      {
        $version = $pkg.VersionPreview
      }
      $package = $pkg.Package
      $packageName = $package.ToLowerInvariant()

      # 2) Use the package status query service to get the package index
      $packageIndex = "$registrationUrl/$packageName/index.json"
      $packageId = "$registrationUrl/$packageName/$($version.ToLowerInvariant()).json"
      try
      {
        $responseContent = Invoke-RestMethod -Uri $packageIndex -Method Get -ErrorAction SilentlyContinue
      }
      catch
      {
        $statusCode = $_.Exception.Response.StatusCode.value__
        Write-Host "NuGet package index query - Exception: $statusCode"
        Write-Host "URI: $packageIndex"
        Write-Host "=================================="
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
            $regPageContent = Invoke-RestMethod $regPage.'@id'
            $allItems += $regPageContent.items
        }
      }

      # 3) Use the package index to get the package metadata
      $metadata = $allItems | Where-Object { $_.'@id' -eq "$packageId"} | ConvertTo-Json
      # 4) Parse the metadata to see if the package has already been deprecated
      if ( -not ($metadata.catalogEntry | Select-Object -ExpandProperty deprecation -First 1 -ErrorAction SilentlyContinue))
      {
        #  5) If not, update the package to reflect deprecation status
        # Set variables   
        if ($pkg.EOLDate)
        {
          $EOLDate = $pkg.EOLDate
        }
        else
        {
          $EOLDate = "NA"
        }
        if ($pkg.Replace){
          $replacementPackage = $pkg.Replace
        }
        else
        {
          $replacementPackage = "NA"
        }
        if ($pkg.ReplaceGuide)
        {
          $migrationGuide = $pkg.ReplaceGuide
        }
        else
        {
          $migrationGuide = "NA"
        }
        # 5b) Query the package content service to get package version list
        $packageContent = "$contentUrl/$packageName/index.json"
        try
        {
          $responseContent = Invoke-RestMethod -Uri $packageContent -Method Get -ErrorAction SilentlyContinue
        }
        catch
        {
          $statusCode = $_.Exception.Response.StatusCode.value__
          Write-Host "NuGet package content query - Exception: $statusCode"
          Write-Host "URI: $packageContent"
          Write-Host "=================================="
        }
        $versions = $responseContent.versions

        # Construct the deprecation message
        if ((Get-Date $pkg.EOLDate) -lt (Get-Date))
        {
          $deprecationMsg = "Please note, this package was officially deprecated on $EOLDate and is no longer maintained or monitored."
          $markAsLegacy = "true"
          $markAsOther = "false"
        }
        else
        {
          $deprecationMsg = "Please note, this package has been deprecated and will no longer be maintained"
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
        if ($replacementPackage -and ($replacementPackage -ne "NA"))
        { # If there are multiple replacement packages, list them all
          $packageArray = $replacementPackage.Split(",")
          if ($packageArray.Count -gt 1)
          {
            $deprecationMsg += " The Azure SDK team encourages you to upgrade to one of the following replacement packages, depending on your use case:`n"
            foreach ($newPackage in $packageArray)
            {
              $deprecationMsg += "    $newPackage`n"
            }
            $deprecationReplacement = $packageArray[0]
          }
          else
          { # only one replacement package
            if ($replacementPackage -ne $package)
            {
                $deprecationMsg += " The Azure SDK team encourages you to upgrade to the replacement package, $replacementPackage, to continue receiving updates."
                $deprecationReplacement = $replacementPackage
            }
            else
            { # package name hasn't changed
                $deprecationMsg += " The Azure SDK team encourages you to upgrade to the latest version to continue receiving updates."
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
          'X-NuGet-ApiKey' = "$nuget_pat"
          'User-Agent' = "Query-Azure-Packages.ps1 (Azure SDK GH repo)"
        }
        $body = @{
          'versions'= @($versions)
          'isLegacy' = "$markAsLegacy"
          'isOther' = "$markAsOther"
          'message' = "$deprecationMsg"
          'alternatePackageId' = "$deprecationReplacement"
        } | ConvertTo-Json
        try
        {
          Write-Host "============================"
          Write-Host "Deprecating NuGet package:"
          Write-Host $packageName
          Write-Host "============================"
          Invoke-WebRequest -Uri $deprecationUrl/$packageName/deprecations -Method Put -Headers $headers -Body $body -ContentType "application/json"
        }
        catch
        {
          $statusCode = $_.Exception.Response.StatusCode.value__
          $response = $_.Exception.Response
          Write-Host "Nuget package deprecation - Exception: $statusCode"
          Write-Host "Response: $response"
          Write-Host "URI: $deprecationUrl/$packageName/deprecations"
          Write-Host "=================================="
        }
        # The nuget deprecation API is rate-limited to one request per minute
        Start-Sleep -Seconds 60
      }
    }
  }
}

# Call the function with a list of packages
$packageList = Get-PackageListForLanguage $language
Write-Nuget-Deprecated-Packages $packageList