[CmdletBinding()]
param (
  [string] $releaseFolder =  "$PSScriptRoot\..\..\_data\releases\latest",
  [string] $pkgFilter = $null,
  [bool] $updateAllVersions = $false, # When false only updates the versions in the preview and ga in csv
  [string] $github_pat = $env:GITHUB_PAT,
  [string] $devops_pat = $env:DEVOPS_PAT
)
Set-StrictMode -Version 3

# Only needed to help avoid rate limiting for tag and date querying
if ($github_pat) {
  $GithubHeaders = @{
    Authorization = "bearer ${github_pat}"
  }
}

$orgParameters =  @("--organization", "https://dev.azure.com/azure-sdk")
$commonParameters =  $orgParameters + @("--output", "json")
$commonParametersWithProject = $commonParameters + @("--project", "Release")

# Needed when updating version fields
if ($devops_pat) {
  $encodedToken = [System.Convert]::ToBase64String([System.Text.Encoding]::ASCII.GetBytes([string]::Format("{0}:{1}", "", $devops_pat)))
  $DevOpsHeaders = @{
    Authorization = "Basic $encodedToken"
  }

  $azCmdStr = "az devops login $($orgParameters -join " ")"
  Write-Host $azCmdStr
  $azCmdStr = "'$devops_pat' | $azCmdStr" # add the PAT after outputing the command so we don't try to dump the key
  Invoke-Expression $azCmdStr
}

function GetCommitterDate($shaUrl)
{
  try
  {
    if (!$shaUrl) { return $null }
    $ProgressPreference = "SilentlyContinue"; # Disable invoke-webrequest progress dialog
    $response = Invoke-WebRequest $shaUrl -headers $GithubHeaders
    $content = $response.Content | ConvertFrom-Json -AsHashTable

    # lightweight tags just point to a commit
    if ($content["committer"] -and $content["committer"].date) {
      return [System.DateTimeOffset]$content["committer"].date
    }
    # annotated tags point to tag
    if ($content["tagger"] -and $content["tagger"].date) {
      return [System.DateTimeOffset]$content["tagger"].date
    }
    return $null
  }
  catch
  {
    Write-Host "Failed to get date information for $shaUrl"
    Write-Host $_
    exit(1)
  }
}
function GetExistingTags($apiUrl)
{
  try
  {
    return (Invoke-RestMethod -Method "GET" -Uri "$apiUrl/git/refs/tags" -headers $GithubHeaders) 
    #| ForEach-Object { $_.ref.Replace("refs/tags/", "") }
  }
  catch
  {
    $statusCode = $_.Exception.Response.StatusCode.value__

    Write-Host "Failed to retrieve tags from repository."
    Write-Host "StatusCode:" $statusCode
    Write-Host $_
    exit(1)
  }
}

# Regex inspired but simplifie from https://semver.org/#is-there-a-suggested-regular-expression-regex-to-check-a-semver-string
$SEMVER_REGEX = "^(?<major>0|[1-9]\d*)\.(?<minor>0|[1-9]\d*)(\.(?<patch>0|[1-9]\d*))?(?:-?(?<prelabel>[a-zA-Z-]*)(?:\.?(?<prenumber>0|[1-9]\d*)))?$"

function ToSemVer($version, $shaUrl = $null)
{
  if ($version -match $SEMVER_REGEX)
  {
    $patch = if ($matches['patch']) { [int]$matches['patch'] } else { 0 }
    if($null -eq $matches['prelabel']) {
      # artifically provide these values for non-prereleases to enable easy sorting of them later than prereleases.
      $prelabel = "zzz"
      $prenumber = 999;
      $isPre = $false;
      $versionType = "GA"
      if ($patch -ne 0) {
        $versionType = "Patch"
      }
    }
    else {
      $prelabel = $matches["prelabel"]
      $prenumber = [int]$matches["prenumber"]
      $isPre = $true;
      $versionType = "Beta"
    }

    New-Object PSObject -Property @{
      Major = [int]$matches['major']
      Minor = [int]$matches['minor']
      Patch = $patch
      PrereleaseLabel = $prelabel
      PrereleaseNumber = $prenumber
      IsPrerelease = $isPre
      VersionType = $versionType
      RawVersion = $version
      ShaUrl = $shaUrl
    }
  }
  else
  {
    return $null
  }
}

function SortSemVersions($versions)
{
   return $versions | Sort-Object -Property Major, Minor, Patch, PrereleaseLabel, PrereleaseNumber -Descending
}

