#Requires -Version 7.0
#Requires -Modules @{ ModuleName = 'Pester'; ModuleVersion = '5.7.1' }

BeforeAll {
  Set-StrictMode -Version 3
  $ErrorActionPreference = 'Stop'
  $scriptsPath = Split-Path $PSScriptRoot -Parent
  . (Join-Path $scriptsPath 'PackageList-Helpers.ps1')

  $tokens = $null
  $parseErrors = $null
  $ast = [System.Management.Automation.Language.Parser]::ParseFile(
    (Join-Path $scriptsPath 'Update-Release-Versions.ps1'), [ref]$tokens, [ref]$parseErrors)
  if ($parseErrors.Count -ne 0) {
    throw ($parseErrors.Message -join [Environment]::NewLine)
  }
  foreach ($statement in $ast.EndBlock.Statements) {
    if ($statement -is [System.Management.Automation.Language.FunctionDefinitionAst]) {
      . ([scriptblock]::Create($statement.Extent.Text))
    }
  }

  function New-TestPackage {
    [pscustomobject]@{
      Package = 'azure-example'
      GroupId = 'com.azure'
      VersionGA = '1.0.0'
      VersionPreview = '2.0.0-beta.1'
      FirstGADate = '01/01/2025'
      LatestGADate = '01/01/2025'
      FirstPreviewDate = '01/01/2025'
      RepoPath = 'https://github.com/Azure/azure-sdk-for-java/tree/item.Package_item.Version/sdk/example/item.Package/'
      Hide = ''
      Support = ''
      ServiceName = 'Example'
      DisplayName = 'Example'
      Type = 'client'
      New = 'true'
    }
  }
}

Describe 'Java source path resolution' {
  BeforeEach {
    $pkg = New-TestPackage
    $templates = GetLinkTemplates 'java'
    Mock CheckLink { $true }
    Mock Invoke-WebRequest { throw 'Unexpected network request' }
  }

  It 'uses the GA version for legacy source URLs' {
    Resolve-JavaSourcePaths @($pkg) $templates

    $pkg.RepoPath | Should -BeExactly 'https://github.com/Azure/azure-sdk-for-java/tree/azure-example_1.0.0/sdk/example/azure-example/'
    Should -Invoke CheckLink -Times 1 -Exactly -ParameterFilter { $link -eq $pkg.RepoPath }
  }

  It 'uses the preview version when there is no GA version' {
    $pkg.VersionGA = ''
    $pkg.RepoPath = $pkg.RepoPath.Replace('item.Package_item.Version', 'item.GroupId+item.Package_item.Version')

    Resolve-JavaSourcePaths @($pkg) $templates

    $pkg.RepoPath | Should -BeExactly 'https://github.com/Azure/azure-sdk-for-java/tree/com.azure+azure-example_2.0.0-beta.1/sdk/example/azure-example/'
  }

  It 'preserves concrete overrides and service directories: <Path>' -ForEach @(
    @{ Path = 'https://github.com/other/repo/tree/release/custom-module' }
    @{ Path = 'example' }
    @{ Path = 'NA' }
    @{ Path = '' }
  ) {
    $pkg.RepoPath = $Path

    Resolve-JavaSourcePaths @($pkg) $templates

    $pkg.RepoPath | Should -BeExactly $Path
    Should -Invoke CheckLink -Times 0 -Exactly
  }

  It 'fails without changing the path when placeholders cannot be resolved' {
    $pkg.VersionGA = ''
    $pkg.VersionPreview = ''
    $original = $pkg.RepoPath

    { Resolve-JavaSourcePaths @($pkg) $templates } | Should -Throw '*Cannot resolve Java RepoPath*'

    $pkg.RepoPath | Should -BeExactly $original
    Should -Invoke CheckLink -Times 0 -Exactly
  }

  It 'rejects an unresolved group ID' {
    $pkg.GroupId = ''
    $pkg.RepoPath = $pkg.RepoPath.Replace('item.Package_item.Version', 'item.GroupId+item.Package_item.Version')

    { Resolve-JavaSourcePaths @($pkg) $templates } | Should -Throw '*Cannot resolve Java RepoPath*'

    Should -Invoke CheckLink -Times 0 -Exactly
  }

  It 'fails without changing the path when the resolved source URL is invalid' {
    Mock CheckLink { $false }
    $original = $pkg.RepoPath

    { Resolve-JavaSourcePaths @($pkg) $templates } | Should -Throw '*source URL is invalid*'

    $pkg.RepoPath | Should -BeExactly $original
  }
}

