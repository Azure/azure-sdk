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
    (Join-Path $scriptsPath 'Generate-Package-Index.ps1'), [ref]$tokens, [ref]$parseErrors)
  if ($parseErrors.Count -ne 0) {
    throw ($parseErrors.Message -join [Environment]::NewLine)
  }
  foreach ($statement in $ast.EndBlock.Statements) {
    if ($statement -is [System.Management.Automation.Language.FunctionDefinitionAst]) {
      . ([scriptblock]::Create($statement.Extent.Text))
    }
  }
}

Describe 'Package index source links' {
  BeforeEach {
    $pkg = [pscustomobject]@{
      Package = 'azure-example'
      GroupId = 'com.azure'
      DisplayName = 'Example'
      VersionGA = '1.0.0'
      VersionPreview = '2.0.0-beta.1'
      RepoPath = 'example'
      MSDocs = 'NA'
      New = 'true'
      Hide = ''
      Support = ''
      Type = 'client'
    }
    $templates = GetLinkTemplates 'java'
  }

  It 'resolves group IDs for <Case> source links' -ForEach @(
    @{ Case = 'GA-only'; GA = '1.0.0'; Preview = ''; Versions = @('1.0.0') }
    @{ Case = 'preview-only'; GA = ''; Preview = '2.0.0-beta.1'; Versions = @('2.0.0-beta.1') }
    @{ Case = 'GA and preview'; GA = '1.0.0'; Preview = '2.0.0-beta.1'; Versions = @('1.0.0', '2.0.0-beta.1') }
  ) {
    $pkg.VersionGA = $GA
    $pkg.VersionPreview = $Preview

    $row = Get-Row $pkg $templates

    $row | Should -Not -Match 'item\.'
    foreach ($version in $Versions) {
      $row | Should -Match ([regex]::Escape(
        "GitHub [$version](https://github.com/Azure/azure-sdk-for-java/tree/com.azure+azure-example_$version/sdk/example/azure-example/)"))
    }
    ([regex]::Matches($row, 'GitHub \[')).Count | Should -Be $Versions.Count
  }

  It 'preserves a concrete source URL override and its single source link' {
    $pkg.RepoPath = 'https://github.com/other/repo/tree/release/custom-module'

    $row = Get-Row $pkg $templates

    $row | Should -Match ([regex]::Escape("GitHub [1.0.0]($($pkg.RepoPath))"))
    ([regex]::Matches($row, 'GitHub \[')).Count | Should -Be 1
  }

  It 'generates source links without a GroupId property for <Language>' -ForEach @(
    @{ Language = 'dotnet' }
    @{ Language = 'js' }
    @{ Language = 'python' }
    @{ Language = 'go' }
    @{ Language = 'rust' }
  ) {
    $pkg.PSObject.Properties.Remove('GroupId')

    $row = Get-Row $pkg (GetLinkTemplates $Language)

    $row | Should -Not -Match 'item\.'
    $row | Should -Match 'GitHub \[1\.0\.0\]'
    $row | Should -Match 'GitHub \[2\.0\.0-beta\.1\]'
  }

  It 'writes resolved source links to both Java markdown files' {
    $releaseFolder = Join-Path $TestDrive 'releases'
    $outputFolder = Join-Path $TestDrive 'output'
    New-Item -ItemType Directory $releaseFolder, $outputFolder | Out-Null
    $secondPackage = $pkg.PSObject.Copy()
    $secondPackage.Package = 'azure-another-example'
    @($pkg, $secondPackage) | Export-Csv (Join-Path $releaseFolder 'java-packages.csv') -NoTypeInformation

    Write-Markdown 'java'

    foreach ($name in @('java-all.md', 'java-new.md')) {
      $content = Get-Content (Join-Path $outputFolder $name) -Raw
      $content | Should -Not -Match 'item\.'
      $content | Should -Match 'com\.azure\+azure-example_1\.0\.0/sdk/example/azure-example/'
      $content | Should -Match 'com\.azure\+azure-example_2\.0\.0-beta\.1/sdk/example/azure-example/'
    }
  }
}