function GetPackageVersions($lang)
{
  $apiUrl = "https://api.github.com/repos/azure/azure-sdk-for-$lang"
  if ($lang -eq "dotnet") { $apiUrl = "https://api.github.com/repos/azure/azure-sdk-for-net" }

  $tags = GetExistingTags $apiUrl
  $packageVersions = @{}

  foreach ($tag in $tags)
  {
    $sp = $tag.ref.Replace("refs/tags/", "").Split('_')
    if ($sp.Length -eq 2) 
    {
      $package = $sp[0]
      $version = $sp[1]
      if (!$packageVersions.ContainsKey($package)) {
        $packageVersions.Add($package, @())
      }
      $sv = ToSemVer $version $tag.object.url
      if ($null -ne $sv) {
        $packageVersions[$package] += $sv
      }
    }
  }
  return $packageVersions
}

$langMapping = @{
    # c = "C" - -- These don't follow normal tagging rules
    cpp = "C++"
    dotnet = ".NET"
    java = "Java"
    js = "JavaScript"
    python = "Python"
    # go = "Go" -- No csv or tagging info
    # ios = "iOS" -- These don't follow normal tagging rules
    android = "Android"
}

function GetLang($lang)
{
  $pkgLang = $langMapping[$lang]
  if (!$pkgLang) { 
    $pkgLang = $lang
  }
  return $pkgLang
}

$allVersions = @{}

function InitializeVersionInformation()
{
  if ($allVersions.Count -gt 0) { 
    return
  }

  foreach ($lang in $langMapping.Keys) 
  {
    $packagelistFile = Join-Path $releaseFolder "$lang-packages.csv"
    $packageList = Import-Csv $packagelistFile | Sort-Object Type, DisplayName, Package, GroupId
    $packageList = $packageList | Where-Object { $_.New -eq "true" }

    if ($pkgFilter) {
      $packageList = $packageList | Where-Object { $_.Package -like $pkgFilter }
    }

    $langPkgVersions = GetPackageVersions $lang
    Write-Verbose "Found $($langPkgVersions.Count) versions for language $lang"

    $packageSet = @{}
    foreach ($pkg in $packageList)
    {
      $versions = @()

      # Consider adding the versions from the csv but we don't have a date for them currently
      if ($langPkgVersions.ContainsKey($pkg.Package)) {
        $versions += $langPkgVersions[$pkg.Package]
      }
      if ($pkg.VersionGA -and ($versions.Count -eq 0 -or $versions.RawVersion -notcontains $pkg.VersionGA)) {
        $versions += ToSemVer $pkg.VersionGA
      }
      if ($pkg.VersionPreview -and ($versions.Count -eq 0 -or $versions.RawVersion -notcontains $pkg.VersionPreview)) {
        $versions += ToSemVer $pkg.VersionPreview
      }

      $versions = SortSemVersions $versions

      if ($versions.Count -eq 0) {
        Write-Verbose "No versioning information for $lang - $($pkg.Package)"
        continue
      }
      
      $verGroups = $versions | Group-Object -Property Major, Minor
  
      $pkgVerGroups = @{}
      foreach ($verGroup in $verGroups)
      {
        $verMajMin = ($verGroup.Name -replace ", ", ".")

        if (!$updateAllVersions) {
          if (!(PackageMatchesVersionGroup $pkg $verMajMin)) {
            continue
          }
        }

        $pkgVerGroups[$verMajMin] = New-Object PSObject -Property @{
          Versions = $verGroup.Group
          VersionMajorMinor = $verMajMin
          PackageInfo = $pkg
        }
      }
      $packageSet[$pkg.Package] = New-Object PSObject -Property @{
        VersionGroups = $pkgVerGroups
        PackageInfo = $pkg
      }
    }
    $allVersions[(GetLang $lang)] = $packageSet
  }
}
function GetVersionInfo($pkgLang, $pkgName, $verMajorMinor)
{
  InitializeVersionInformation

  if (!$allVersions.ContainsKey($pkgLang)) {
    return $null
  }
  if (!$allVersions[$pkgLang].ContainsKey($pkgName)) {
    return $null
  }
  # Return the package item if the version isn't passed
  if (!$verMajorMinor){
    return $allVersions[$pkgLang][$pkgName]
  }
  if (!$allVersions[$pkgLang][$pkgName].VersionGroups.ContainsKey($verMajorMinor)) {
    return $null
  }
  return $allVersions[$pkgLang][$pkgName].VesionGroups[$verMajorMinor]
}

function BuildHashKeyNoNull()
{
  $filterNulls = $args | Where-Object { $_ }
  # if we had any nulls then return null
  if (!$filterNulls -or $args.Count -ne $filterNulls.Count) {
    return $null
  }
  return BuildHashKey $args
}