Describe 'Version updater source path persistence' {
  BeforeEach {
    $pkg = New-TestPackage
    $hidden = New-TestPackage
    $hidden.Hide = 'true'
    $checkDocLinks = $false
    $compareTagVsGHIOVersions = $false
    Mock Get-PackageListForLanguageSplit { ,@($pkg); ,@($hidden) }
    Mock GetPackageVersions { @{} }
    Mock CheckOptionalLinks {}
    Mock CheckLink { $true }
    Mock Set-PackageListForLanguage {}
    $numMonthsForReleaseTags = 1
  }

  It 'resolves client and hidden package URLs even without recent release tags' {
    OutputVersions 'java'

    $pkg.RepoPath | Should -Not -Match 'item\.'
    $hidden.RepoPath | Should -Not -Match 'item\.'
    Should -Invoke Set-PackageListForLanguage -Times 1 -Exactly -ParameterFilter {
      $lang -eq 'java' -and @($packageList).Count -eq 2 -and
      @($packageList | Where-Object { $_.RepoPath -match 'item\.' }).Count -eq 0
    }
  }

  It 'preserves migration to the GroupId-prefixed tag format' {
    Mock GetPackageVersions {
      @{ 'com.azure+azure-example' = @{ Versions = @((ToSemVer '1.0.0')) } }
    }
    Mock Ensure-JavaTag {}

    OutputVersions 'java'

    $pkg.RepoPath | Should -BeExactly 'example'
    Should -Invoke Ensure-JavaTag -Times 2 -Exactly
    Should -Invoke Set-PackageListForLanguage -Times 1 -Exactly
  }

  It 'does not write the CSV when a source URL is invalid' {
    Mock CheckLink { $false }

    { OutputVersions 'java' } | Should -Throw '*source URL is invalid*'

    Should -Invoke Set-PackageListForLanguage -Times 0 -Exactly
  }

  It 'does not normalize other languages' {
    $original = $pkg.RepoPath

    OutputVersions 'js'

    $pkg.RepoPath | Should -BeExactly $original
    Should -Invoke CheckLink -Times 0 -Exactly
  }
}

Describe 'Java CSV source path checks' {
  BeforeEach {
    $pkg = New-TestPackage
    $pkg.Hide = 'true'
    $client = New-TestPackage
    $client.RepoPath = 'example'
    Mock Get-PackageListForLanguageSplit { ,@($client); ,@($pkg) }
    Mock Get-PackageListForLanguage { @($client, $pkg) }
    Mock Get-LangCsvFilePath { 'java-packages.csv' }
    Mock Write-Warning {}
    Mock Write-Error { throw $Message }
  }

  It 'rejects unresolved Java placeholders, including packages outside the client list' {
    { CheckAll @('java') } | Should -Throw '*Found one or more issues*'

    Should -Invoke Write-Warning -Times 1 -Exactly -ParameterFilter {
      $Message -like '*Unresolved Java RepoPath placeholders*'
    }
  }

  It 'accepts a concrete Java source URL' {
    $pkg.RepoPath = 'https://github.com/Azure/azure-sdk-for-java/tree/azure-example_1.0.0/sdk/example/azure-example/'

    CheckAll @('java')

    Should -Invoke Write-Error -Times 0 -Exactly
  }

  It 'continues to allow templated URLs in other languages' {
    CheckAll @('js')

    Should -Invoke Write-Error -Times 0 -Exactly
  }
}
