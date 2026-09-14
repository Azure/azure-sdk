#Requires -Version 7.0
#Requires -Modules @{ ModuleName = 'Pester'; ModuleVersion = '5.7.1' }

Describe 'Package names (issue 16628)' {
  BeforeAll {
    Set-StrictMode -Version 4
    $ErrorActionPreference = 'Stop'
    $scriptsPath = Split-Path $PSScriptRoot -Parent

    # These helpers only define functions/classes and initialize local caches.
    # Preserve the two process-wide flags initialized by the DevOps helper.
    $previousDevOpsFlags = @{}
    foreach ($name in @('AzLoginAndDevOpsExtensionInstallComplete', 'HasDevOpsAccess')) {
      $variable = Get-Variable -Name $name -Scope Global -ErrorAction Ignore
      $previousDevOpsFlags[$name] = @{
        Exists = $null -ne $variable
        Value = if ($variable) { $variable.Value } else { $null }
      }
    }
    . (Join-Path $scriptsPath 'PackageList-Helpers.ps1')
    . (Join-Path $scriptsPath '../common/scripts/Helpers/DevOps-WorkItem-Helpers.ps1')

    # Never run either entrypoint: they authenticate, query registries, and write CSVs.
    # Import only top-level function declarations, with their bodies unchanged.
    foreach ($file in @('Query-Azure-Packages.ps1', 'Update-DevOps-WorkItems.ps1')) {
      $tokens = $null
      $parseErrors = $null
      $ast = [System.Management.Automation.Language.Parser]::ParseFile(
        (Join-Path $scriptsPath $file), [ref]$tokens, [ref]$parseErrors)
      if ($parseErrors.Count -ne 0) {
        throw ($parseErrors.Message -join [Environment]::NewLine)
      }
      foreach ($statement in $ast.EndBlock.Statements) {
        if ($statement -is [System.Management.Automation.Language.FunctionDefinitionAst]) {
          . ([scriptblock]::Create($statement.Extent.Text))
        }
      }
    }

    $originalLanguageMapping = $languageNameMapping.Clone()
    $language = 'all'
    $updateDeprecated = $false
    $updateAllVersions = $false
    $ignoreReleasePlannerTests = $true
    $pkgFilter = $null
    $allVersions = @{}
    $allPackagesFromCSV = @{}
    $allLangPkgVersions = @{}

    function Deny-TestExternalCall([string]$Operation) {
      $script:unexpectedCalls.Add($Operation)
      throw "External IO is forbidden in these tests: $Operation"
    }

    # Shadow native commands even on machines without Python or Azure CLI installed.
    # Pester mocks these local functions, never an executable on PATH.
    function python([string]$c) { Deny-TestExternalCall "python -c $c" }
    function az { Deny-TestExternalCall 'az' }
    function gh { Deny-TestExternalCall 'gh' }
    function git { Deny-TestExternalCall 'git' }

    function Reset-TestSyncCaches {
      $allVersions.Clear()
      $allPackagesFromCSV.Clear()
      $allLangPkgVersions.Clear()
      $parentWorkItems.Clear()
      $packageWorkItems.Clear()
      $packageWorkItemWithoutKeyFields.Clear()
    }

    function Save-TestPackageList([string]$Language, [object[]]$Packages) {
      # Copy rows so a later pass cannot retroactively change an earlier assertion.
      $script:csvWrites.Add([pscustomobject]@{
        Language = $Language
        Packages = @($Packages | ForEach-Object { $_.PSObject.Copy() })
      })
    }

    function Assert-UnreviewedPackage(
      [object]$Actual,
      [string]$Package,
      [string]$VersionGA = '1.2.0',
      [string]$VersionPreview = '',
      [string]$Type = 'mgmt',
      [string]$New = 'true',
      [string]$RepoPath = 'NA'
    ) {
      $Actual.Package | Should -BeExactly $Package
      $Actual.DisplayName | Should -BeExactly 'unknown'
      $Actual.ServiceName | Should -BeExactly 'unknown'
      $Actual.Notes | Should -BeExactly 'Needs Review'
      $Actual.VersionGA | Should -BeExactly $VersionGA
      $Actual.VersionPreview | Should -BeExactly $VersionPreview
      $Actual.Type | Should -BeExactly $Type
      $Actual.New | Should -BeExactly $New
      $Actual.RepoPath | Should -BeExactly $RepoPath
    }

    function Convert-TestWorkItemFields([object[]]$Assignments) {
      $fields = @{}
      foreach ($assignment in $Assignments) {
        $name, $value = ([string]$assignment).Trim('"') -split '=', 2
        if ($name -notmatch '^(Custom|System)\.') {
          $name = "Custom.$name"
        }
        if ($name -eq 'Custom.PackageTypeNewLibrary') {
          $value = [bool]::Parse($value)
        }
        $fields[$name] = $value
      }
      return $fields
    }

    function New-TestWorkItem(
      [int]$Id,
      [string]$Type,
      [string]$Title,
      [hashtable]$Fields,
      [object]$ParentId = $null
    ) {
      $item = @{
        id = $Id
        fields = @{
          'System.WorkItemType' = $Type
          'System.Title' = $Title
          'System.State' = 'Next Release Unknown'
          'System.Parent' = $ParentId
          'System.Tags' = ''
          'Custom.GroupId' = $null
          'Custom.PlannedPackages' = ''
          'Custom.ShippedPackages' = ''
          'Custom.PackageBetaVersions' = ''
          'Custom.PackageGAVersion' = ''
          'Custom.PackagePatchVersions' = ''
        }
      }
      foreach ($name in $Fields.Keys) {
        $item.fields[$name] = $Fields[$name]
      }
      $script:workItemStore[$Id] = $item
      return $item
    }

    function Add-TestParents(
      [int]$ServiceId,
      [int]$ProductId,
      [string]$ServiceName,
      [string]$DisplayName
    ) {
      $null = New-TestWorkItem $ServiceId 'Epic' $ServiceName @{
        'Custom.ServiceName' = $ServiceName
        'Custom.PackageDisplayName' = ''
        'Custom.EpicType' = 'Service'
      }
      $null = New-TestWorkItem $ProductId 'Epic' $DisplayName @{
        'Custom.ServiceName' = $ServiceName
        'Custom.PackageDisplayName' = $DisplayName
        'Custom.EpicType' = 'Product'
      } $ServiceId
    }

    function Add-TestPackageWorkItem(
      [string]$ServiceName = 'unknown',
      [string]$DisplayName = 'unknown',
      [int]$ParentId = 102
    ) {
      return New-TestWorkItem 501 'Package' "Python - $DisplayName - 1.2" @{
        'Custom.Language' = 'Python'
        'Custom.Package' = 'azure-mgmt-agricultureplatform'
        'Custom.PackageVersionMajorMinor' = '1.2'
        'Custom.PackageDisplayName' = $DisplayName
        'Custom.ServiceName' = $ServiceName
        'Custom.PackageType' = 'mgmt'
        'Custom.PackageTypeNewLibrary' = $true
        'Custom.PackageRepoPath' = 'agricultureplatform'
      } $ParentId
    }

    function Select-TestWorkItems([string]$Wiql) {
      # Only the read-only predicates emitted by the real cache/lookup helpers.
      if ($Wiql -notmatch "\[Work Item Type\] = '(Epic|Package)'") {
        Deny-TestExternalCall "Unsupported WIQL: $Wiql"
      }
      $type = $Matches[1]
      $items = @($script:workItemStore.Values.Where({ $_.fields['System.WorkItemType'] -eq $type }))
      foreach ($name in @('ServiceName', 'PackageDisplayName', 'Language', 'Package', 'GroupId', 'PackageVersionMajorMinor')) {
        if ($Wiql -match "\[$name\] = '([^']*)'") {
          $value = $Matches[1]
          $items = @($items.Where({ $_.fields["Custom.$name"] -eq $value }))
        }
      }
      return $items
    }
  }

  AfterAll {
    foreach ($name in $previousDevOpsFlags.Keys) {
      if ($previousDevOpsFlags[$name].Exists) {
        Set-Variable -Name $name -Scope Global -Value $previousDevOpsFlags[$name].Value
      }
      else {
        Remove-Variable -Name $name -Scope Global -ErrorAction Ignore
      }
    }
  }

  BeforeEach {
    Reset-TestSyncCaches
    $languageNameMapping.Clear()
    foreach ($name in $originalLanguageMapping.Keys) {
      $languageNameMapping[$name] = $originalLanguageMapping[$name]
    }
    $script:unexpectedCalls = [System.Collections.Generic.List[string]]::new()
    $script:csvRows = @()
    $script:csvWrites = [System.Collections.Generic.List[object]]::new()

    # Every external boundary fails closed unless a test supplies a fixture.
    Mock Invoke-RestMethod { Deny-TestExternalCall "HTTP $Method $Uri" }
    Mock Invoke-WebRequest { Deny-TestExternalCall "HTTP $Method $Uri" }
    Mock python { Deny-TestExternalCall 'python' }
    Mock az { Deny-TestExternalCall 'az' }
    Mock gh { Deny-TestExternalCall 'gh' }
    Mock git { Deny-TestExternalCall 'git' }
    Mock GetPackageVersions { Deny-TestExternalCall 'GetPackageVersions' }
    Mock GetLatestTags { Deny-TestExternalCall 'GetLatestTags' }
    Mock Get-GitHubHeaders { Deny-TestExternalCall 'Get-GitHubHeaders' }
    Mock Get-GitHubTag { Deny-TestExternalCall 'Get-GitHubTag' }
    Mock New-GitHubTag { Deny-TestExternalCall 'New-GitHubTag' }
    Mock Get-DevOpsRestHeaders { Deny-TestExternalCall 'Get-DevOpsRestHeaders' }
    Mock CheckAzLoginAndDevOpsExtensionInstall { Deny-TestExternalCall 'Azure login' }
    Mock CheckDevOpsAccess { Deny-TestExternalCall 'DevOps access check' }
    Mock Invoke-AzBoardsCmd { Deny-TestExternalCall 'Invoke-AzBoardsCmd' }
    Mock Invoke-Query { Deny-TestExternalCall "ADO query: $wiql" }
    Mock CreateWorkItem { Deny-TestExternalCall 'CreateWorkItem' }
    Mock UpdateWorkItem { Deny-TestExternalCall 'UpdateWorkItem' }
    Mock CreateWorkItemParent { Deny-TestExternalCall 'CreateWorkItemParent' }
    Mock CreateWorkItemRelation { Deny-TestExternalCall 'CreateWorkItemRelation' }
    Mock GetWorkItemRelatedLinkIds { Deny-TestExternalCall 'GetWorkItemRelatedLinkIds' }
    Mock Get-PackageListForLanguage { Deny-TestExternalCall 'Read repository CSV' }
    Mock Set-PackageListForLanguage { Deny-TestExternalCall 'Write repository CSV' }
    Mock GetLinkTemplates { Deny-TestExternalCall 'Read repository link templates' }
    Mock Write-Nuget-Deprecated-Packages { Deny-TestExternalCall 'NuGet deprecation writes' }
    Mock Read-Host { Deny-TestExternalCall 'Interactive prompt' }
  }

  AfterEach {
    # Also detect forbidden calls swallowed by production catch blocks (e.g. PyPI).
    $script:unexpectedCalls | Should -BeNullOrEmpty
    Should -Invoke az -Times 0 -Exactly -Scope It
    Should -Invoke gh -Times 0 -Exactly -Scope It
    Should -Invoke git -Times 0 -Exactly -Scope It
    Should -Invoke GetLatestTags -Times 0 -Exactly -Scope It
    Should -Invoke Invoke-WebRequest -Times 0 -Exactly -Scope It
  }

  Context 'CreatePackage' {
    It 'preserves raw coordinates and version <Version>' -ForEach @(
      @{ Package = 'Azure.ResourceManager.ResourceHealth'; GroupId = ''; Version = '1.2.3'; GA = '1.2.3'; Preview = '' }
      @{ Package = 'azure-resourcemanager-agricultureplatform'; GroupId = 'com.azure.ResourceManager'; Version = '2.0.0-beta.1'; GA = ''; Preview = '2.0.0-beta.1' }
      @{ Package = 'azure-mgmt-dns'; GroupId = ''; Version = '1.2.0b2'; GA = ''; Preview = '1.2.0b2' }
      @{ Package = 'sdk/resourcemanager/apimanagement/armapimanagement'; GroupId = ''; Version = '0.4.0'; GA = ''; Preview = '0.4.0' }
      @{ Package = '@azure/arm-apimanagement'; GroupId = ''; Version = '5.2'; GA = '5.2'; Preview = '' }
    ) {
      $actual = CreatePackage $Package $Version $GroupId

      Assert-UnreviewedPackage $actual $Package -VersionGA $GA -VersionPreview $Preview -Type '' -New 'false'
      if ($GroupId) {
        $actual.GroupId | Should -BeExactly $GroupId
      }
      else {
        $actual.PSObject.Properties.Name | Should -Not -Contain 'GroupId'
      }
    }
  }

  Context 'Actual registry discovery' {
    BeforeDiscovery {
      $discoveryCases = @(
        @{ Lang = 'java'; Package = 'azure-resourcemanager-agricultureplatform'; GroupId = 'com.azure.resourcemanager'; QualifiedTag = $true }
        @{ Lang = 'java'; Package = 'azure-resourcemanager-resourcehealth'; GroupId = 'com.azure.resourcemanager' }
        @{ Lang = 'java'; Package = 'azure-resourcemanager-dns'; GroupId = 'com.azure.resourcemanager'; QualifiedTag = $true }
        @{ Lang = 'java'; Package = 'azure-resourcemanager-apimanagement'; GroupId = 'com.azure.resourcemanager' }
        @{ Lang = 'java'; Package = 'azure-resourcemanager-dns'; GroupId = 'com.azure.resourcemanager'; Tagged = $false; Type = ''; New = 'false' }
        @{ Lang = 'java'; Package = 'azure-resourcemanager-dns'; GroupId = 'com.microsoft.azure'; Type = ''; New = 'false' }
        @{ Lang = 'dotnet'; Package = 'Azure.ResourceManager.AgriculturePlatform' }
        @{ Lang = 'dotnet'; Package = 'Azure.ResourceManager.ResourceHealth' }
        @{ Lang = 'dotnet'; Package = 'Azure.ResourceManager.Dns' }
        @{ Lang = 'dotnet'; Package = 'Azure.ResourceManager.ApiManagement' }
        @{ Lang = 'dotnet'; Package = 'Azure.Provisioning.AgriculturePlatform' }
        @{ Lang = 'dotnet'; Package = 'Azure.Provisioning.ResourceHealth' }
        @{ Lang = 'dotnet'; Package = 'Azure.Provisioning.Dns' }
        @{ Lang = 'dotnet'; Package = 'Azure.Provisioning.ApiManagement' }
        @{ Lang = 'dotnet'; Package = 'Azure.ResourceManager.Dns'; Tagged = $false; Type = ''; New = 'false' }
        @{ Lang = 'dotnet'; Package = 'Azure.Provisioning.Dns'; Tagged = $false; Type = ''; New = 'false' }
        @{ Lang = 'js'; Package = '@azure/arm-agricultureplatform' }
        @{ Lang = 'js'; Package = '@azure/arm-resourcehealth' }
        @{ Lang = 'js'; Package = '@azure/arm-dns' }
        @{ Lang = 'js'; Package = '@azure/arm-apimanagement' }
        @{ Lang = 'js'; Package = '@azure/arm-dns'; Tagged = $false; Type = ''; New = 'false' }
        @{ Lang = 'python'; Package = 'azure-mgmt-agricultureplatform' }
        @{ Lang = 'python'; Package = 'azure-mgmt-resourcehealth' }
        @{ Lang = 'python'; Package = 'azure-mgmt-dns' }
        @{ Lang = 'python'; Package = 'azure-mgmt-apimanagement' }
        @{ Lang = 'python'; Package = 'azure-mgmt-dns'; Tagged = $false; Type = ''; New = 'false' }
        @{ Lang = 'go'; Package = 'sdk/resourcemanager/agricultureplatform/armagricultureplatform'; RepoPath = 'resourcemanager/agricultureplatform/armagricultureplatform' }
        @{ Lang = 'go'; Package = 'sdk/resourcemanager/resourcehealth/armresourcehealth'; RepoPath = 'resourcemanager/resourcehealth/armresourcehealth' }
        @{ Lang = 'go'; Package = 'sdk/resourcemanager/dns/armdns'; RepoPath = 'resourcemanager/dns/armdns' }
        @{ Lang = 'go'; Package = 'sdk/resourcemanager/apimanagement/armapimanagement'; RepoPath = 'resourcemanager/apimanagement/armapimanagement' }
        @{ Lang = 'go'; Package = 'sdk/agricultureplatform/azagricultureplatform'; Type = 'client'; RepoPath = 'agricultureplatform/azagricultureplatform' }
        @{ Lang = 'go'; Package = 'sdk/dns/azdns'; Type = 'client'; RepoPath = 'dns/azdns' }
      )
      foreach ($case in $discoveryCases) {
        foreach ($default in @{
          GroupId = ''; QualifiedTag = $false; Tagged = $true; Type = 'mgmt'; New = 'true'; RepoPath = 'NA'
        }.GetEnumerator()) {
          if (!$case.ContainsKey($default.Key)) {
            $case[$default.Key] = $default.Value
          }
        }
      }
    }

    BeforeEach {
      $script:discoveryLang = ''
      $script:registryPackage = $null
      $script:registryGroupId = ''
      $script:registryTags = @{}
      Mock GetPackageVersions { return $script:registryTags } -ParameterFilter { $lang -eq $script:discoveryLang }

      Mock Invoke-RestMethod {
        if ($Uri -match '&start=1$') {
          return @{ response = @{ numFound = 1; docs = @() } }
        }
        if ($Uri -match '&start=') { Deny-TestExternalCall "Unexpected Maven page: $Uri" }
        return @{ response = @{ numFound = 1; docs = @(
          @{ a = $script:registryPackage; g = $script:registryGroupId; latestVersion = '1.2.0' }
        ) } }
      } -ParameterFilter {
        $script:discoveryLang -eq 'java' -and $Uri -like 'https://central.sonatype.com/solrsearch/select?*'
      }

      Mock Invoke-RestMethod {
        return @{ totalHits = 1; data = @(@{ id = $script:registryPackage; version = '1.2.0' }) }
      } -ParameterFilter {
        $script:discoveryLang -eq 'dotnet' -and $Uri -like 'https://azuresearch-usnc.nuget.org/query?*&skip=0'
      }

      Mock Invoke-RestMethod {
        if ($Uri -match '&from=1$') { return @{ objects = @() } }
        if ($Uri -notmatch '&from=0$') { Deny-TestExternalCall "Unexpected npm page: $Uri" }
        return @{ objects = @(@{ package = @{
          name = $script:registryPackage
          version = '1.2.0'
          publisher = @{ username = 'azure-sdk' }
        } }) }
      } -ParameterFilter {
        $script:discoveryLang -eq 'js' -and $Uri -like 'https://registry.npmjs.com/-/v1/search?*'
      }

      # Real registries contain multiple packages. Keep an untagged client as a
      # control and avoid PowerShell collapsing a singleton to a scalar under strict mode.
      Mock python { return @($script:registryPackage, 'azure-core') } -ParameterFilter {
        $script:discoveryLang -eq 'python' -and $c -match "user_packages\('azure-sdk'\)"
      }
      Mock python { return @($script:registryPackage, 'azure-core') } -ParameterFilter {
        $script:discoveryLang -eq 'python' -and $c -match "user_packages\('microsoft'\)"
      }
      Mock Invoke-RestMethod {
        $packageName = ([uri]$Uri).Segments[-2].TrimEnd('/')
        return [pscustomobject]@{
          info = @{ name = $packageName; version = '1.1.0'; keywords = 'azure sdk' }
          releases = [pscustomobject]@{ '1.1.0' = @(); '1.2.0' = @() }
        }
      } -ParameterFilter {
        $script:discoveryLang -eq 'python' -and $Uri -in @(
          "https://pypi.org/pypi/$script:registryPackage/json", 'https://pypi.org/pypi/azure-core/json'
        )
      }
    }

    It '<Lang>: <GroupId> <Package> keeps unknown names (recent tag: <Tagged>)' -ForEach $discoveryCases {
      $script:discoveryLang = $Lang
      $script:registryPackage = $Package
      $script:registryGroupId = $GroupId
      if ($Tagged) {
        $tagKey = if ($QualifiedTag) { "$GroupId+$Package" } else { $Package }
        $script:registryTags[$tagKey] = [pscustomobject]@{
          Versions = @((ToSemVer '1.1.0'), (ToSemVer '1.2.0'))
        }
      }

      $actual = @(& "Get-$Lang-Packages")

      $expectedCount = if ($Lang -eq 'python') { 2 } else { 1 }
      $actual | Should -HaveCount $expectedCount
      $matched = @($actual.Where({ $_.Package -ceq $Package }))
      $matched | Should -HaveCount 1
      Assert-UnreviewedPackage $matched[0] $Package -Type $Type -New $New -RepoPath $RepoPath
      if ($GroupId) { $matched[0].GroupId | Should -BeExactly $GroupId }
      Should -Invoke GetPackageVersions -Times 1 -Exactly -Scope It -ParameterFilter { $lang -eq $script:discoveryLang }
      $httpCalls = @{ java = 2; dotnet = 1; js = 2; python = 2; go = 0 }
      Should -Invoke Invoke-RestMethod -Times $httpCalls[$Lang] -Exactly -Scope It
      if ($Lang -eq 'python') {
        $client = @($actual.Where({ $_.Package -eq 'azure-core' }))
        $client | Should -HaveCount 1
        Assert-UnreviewedPackage $client[0] 'azure-core' -Type '' -New 'false'
        $pythonCommand = Get-Command python
        # Pester exposes its mock function through an alias proxy.
        if ($pythonCommand -is [System.Management.Automation.AliasInfo]) {
          $pythonCommand = $pythonCommand.ResolvedCommand
        }
        $pythonCommand.CommandType | Should -Be 'Function'
        Should -Invoke python -Times 1 -Exactly -Scope It -ParameterFilter { $c -match "user_packages\('azure-sdk'\)" }
        Should -Invoke python -Times 1 -Exactly -Scope It -ParameterFilter { $c -match "user_packages\('microsoft'\)" }
      }
      else {
        Should -Invoke python -Times 0 -Exactly -Scope It
      }
    }

    It 'still excludes Go arm modules outside the resourcemanager directory' {
      $script:discoveryLang = 'go'
      $script:registryTags['sdk/dns/armdns'] = @{ Versions = @((ToSemVer '1.2.0')) }

      $actual = @(Get-go-Packages)

      $actual | Should -HaveCount 0
      Should -Invoke GetPackageVersions -Times 1 -Exactly -Scope It
      Should -Invoke Invoke-RestMethod -Times 0 -Exactly -Scope It
    }
  }

  Context 'Actual Write-Latest-Versions with real lookup helpers' {
    BeforeEach {
      $script:queriedPackages = @()
      Mock Get-java-Packages { return $script:queriedPackages }
      Mock Get-PackageListForLanguage { return ,$script:csvRows } -ParameterFilter { $lang -eq 'java' }
      Mock Set-PackageListForLanguage { Save-TestPackageList $lang $packageList } -ParameterFilter { $lang -eq 'java' }
    }

    It 'adds an unresolved row without inventing a service or display name' {
      $package = CreatePackage 'azure-resourcemanager-agricultureplatform' '1.2.0' 'com.azure.resourcemanager'
      $package.Type = 'mgmt'
      $package.New = 'true'
      $script:queriedPackages = @($package)

      Write-Latest-Versions 'java'

      $script:csvWrites | Should -HaveCount 1
      $script:csvWrites[0].Language | Should -BeExactly 'java'
      $script:csvWrites[0].Packages | Should -HaveCount 1
      Assert-UnreviewedPackage $script:csvWrites[0].Packages[0] $package.Package
      $script:csvWrites[0].Packages[0].GroupId | Should -BeExactly 'com.azure.resourcemanager'
    }

    It 'preserves curated names and Notes while updating to <Version>' -ForEach @(
      @{ Version = '1.3.0'; GA = '1.3.0'; Preview = '' }
      @{ Version = '1.3.0-beta.2'; GA = '1.1.0'; Preview = '1.3.0-beta.2' }
    ) {
      $existing = CreatePackage 'azure-resourcemanager-apimanagement' '1.1.0' 'com.azure.resourcemanager'
      $existing.VersionPreview = '1.2.0-beta.1'
      $existing.DisplayName = 'API Management'
      $existing.ServiceName = 'API Management Service'
      $existing.Notes = 'Reviewed, preserve "API" branding'
      $script:csvRows = @($existing)
      $queried = CreatePackage $existing.Package $Version $existing.GroupId
      $queried.Type = 'mgmt'
      $queried.New = 'true'
      $script:queriedPackages = @($queried)

      Write-Latest-Versions 'java'

      $script:csvWrites[0].Packages | Should -HaveCount 1
      $actual = $script:csvWrites[0].Packages[0]
      $actual.Package | Should -BeExactly $existing.Package
      $actual.GroupId | Should -BeExactly 'com.azure.resourcemanager'
      $actual.DisplayName | Should -BeExactly 'API Management'
      $actual.ServiceName | Should -BeExactly 'API Management Service'
      $actual.Notes | Should -BeExactly 'Reviewed, preserve "API" branding'
      $actual.VersionGA | Should -BeExactly $GA
      $actual.VersionPreview | Should -BeExactly $Preview
      $actual.Type | Should -BeExactly 'mgmt'
      $actual.New | Should -BeExactly 'true'
    }

    It 'uses GroupId when updating identically named Java artifacts' {
      $legacy = CreatePackage 'azure-resourcemanager-dns' '1.0.0' 'com.microsoft.azure'
      $legacy.DisplayName = 'Legacy DNS'
      $modern = CreatePackage $legacy.Package '1.1.0' 'com.azure.resourcemanager'
      $modern.DisplayName = 'DNS'
      $modern.ServiceName = 'DNS Service'
      $modern.Notes = 'Reviewed DNS names'
      $script:csvRows = @($legacy, $modern)
      $script:queriedPackages = @(CreatePackage $modern.Package '1.2.0' $modern.GroupId)

      Write-Latest-Versions 'java'

      $actual = $script:csvWrites[0].Packages
      $actual | Should -HaveCount 2
      $actual[0].VersionGA | Should -BeExactly '1.0.0'
      $actual[0].DisplayName | Should -BeExactly 'Legacy DNS'
      $actual[1].VersionGA | Should -BeExactly '1.2.0'
      $actual[1].DisplayName | Should -BeExactly 'DNS'
      $actual[1].ServiceName | Should -BeExactly 'DNS Service'
      $actual[1].Notes | Should -BeExactly 'Reviewed DNS names'
    }

    It 'still suppresses new alpha-only packages while adding a released package' {
      $alpha = CreatePackage 'azure-resourcemanager-dns' '2.0.0-alpha.20260911.1' 'com.azure.resourcemanager'
      $released = CreatePackage 'azure-resourcemanager-resourcehealth' '1.2.0' 'com.azure.resourcemanager'
      $script:queriedPackages = @($alpha, $released)

      Write-Latest-Versions 'java'

      $script:csvWrites[0].Packages | Should -HaveCount 1
      $script:csvWrites[0].Packages.Package | Should -BeExactly $released.Package
      $script:csvWrites[0].Packages.Package | Should -Not -Contain $alpha.Package
      $script:csvWrites[0].Packages[0].DisplayName | Should -BeExactly 'unknown'
    }
  }

  Context 'Actual RefreshItems and shared package/parent helpers' {
    BeforeEach {
      # Limit real InitializeVersionInformation to one language, using in-memory CSV/tag IO.
      $languageNameMapping.Clear()
      $languageNameMapping['python'] = 'Python'
      $script:workItemStore = @{}
      $script:nextWorkItemId = 1000
      $script:createdItems = [System.Collections.Generic.List[object]]::new()
      $script:parentChanges = [System.Collections.Generic.List[object]]::new()
      $script:fieldUpdates = [System.Collections.Generic.List[object]]::new()
      $row = CreatePackage 'azure-mgmt-agricultureplatform' '1.2.0'
      $row.New = 'true'
      $row.Type = 'mgmt'
      $script:csvRows = @($row)
      $script:syncTags = @{
        $row.Package = @{ Versions = @((ToSemVer '1.2.0' '01/02/2025')) }
      }

      Mock Get-PackageListForLanguage { return ,$script:csvRows } -ParameterFilter { $lang -eq 'python' }
      Mock Set-PackageListForLanguage { Save-TestPackageList $lang $packageList } -ParameterFilter { $lang -eq 'python' }
      Mock GetPackageVersions { return $script:syncTags } -ParameterFilter { $lang -eq 'python' }
      Mock Invoke-Query { return Select-TestWorkItems $wiql }
      Mock Get-DevOpsRestHeaders { return @{} }

      # Stub only persistence. CreateOrUpdatePackageWorkItem, both parent helpers,
      # cache initialization/lookups, cloning, reparenting and version merging are real.
      Mock CreateWorkItem {
        $script:nextWorkItemId++
        $item = New-TestWorkItem $script:nextWorkItemId $type $title (Convert-TestWorkItemFields $fields) $parentId
        $item.fields['System.State'] = 'New'
        $script:createdItems.Add($item)
        return $item
      } -ParameterFilter { $type -in @('Epic', 'Package') }

      Mock UpdateWorkItem {
        if (!$script:workItemStore.ContainsKey([int]$id)) { throw "Unknown test work item: $id" }
        $item = $script:workItemStore[[int]$id]
        $updates = Convert-TestWorkItemFields $fields
        foreach ($name in $updates.Keys) { $item.fields[$name] = $updates[$name] }
        if ($title) { $item.fields['System.Title'] = $title }
        if ($state) { $item.fields['System.State'] = $state }
        $script:fieldUpdates.Add(@{ Id = $id; Fields = $updates; Title = $title; State = $state })
        return $item
      }

      Mock CreateWorkItemParent {
        if (!$script:workItemStore.ContainsKey([int]$id) -or !$script:workItemStore.ContainsKey([int]$parentId)) {
          throw "Unknown test relationship: $id -> $parentId"
        }
        $script:parentChanges.Add(@{ Id = $id; ParentId = $parentId; OldParentId = $oldParentId })
        $script:workItemStore[[int]$id].fields['System.Parent'] = $parentId
      }

      Mock Invoke-RestMethod {
        $id = [int]([uri]$Uri).Segments[-1]
        if (!$script:workItemStore.ContainsKey($id)) { throw "Unknown test PATCH work item: $id" }
        $item = $script:workItemStore[$id]
        foreach ($patch in @($Body | ConvertFrom-Json)) {
          if ($patch.op -ne 'replace') { throw "Unsupported test PATCH operation: $($patch.op)" }
          $name = $patch.path -replace '^/fields/', '' -replace ' ', ''
          if ($name -eq 'State') { $name = 'System.State' } else { $name = "Custom.$name" }
          $item.fields[$name] = $patch.value
        }
        return $item
      } -ParameterFilter {
        $Method -eq 'Patch' -and $Uri -match '^https://dev\.azure\.com/azure-sdk/_apis/wit/workitems/\d+\?api-version=6\.0$'
      }

      # Synthetic IDs only; these objects are never sent to Azure DevOps.
      Add-TestParents 101 102 'unknown' 'unknown'
      Add-TestParents 201 202 'Agriculture Platform' 'Agriculture Platform - Management'
    }

    It 'keeps a newly discovered Package WI under the existing unknown parents' {
      $item = Add-TestPackageWorkItem

      RefreshItems

      $item.fields['Custom.PackageDisplayName'] | Should -BeExactly 'unknown'
      $item.fields['Custom.ServiceName'] | Should -BeExactly 'unknown'
      $item.fields['System.Parent'] | Should -Be 102
      $script:workItemStore[102].fields['System.Parent'] | Should -Be 101
      $script:createdItems | Should -HaveCount 0
      $script:parentChanges | Should -HaveCount 0
      $script:csvWrites | Should -HaveCount 1
      Assert-UnreviewedPackage $script:csvWrites[0].Packages[0] 'azure-mgmt-agricultureplatform' -RepoPath 'agricultureplatform'
      $item.fields['Custom.PackageGAVersion'] | Should -BeExactly '1.2.0,01/02/2025'
      Should -Invoke Invoke-Query -Times 2 -Exactly -Scope It
    }

    It 'creates a CSV-only Package WI under the existing unknown parent, with no placeholder Epics' {
      RefreshItems
      Reset-TestSyncCaches
      RefreshItems

      $script:createdItems | Should -HaveCount 1
      $item = $script:createdItems[0]
      $item.fields['System.WorkItemType'] | Should -BeExactly 'Package'
      $item.fields['Custom.Package'] | Should -BeExactly 'azure-mgmt-agricultureplatform'
      $item.fields['Custom.PackageDisplayName'] | Should -BeExactly 'unknown'
      $item.fields['Custom.ServiceName'] | Should -BeExactly 'unknown'
      $item.fields['System.Parent'] | Should -Be 102
      $script:workItemStore[102].fields['System.Parent'] | Should -Be 101
      $script:parentChanges | Should -HaveCount 0
      $script:csvWrites | Should -HaveCount 2
      Should -Invoke CreateWorkItem -Times 0 -Exactly -Scope It -ParameterFilter { $type -eq 'Epic' }
      Should -Invoke CreateWorkItem -Times 1 -Exactly -Scope It -ParameterFilter { $type -eq 'Package' -and $parentId -eq 102 }
    }

    It 'recognizes legacy Unknown placeholders as a passing control for the sync fixture' {
      $script:csvRows[0].DisplayName = 'Unknown Display Name'
      $script:csvRows[0].ServiceName = 'Unknown Service'
      $item = Add-TestPackageWorkItem 'Agriculture Platform' 'Agriculture Platform - Management' 202

      RefreshItems

      $item.fields['Custom.PackageDisplayName'] | Should -BeExactly 'Agriculture Platform - Management'
      $item.fields['Custom.ServiceName'] | Should -BeExactly 'Agriculture Platform'
      $item.fields['System.Parent'] | Should -Be 202
      $script:csvWrites[0].Packages[0].DisplayName | Should -BeExactly 'Agriculture Platform - Management'
      $script:csvWrites[0].Packages[0].ServiceName | Should -BeExactly 'Agriculture Platform'
      $script:createdItems | Should -HaveCount 0
      $script:parentChanges | Should -HaveCount 0
    }

    # Canonical lowercase unknown must use the same fallback as legacy placeholders,
    # never overwrite curated metadata or move a package back to the unknown parent.
    It 'does not overwrite curated <Field> with newly discovered lowercase unknown' -ForEach @(
      @{ Field = 'Custom.PackageDisplayName'; Expected = 'Agriculture Platform - Management' }
      @{ Field = 'Custom.ServiceName'; Expected = 'Agriculture Platform' }
    ) {
      $item = Add-TestPackageWorkItem 'Agriculture Platform' 'Agriculture Platform - Management' 202

      RefreshItems

      $item.fields[$Field] | Should -BeExactly $Expected -Because 'an unreviewed lowercase unknown CSV value must not replace curated work-item metadata'
    }

    It 'does not reparent a curated Package WI to unknown because of an unreviewed CSV' {
      $item = Add-TestPackageWorkItem 'Agriculture Platform' 'Agriculture Platform - Management' 202

      RefreshItems

      $item.fields['System.Parent'] | Should -Be 202 -Because 'a newly discovered placeholder must not move a curated package out of its existing product Epic'
      $script:parentChanges | Should -HaveCount 0
    }

    It 'exports curated WI names back to a newly discovered lowercase unknown CSV' {
      $null = Add-TestPackageWorkItem 'Agriculture Platform' 'Agriculture Platform - Management' 202

      RefreshItems

      $exported = $script:csvWrites[0].Packages[0]
      @($exported.DisplayName, $exported.ServiceName) -join ' | ' |
        Should -BeExactly 'Agriculture Platform - Management | Agriculture Platform' -Because 'Needs Review rows must inherit known WI names rather than exporting unknown over them'
    }

    It 'round-trips human-reviewed CSV names with Notes=<Notes> on repeated sync' -ForEach @(
      @{ Notes = 'Needs Review' }
      @{ Notes = 'Reviewed, preserve "Platform" branding' }
    ) {
      $item = Add-TestPackageWorkItem
      RefreshItems
      $script:csvWrites[0].Packages[0].DisplayName | Should -BeExactly 'unknown'

      # Simulate a reviewer correcting the exported CSV, using only TestDrive.
      $csvPath = Join-Path $TestDrive 'reviewed-packages.csv'
      $script:csvWrites[0].Packages | Export-Csv -LiteralPath $csvPath -NoTypeInformation
      $reviewed = @(Import-Csv -LiteralPath $csvPath)
      $reviewed[0].DisplayName = 'Agriculture Platform - Management'
      $reviewed[0].ServiceName = 'Agriculture Platform'
      $reviewed[0].Notes = $Notes
      $reviewed | Export-Csv -LiteralPath $csvPath -NoTypeInformation
      $script:csvRows = @(Import-Csv -LiteralPath $csvPath)
      Reset-TestSyncCaches

      RefreshItems
      Reset-TestSyncCaches
      RefreshItems

      $item.fields['Custom.PackageDisplayName'] | Should -BeExactly 'Agriculture Platform - Management'
      $item.fields['Custom.ServiceName'] | Should -BeExactly 'Agriculture Platform'
      $item.fields['System.Title'] | Should -BeExactly 'Python - Agriculture Platform - Management - 1.2'
      $item.fields['System.Parent'] | Should -Be 202
      $item.fields['System.State'] | Should -BeExactly 'Next Release Unknown'
      $script:workItemStore[202].fields['System.Parent'] | Should -Be 201
      $script:createdItems | Should -HaveCount 0
      $script:parentChanges | Should -HaveCount 1
      $script:parentChanges[0].Id | Should -Be 501
      $script:parentChanges[0].OldParentId | Should -Be 102
      $script:parentChanges[0].ParentId | Should -Be 202
      $script:csvWrites | Should -HaveCount 3
      $lastExport = $script:csvWrites[-1].Packages[0]
      $lastExport.DisplayName | Should -BeExactly 'Agriculture Platform - Management'
      $lastExport.ServiceName | Should -BeExactly 'Agriculture Platform'
      $lastExport.Notes | Should -BeExactly $Notes
      $lastExport.VersionGA | Should -BeExactly '1.2.0'
      Should -Invoke CreateWorkItem -Times 0 -Exactly -Scope It
    }
  }
}