function BuildHashKey()
{
  # if no args or the first arg is null return null
  if ($args.Count -lt 1 -or !$args[0]) {
    return $null
  }

  # exclude null values
  $keys = $args | Where-Object { $_ }
  return $keys -join "|"
}

$parentWorkItems = @{}

function FindParentWorkItem($serviceName, $packageDisplayName)
{
  $key = BuildHashKey $serviceName $packageDisplayName
  if ($key -and $parentWorkItems.ContainsKey($key)) {
    return $parentWorkItems[$key]
  }

  if ($serviceName) {
    $serviceCondition = "[ServiceName] = '${serviceName}'"
    if ($packageDisplayName) {
      $serviceCondition += "AND [PackageDisplayName] = '${packageDisplayName}'"
    }
  }
  else {
    $serviceCondition = "[ServiceName] <> ''"
  }

  $parameters = $commonParametersWithProject
  $parameters += "--wiql"
  $parameters += "`"SELECT [ID], [ServiceName], [PackageDisplayName], [Parent] FROM WorkItems WHERE [Work Item Type] = 'Epic' AND ${serviceCondition}`""

  $azCmdStr = "az boards query $($parameters -join " ")"
  Write-Host $azCmdStr
  $workItems = Invoke-Expression "$azCmdStr" | ConvertFrom-Json -AsHashtable

  foreach ($wi in $workItems) {
    $localKey = BuildHashKey $wi.fields["Custom.ServiceName"] $wi.fields["Custom.PackageDisplayName"]
    if (!$localKey) { continue }
    if ($parentWorkItems.ContainsKey($localKey)) {
      Write-Warning "Already found parent [$($parentWorkItems[$localKey].id)] with key [$localKey], using that one instead of [$($wi.id)]."
    }
    else {
      Write-Verbose "[$($wi.id)]$localKey - Cached"
      $parentWorkItems[$localKey] = $wi
    }
  }

  if ($key -and $parentWorkItems.ContainsKey($key)) {
    return $parentWorkItems[$key]
  }
  return $null
}

$packageWorkItems = @{}
$packageWorkItemWithoutKeyFields = @{}
function FindPackageWorkItem($lang, $packageName, $version)
{
  $key = BuildHashKeyNoNull $lang $packageName $version
  if ($key -and $packageWorkItems.ContainsKey($key)) {
    return $packageWorkItems[$key]
  }

  $fields = @()
  $fields += "ID"
  $fields += "State"
  $fields += "Microsoft.VSTS.Common.StateChangeDate"
  $fields += "Parent"
  $fields += "Language"
  $fields += "Package"
  $fields += "PackageDisplayName"
  $fields += "Title"
  $fields += "PackageType"
  $fields += "PackageTypeNewLibrary"
  $fields += "PackageVersionMajorMinor"
  $fields += "ServiceName"
  $fields += "Planned Packages"
  $fields += "Shipped Packages"
  $fields += "PackageBetaVersions"
  $fields += "PackageGAVersion"
  $fields += "PackagePatchVersions"

  $fieldList = ($fields | ForEach-Object { "[$_]"}) -join ", "
  $query = "SELECT ${fieldList} FROM WorkItems WHERE [Work Item Type] = 'Package'"

  if (!$updateAllVersions -and !$lang) {
    $query += " AND [State] <> 'No Active Development'"
  }
  if ($lang) {
    $query += " AND [Language] = '${lang}'"
  }
  if ($packageName) {
    $query += " AND [Package] = '${packageName}'"
  }
  if ($version) {
    $query += " AND [PackageVersionMajorMinor] = '${version}'"
  }
  $parameters = $commonParametersWithProject
  $parameters += "--wiql", "`"${query}`""

  $azCmdStr = "az boards query $($parameters -join " ")"
  Write-Host $azCmdStr
  $workItems = Invoke-Expression "$azCmdStr" | ConvertFrom-Json -AsHashtable

  foreach ($wi in $workItems)
  {
    $localKey = BuildHashKeyNoNull $wi.fields["Custom.Language"] $wi.fields["Custom.Package"] $wi.fields["Custom.PackageVersionMajorMinor"]
    if (!$localKey) 
    {
      $packageWorkItemWithoutKeyFields[$wi.id] = $wi
      Write-Verbose "Found package [$($wi.id)] which is missing required fields language, package, or version."
      continue 
    }
    if ($packageWorkItems.ContainsKey($localKey)) {
      Write-Warning "Already found package [$($packageWorkItems[$localKey].id)] with key [$localKey], using that one instead of [$($wi.id)]."
    }
    else {
      Write-Verbose "Caching package [$($wi.id)] for [$localKey]"
      $packageWorkItems[$localKey] = $wi
    } 
  }

  if ($key -and $packageWorkItems.ContainsKey($key)) {
    return $packageWorkItems[$key]
  }
  return $null
}

