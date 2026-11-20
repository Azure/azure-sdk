#Requires -Version 7.0
#Requires -Modules @{ ModuleName = 'Pester'; ModuleVersion = '5.7.1' }

BeforeAll {
  Set-StrictMode -Version 3
  $ErrorActionPreference = 'Stop'
  $scriptsPath = Split-Path $PSScriptRoot -Parent
  . (Join-Path $scriptsPath 'PackageList-Helpers.ps1')

  # Never run the entrypoint: it queries registries and writes CSVs.
  $tokens = $null
  $parseErrors = $null
  $ast = [System.Management.Automation.Language.Parser]::ParseFile(
    (Join-Path $scriptsPath 'Query-Azure-Packages.ps1'), [ref]$tokens, [ref]$parseErrors)
  if ($parseErrors.Count -ne 0) {
    throw ($parseErrors.Message -join [Environment]::NewLine)
  }
  foreach ($statement in $ast.EndBlock.Statements) {
    if ($statement -is [System.Management.Automation.Language.FunctionDefinitionAst]) {
      . ([scriptblock]::Create($statement.Extent.Text))
    }
  }

  function New-Tag([string]$Tag) {
    [pscustomobject]@{ Tag = $Tag; Date = '2026-11-07T00:00:00Z' }
  }
}

Describe 'GetPackageVersions with non-semver tags' {
  It 'omits a package whose only recent tag is not a valid version' {
    Mock GetLatestTags { @((New-Tag 'azure-storage_2026-11-07-partner.2')) }

    $result = GetPackageVersions 'cpp'

    $result.ContainsKey('azure-storage') | Should -BeFalse
  }

  It 'keeps valid versions when a package also has a non-semver tag' {
    Mock GetLatestTags {
      @((New-Tag 'azure-storage_2026-11-07-partner.2'), (New-Tag 'azure-storage_12.1.0'))
    }

    $result = GetPackageVersions 'cpp'

    @($result['azure-storage'].Versions).Count | Should -Be 1
    $result['azure-storage'].Versions[0].RawVersion | Should -BeExactly '12.1.0'
  }
}

Describe 'Tag-based package queries' {
  BeforeEach {
    Mock Write-Warning {}
  }

  It 'skips <Lang> packages with no valid versions' -ForEach @(
    @{ Lang = 'cpp'; Valid = 'azure-core'; Invalid = 'azure-storage' }
    @{ Lang = 'go'; Valid = 'sdk/azcore'; Invalid = 'sdk/storage/azblob' }
    @{ Lang = 'rust'; Valid = 'azure_core'; Invalid = 'azure_storage' }
  ) {
    $tags = @{
      $Valid = [pscustomobject]@{ Package = $Valid; Versions = @((ToSemVer '1.2.0'), (ToSemVer '1.1.0')) }
      $Invalid = [pscustomobject]@{ Package = $Invalid; Versions = @() }
    }
    Mock GetPackageVersions { $tags }

    $packages = @(& "Get-$Lang-Packages")

    $packages.Count | Should -Be 1
    $packages[0].Package | Should -BeExactly $Valid
    $packages[0].VersionGA | Should -BeExactly '1.2.0'
    Should -Invoke Write-Warning -Times 1 -Exactly -ParameterFilter { $Message -like "*'$Invalid'*" }
  }
}
