#Requires -Version 7.0
#Requires -Modules @{ ModuleName = 'Pester'; ModuleVersion = '5.7.1' }

Describe 'Package versions from repository tags' {
  BeforeAll {
    Set-StrictMode -Version 3
    $ErrorActionPreference = 'Stop'
    $language = 'all'
    $scriptsPath = Split-Path $PSScriptRoot -Parent
    . (Join-Path $scriptsPath 'PackageList-Helpers.ps1')

    $tokens = $null
    $parseErrors = $null
    $ast = [System.Management.Automation.Language.Parser]::ParseFile(
      (Join-Path $scriptsPath 'Query-Azure-Packages.ps1'), [ref]$tokens, [ref]$parseErrors)
    if ($parseErrors.Count -ne 0) {
      throw ($parseErrors.Message -join [Environment]::NewLine)
    }
    $cppFunction = $ast.Find({
      param($node)
      $node -is [System.Management.Automation.Language.FunctionDefinitionAst] -and $node.Name -eq 'Get-cpp-Packages'
    }, $true)
    . ([scriptblock]::Create($cppFunction.Extent.Text))
  }

  BeforeEach {
    $script:repositoryTags = @()
    Mock GetLatestTags { return $script:repositoryTags }
  }

  It 'omits packages with only unparseable tags' {
    $script:repositoryTags = @(
      [pscustomobject]@{ Tag = 'azure-storage_2026-11-07-partner.2'; Date = '11/07/2026' }
    )

    $versions = GetPackageVersions 'cpp'

    $versions.ContainsKey('azure-storage') | Should -BeFalse
  }

  It 'retains valid versions whether the invalid tag comes first or last' -ForEach @(
    @{ InvalidFirst = $true }
    @{ InvalidFirst = $false }
  ) {
    $invalid = [pscustomobject]@{ Tag = 'azure-storage_2026-11-07-partner.2'; Date = '11/07/2026' }
    $valid = [pscustomobject]@{ Tag = 'azure-storage_1.2.3'; Date = '11/06/2026' }
    $script:repositoryTags = if ($InvalidFirst) { @($invalid, $valid) } else { @($valid, $invalid) }

    $versions = GetPackageVersions 'cpp'

    $versions.ContainsKey('azure-storage') | Should -BeTrue
    @($versions['azure-storage'].Versions).Count | Should -Be 1
    $versions['azure-storage'].Versions[0].RawVersion | Should -BeExactly '1.2.3'
  }

  It 'continues C++ package discovery when a non-version tag is present' {
    $script:repositoryTags = @(
      [pscustomobject]@{ Tag = 'azure-storage_2026-11-07-partner.2'; Date = '11/07/2026' }
      [pscustomobject]@{ Tag = 'azure-core_1.2.3'; Date = '11/06/2026' }
    )

    $packages = @(Get-cpp-Packages)

    $packages.Count | Should -Be 1
    $packages[0].Package | Should -BeExactly 'azure-core'
    $packages[0].VersionGA | Should -BeExactly '1.2.3'
  }
}