function UpdateWorkItemParent($childWorkItem, $parentWorkItem)
{
  $childId = $childWorkItem.id
  $existingParentId = $childWorkItem.fields["System.Parent"]
  $newParentId = $parentWorkItem.id

  if ($existingParentId -eq $newParentId) {
    return
  }

  CreateWorkItemParent $childId $newParentId $existingParentId
  $childWorkItem.fields["System.Parent"] = $newParentId
}

function CreateWorkItemParent($id, $parentId, $oldParentId)
{
  # Have to remove old parent first if you want to add a new parent. 
  if ($oldParentId)
  {
     $parameters = $commonParameters
     $parameters += "--id", $id
     $parameters += "--relation-type", "parent"
     $parameters += "--target-id", $oldParentId
     
     $azCmdStr = "az boards work-item relation remove --yes $($parameters -join " ")"
     Write-Host $azCmdStr
     Invoke-Expression $azCmdStr | Out-Null
  }

  $parameters = $commonParameters
  $parameters += "--id", $id
  $parameters += "--relation-type", "parent"
  $parameters += "--target-id", $parentId

  $azCmdStr = "az boards work-item relation add $($parameters -join " ")"
  Write-Host $azCmdStr
  Invoke-Expression $azCmdStr | Out-Null
}
function CreateWorkItem($title, $type, $iteration, $area, $fields, $parentId)
{
  $parameters = $commonParametersWithProject
  $parameters += "--title", "`"${title}`""
  $parameters += "--type", "`"${type}`""
  $parameters += "--iteration", "`"${iteration}`""
  $parameters += "--area", "`"${area}`""
  if ($fields) {
    $parameters += "--fields"
    $parameters += $fields
  }

  $azCmdStr = "az boards work-item create $($parameters -join " ")"
  Write-Host $azCmdStr
  $workItem = Invoke-Expression "$azCmdStr" | ConvertFrom-Json -AsHashtable

  if ($parentId) {
    $parameters = $commonParameters
    $parameters += "--id", $workItem.id
    $parameters += "--relation-type", "parent"
    $parameters += "--target-id", $parentId

    $azCmdStr = "az boards work-item relation add $($parameters -join " ")"
    Write-Host $azCmdStr
    Invoke-Expression $azCmdStr | Out-Null
  }

  return $workItem
}

function UpdateWorkItem($id, $fields, $title, $state)
{
  $parameters = $commonParameters
  $parameters += "--id", $id
  if ($title) {
    $parameters += "--title", "`"${title}`""
  }
  if ($state) {
    $parameters += "--state", "`"$state`""
  }
  if ($fields) {
    $parameters += "--fields"
    $parameters += $fields
  }

  $azCmdStr = "az boards work-item update $($parameters -join " ")"
  Write-Host $azCmdStr
  $workItem = Invoke-Expression "$azCmdStr" | ConvertFrom-Json -AsHashtable
  return $workItem
}

function CreateOrUpdatePackageWorkItem($lang, $pkg, $version, $existingItem)
{
  $pkgLang = GetLang $lang
  $title = $pkgLang + " - " + $pkg.DisplayName
  $pkgName = $pkg.Package
  $pkgDisplayName = $pkg.DisplayName
  $pkgType = $pkg.Type
  $pkgNewLibrary = "True"
  $semver = ToSemVer $version
  if (!$semver) { Write-Error "Version $version is not valid for $pkgName"; return }
  $verMajorMinor = "" + $semver.Major + "." + $semver.Minor
  $serviceName = $pkg.ServiceName

  $fields = @()
  $fields += "`"Language=${pkgLang}`""
  $fields += "`"Package=${pkgName}`""
  $fields += "`"PackageDisplayName=${pkgDisplayName}`""
  $fields += "`"PackageType=${pkgType}`""
  $fields += "`"PackageTypeNewLibrary=${pkgNewLibrary}`""
  $fields += "`"PackageVersionMajorMinor=${verMajorMinor}`""
  $fields += "`"ServiceName=${serviceName}`""

  if ($existingItem)
  {
    $shouldUpdate = $false

    if ($pkgLang -ne $existingItem.fields["Custom.Language"]) { $shouldUpdate = $true }
    if ($pkgName -ne $existingItem.fields["Custom.Package"]) { $shouldUpdate = $true }
    if ($verMajorMinor -ne $existingItem.fields["Custom.PackageVersionMajorMinor"]) { $shouldUpdate = $true }
    if ($pkgDisplayName -ne $existingItem.fields["Custom.PackageDisplayName"]) { $shouldUpdate = $true }
    if ($pkgType -ne $existingItem.fields["Custom.PackageType"]) { $shouldUpdate = $true }
    if ($pkgNewLibrary -ne $existingItem.fields["Custom.PackageTypeNewLibrary"]) { $shouldUpdate = $true }
    if ($serviceName -ne $existingItem.fields["Custom.ServiceName"]) { $shouldUpdate = $true }
    if ($title -ne $existingItem.fields["System.Title"]) { $shouldUpdate = $true }

    if ($shouldUpdate) {
      # Need to set to In planning to be able to update
      $existingItem = UpdateWorkItem $existingItem.id $fields -title $title -state "In Planning"
      Write-Host "[$($existingItem.id)]$pkgLang - $pkgName ($verMajorMinor) - Updated"
    }

    $newparentItem = FindOrCreatePackageGroupParent $serviceName $pkgDisplayName
    UpdateWorkItemParent $existingItem $newParentItem

    return $existingItem
  }

  $parentItem = FindOrCreatePackageGroupParent $serviceName $pkgDisplayName
  $workItem = CreateWorkItem $title "Package" "Release" "Release" $fields $parentItem.id
  Write-Host "[$($workItem.id)]$pkgLang - $pkgName ($verMajorMinor) - Created"
  return $workItem
}

function FindOrCreatePackageGroupParent($serviceName, $packageDisplayName) 
{
  $existingItem = FindParentWorkItem $serviceName $packageDisplayName
  if ($existingItem) {
    $newparentItem = FindOrCreateServiceParent $serviceName
    UpdateWorkItemParent $existingItem $newParentItem
    return $existingItem
  }

  $fields = @()
  $fields += "`"PackageDisplayName=${packageDisplayName}`""
  $fields += "`"ServiceName=${serviceName}`""
  $serviceParentItem = FindOrCreateServiceParent $serviceName
  $workItem = CreateWorkItem $packageDisplayName "Epic" "Release" "Release" $fields $serviceParentItem.id

  $localKey = BuildHashKey $serviceName $packageDisplayName
  Write-Host "[$($workItem.id)]$localKey - Created"
  $parentWorkItems[$localKey] = $workItem
  return $workItem 
}

function FindOrCreateServiceParent($serviceName) 
{
  $serviceParent = FindParentWorkItem $serviceName
  if ($serviceParent) {
    return $serviceParent
  }

  $fields = @()
  $fields += "`"PackageDisplayName=`""
  $fields += "`"ServiceName=${serviceName}`""
  $parentId = $null
  $workItem = CreateWorkItem $serviceName "Epic" "Release" "Release" $fields $parentId

  $localKey = BuildHashKey $serviceName
  Write-Host "[$($workItem.id)]$localKey - Created"
  $parentWorkItems[$localKey] = $workItem
  return $workItem
}
function ParseVersionsFromTags($versionsFromTags, $existingShippedVersionSet)
{
  $versionList = @()
  foreach ($v in $versionsFromTags)
  {
    $d = "Unknown"
    if ($existingShippedVersionSet.ContainsKey($v.RawVersion)) {
      # Use cached values from the work items
      $d = $existingShippedVersionSet[$v.RawVersion].Date
    }
    # if we don't have a cached value or the cached value is Unknown look at the 
    # release tag to try and get a date
    if ($d -eq "Unknown") {
      $shaDate = GetCommitterDate $v.ShaUrl
      if ($shaDate) {
        $d = $shaDate.ToString("MM/dd/yyyy")
      }
    }
    $versionList += New-Object PSObject -Property @{
      Type = $v.VersionType
      Version = $v.RawVersion
      Date = $d 
    }
  }
  return ,$versionList
}

function ParseVersionsFromMDField($field)
{
  $MDTableRegex = "\|\s*(?<t>\S*)\s*\|\s*(?<v>\S*)\s*\|\s*(?<d>\S*)\s*\|"
  $versionList = @()
  $tableMatches = [Regex]::Matches($field, $MDTableRegex)

  foreach ($match in $tableMatches)
  {
    if ($match.Groups["t"].Value -eq "Type" -or $match.Groups["t"].Value -eq "-") {
      continue
    }
    $versionList += New-Object PSObject -Property @{
      Type = $match.Groups["t"].Value
      Version = $match.Groups["v"].Value
      Date = $match.Groups["d"].Value
    }
  }
  return ,$versionList
}

function GetTextVersionFields($versionList, $pkgWorkItem)
{
  $betaVersions = $gaVersions = $patchVersions = ""
  foreach ($v in $versionList) {
    $vstr = "$($v.Version),$($v.Date)"
    if ($v.Type -eq "Beta") {
      if ($betaVersions.Length + $vstr.Length -lt 255) {
        if ($betaVersions.Length -gt 0) { $betaVersions += "|" }
        $betaVersions += $vstr
      }
    }
    elseif ($v.Type -eq "GA") {
      if ($gaVersions.Length + $vstr.Length -lt 255) {
        if ($gaVersions.Length -gt 0) { $gaVersions += "|" }
        $gaVersions += $vstr
      }
    }
    elseif ($v.Type -eq "Patch") {
      if ($patchVersions.Length + $vstr.Length -lt 255) {
        if ($patchVersions.Length -gt 0) { $patchVersions += "|" }
        $patchVersions += $vstr
      }
    }
  }

  $fieldUpdates = @()
  if ("$($pkgWorkItem.fields["Custom.PackageBetaVersions"])" -ne $betaVersions)
  {
    $fieldUpdates += @"
{
  "op": "replace",
  "path": "/fields/PackageBetaVersions",
  "value": "$betaVersions"
}
"@
  }

  if ("$($pkgWorkItem.fields["Custom.PackageGAVersion"])" -ne $gaVersions)
  {
    $fieldUpdates += @"
{
  "op": "replace",
  "path": "/fields/PackageGAVersion",
  "value": "$gaVersions"
}
"@
  }

  if ("$($pkgWorkItem.fields["Custom.PackagePatchVersions"])" -ne $patchVersions)
  {
    $fieldUpdates += @"
{
  "op": "replace",
  "path": "/fields/PackagePatchVersions",
  "value": "$patchVersions"
}
"@
  }
  return ,$fieldUpdates
}

function GetMDVersionValue($versionlist)
{
  $mdVersions = ""
  $mdFormat = "| {0} | {1} | {2} |`n"
  $versionlist | ForEach-Object { $mdVersions += ($mdFormat -f $_.Type, $_.Version, $_.Date) }

  $htmlVersions = ""
  $htmlFormat = @"
<tr>
<td>{0}</td>
<td>{1}</td>
<td>{2}</td>
</tr>

"@
  $versionlist | ForEach-Object { $htmlVersions += ($htmlFormat -f $_.Type, $_.Version, $_.Date) }

  $htmlTemplate = @"
<div style='display:none;width:0;height:0;overflow:hidden;position:absolute;font-size:0;' id=__md>| Type | Version | Date |
| - | - | - |
mdVersions
</div><style id=__mdStyle>
.rendered-markdown img {
cursor:pointer;
}

.rendered-markdown h1, .rendered-markdown h2, .rendered-markdown h3, .rendered-markdown h4, .rendered-markdown h5, .rendered-markdown h6 {
color:#007acc;
font-weight:400;
}

.rendered-markdown h1 {
border-bottom:1px solid #e6e6e6;
font-size:26px;
font-weight:600;
margin-bottom:20px;
}

.rendered-markdown h2 {
font-size:18px;
border-bottom:1px solid #e6e6e6;
font-weight:600;
color:#303030;
margin-bottom:10px;
margin-top:20px;
}

.rendered-markdown h3 {
font-size:16px;
font-weight:600;
margin-bottom:10px;
}

.rendered-markdown h4 {
font-size:14px;
margin-bottom:10px;
}

.rendered-markdown h5 {
font-size:12px;
margin-bottom:10px;
}

.rendered-markdown h6 {
font-size:12px;
font-weight:300;
margin-bottom:10px;
}

.rendered-markdown.metaitem {
font-size:12px;
padding-top:15px;
}

.rendered-markdown.metavalue {
font-size:12px;
padding-left:4px;
}

.rendered-markdown.metavalue>img {
height:32px;
width:32px;
margin-bottom:3px;
padding-left:1px;
}

.rendered-markdown li.metavaluelink {
list-style-type:disc;
list-style-position:inside;
}

.rendered-markdown li.metavalue>a {
border:none;
padding:0;
display:inline;
}

.rendered-markdown li.metavalue>a:hover {
background-color:inherit;
text-decoration:underline;
}

.rendered-markdown code, .rendered-markdown pre, .rendered-markdown samp {
font-family:Monaco,Menlo,Consolas,'Droid Sans Mono','Inconsolata','Courier New',monospace;
}

.rendered-markdown code {
color:#333;
background-color:#f8f8f8;
border:1px solid #ccc;
border-radius:3px;
padding:2px 4px;
font-size:90%;
line-height:2;
white-space:nowrap;
}

.rendered-markdown pre {
color:#333;
background-color:#f8f8f8;
border:1px solid #ccc;
display:block;
padding:6px;
font-size:13px;
word-break:break-all;
word-wrap:break-word;
}

.rendered-markdown pre code {
padding:0;
font-size:inherit;
color:inherit;
white-space:pre-wrap;
background-color:transparent;
line-height:1.428571429;
border:none;
}

.rendered-markdown.pre-scrollable {
max-height:340px;
overflow-y:scroll;
}

.rendered-markdown table {
border-collapse:collapse;
}

.rendered-markdown table {
width:auto;
}

.rendered-markdown table, .rendered-markdown th, .rendered-markdown td {
border:1px solid #ccc;
padding:4px;
}

.rendered-markdown th {
font-weight:bold;
background-color:#f8f8f8;
}
</style><div class=rendered-markdown><table>
<thead>
<tr>
<th>Type</th>
<th>Version</th>
<th>Date</th>
</tr>
</thead>
<tbody>htmlVersions</tbody>
</table>
</div>
"@ -replace "'", '\"'

  return $htmlTemplate.Replace("mdVersions", $mdVersions).Replace("htmlVersions", "`n$htmlVersions");
}

function UpdateShippedPackageVersion($pkgWorkItem, $versionsFromTags)
{
  $versionsForDebug = ($versionsFromTags | Foreach-Object { $_.RawVersion} ) -join ","
#  Write-Host $versionsForDebug
  $fieldUpdates = @()
  $versionSet = @{}

  $existingShippedVersionSet = @{}
  (ParseVersionsFromMDField $pkgWorkItem.fields["Custom.ShippedPackages"]) | ForEach-Object { $existingShippedVersionSet[$_.Version] = $_ }

  $shippedVersions = ParseVersionsFromTags $versionsFromTags $existingShippedVersionSet
  foreach ($v in $shippedVersions)
  {
    if (!$versionSet.ContainsKey($v.Version))
    {
      $versionSet[$v.Version] = $v
    }
    else
    {
      Write-Warning "Duplicate version in tags [$($v.Version)] for package [$($pkgWorkItem.fields['Custom.Package'])]".
    }
  }

  $updatePlanned = $false
  $updatedPlannedVersions = @()
  $plannedVersions = ParseVersionsFromMDField $pkgWorkItem.fields["Custom.PlannedPackages"]
  foreach ($v in $plannedVersions)
  {
    if (!$versionSet.ContainsKey($v.Version))
    {
      $versionSet[$v.Version] = $v
      $updatedPlannedVersions += $v
    }
    else
    {
      # If we hit this that means we found a 
      # planned version which we shipped so 
      # update to remove it.
      $updatePlanned = $true
    }
  }

  if ($updatePlanned) 
  {
    $plannedPackages = GetMDVersionValue $updatedPlannedVersions
    $fieldUpdates += @"
{
  "op": "replace",
  "path": "/fields/Planned Packages",
  "value": "$plannedPackages"
}
"@
  }

  # Full merged version set
  $versionList = $versionSet.Values | Sort-Object Date -Descending

  $versionFieldUpdates = GetTextVersionFields $versionList $pkgWorkItem

  # If we have any version field updates lets also include the shipped versions update
  if ($versionFieldUpdates.Count -gt 0)
  {
    $fieldUpdates += $versionFieldUpdates

    $shippedPackages = GetMDVersionValue $shippedVersions
    $fieldUpdates += @"
{
  "op": "replace",
  "path": "/fields/Shipped Packages",
  "value": "$shippedPackages"
}
"@
  }

  # If we shipped a version after we set "In Release" state then reset the state to "Not In Release"
  if ($pkgWorkItem.fields["State"] -eq "In Release")
  {
    $lastShippedDate = [DateTime]$versionList[0].Date
    $markedInReleaseDate = ([DateTime]$pkgWorkItem.fields["Microsoft.VSTS.Common.StateChangeDate"])

    # We just shipped so lets set the state to "Not In Release"
    if ($markedInReleaseDate -le $lastShippedDate)
    {
      $fieldUpdates += @'
{
  "op": "replace",
  "path": "/fields/State",
  "value": "Not In Release"
}
'@
    }
  }

  # If no version files to update do nothing
  if ($fieldUpdates.Count -eq 0) {
    return
  }

  $body = "[" + ($fieldUpdates -join ',') + "]"

  if (!$DevOpsHeaders) {
    throw "env:DEVOPS_PAT is not set!"
  }
  $id = $pkgWorkItem.id
  $loggingString = "[$($pkgWI.id)]"
  $loggingString += "$($pkgWorkItem.fields['Custom.Language'])"
  $loggingString += " - $($pkgWorkItem.fields['Custom.Package'])"
  $loggingString += "($($pkgWorkItem.fields['Custom.PackageVersionMajorMinor'])"
  $loggingString += " - Updating versions $versionsForDebug"
  Write-Host $loggingString
  $response = Invoke-RestMethod -Method PATCH `
    -Uri "https://dev.azure.com/azure-sdk/_apis/wit/workitems/${id}?api-version=6.0" `
    -Headers $DevOpsHeaders -Body $body -ContentType "application/json-patch+json"
}

function PackageMatchesVersionGroup($pkg, $versionGroupToCheck)
{
  if ($pkg.VersionGA -and $pkg.VersionGA.StartsWith($versionGroupToCheck)) {
    return $true
  }

  if ($pkg.VersionPreview -and $pkg.VersionPreview.StartsWith($versionGroupToCheck)) {
    return $true
  }
  return $false
}

function GetWorkItemState($pkg, $versionGroupToCheck)
{
  if (PackageMatchesVersionGroup $pkg $versionGroupToCheck) {
    return "In Release"
  }
  return "No Active Development"
}

function RefreshItems()
{
  InitializeVersionInformation
  FindParentWorkItem $null # Pass null to cache all service parents
  FindPackageWorkItem $null # Pass null to cache all the package items
  $allPackageWorkItems = $packageWorkItems.Values
  if ($pkgFilter) {
    $allPackageWorkItems = $allPackageWorkItems | Where-Object { $_.fields["Custom.Package"] -like $pkgFilter }
  }

  ## Loop over all package work items
  foreach ($pkgWI in $allPackageWorkItems)
  {
    $pkgLang = $pkgWI.fields["Custom.Language"]
    $pkgName = $pkgWI.fields["Custom.Package"]
    $version = $pkgWI.fields["Custom.PackageVersionMajorMinor"]

    if (!$pkgLang -or !$pkgName -or !$version) {
      Write-Warning "Skipping item $($pkgWI.id) becaue it doesn't have one or all of the required language, package, or version fields."
      continue
    }

    $semver = ToSemVer $version
    if (!$semver) { 
      Write-Warning "Version for item $($pkgWI.id) is set to [$version] which is not a valid version. Skipping"
      continue
    }

    $verMajorMinor = "" + $semver.Major + "." + $semver.Minor
    if ($semver.Patch -ne 0) {
      Write-Host "Version for item $($pkgWI.id) has more then major and minor [$version] so stripping the version down to [$verMajorMinor]."
    }

    $pkgInfo = GetVersionInfo $pkgLang $pkgName
    $verInfo = $null

    if ($pkgInfo) {
      $verInfo = $pkgInfo.VersionGroups[$verMajorMinor]
    }
    else {
      #TODO: We should figure out if we can import workitem information into the csv file from this item.
      Write-Warning "[$($pkgWI.id)]$pkgLang - $pkgName ($verMajorMinor) - Skipping as this looks like brand new package because we don't have any versioning information."
      continue
    }

    Write-Verbose "[$($pkgWI.id)]$pkgLang - $pkgName ($verMajorMinor)"
    $updatedWI = CreateOrUpdatePackageWorkItem $pkgLang $pkgInfo.PackageInfo $verMajorMinor $pkgWI
    if ($verInfo) {
      UpdateShippedPackageVersion $updatedWI $verInfo.Versions
    }
  }

  ## Loop over all packages in csv
  foreach ($pkgLang in $allVersions.Keys)
  {
    foreach ($pkgName in $allVersions[$pkgLang].Keys)
    {
      foreach ($verMajorMinor in $allVersions[$pkgLang][$pkgName].VersionGroups.Keys)
      {
        $verInfo = $allVersions[$pkgLang][$pkgName].VersionGroups[$verMajorMinor]

        $pkgWI = FindPackageWorkItem $pkgLang $pkgName $verMajorMinor
        if (!$pkgWI) 
        {
          $pkgWI = CreateOrUpdatePackageWorkItem $pkgLang $verInfo.PackageInfo $verMajorMinor
          Write-Verbose "[$($pkgWI.id)]$pkgLang - $pkgName ($verMajorMinor)"
          UpdateShippedPackageVersion $pkgWI $verInfo.Versions
        }
      }
    }
  }
}

RefreshItems
