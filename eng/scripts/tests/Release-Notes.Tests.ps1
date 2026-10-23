#Requires -Version 7.0
#Requires -Modules @{ ModuleName = 'Pester'; ModuleVersion = '5.7.1' }

Describe 'Release-note links' {
  BeforeAll {
    $scriptsPath = Split-Path $PSScriptRoot -Parent
    . (Join-Path $scriptsPath '../common/scripts/SemVer.ps1')
    $tokens = $null
    $parseErrors = $null
    $ast = [System.Management.Automation.Language.Parser]::ParseFile(
      (Join-Path $scriptsPath 'Generate-ReleaseNotes.ps1'), [ref]$tokens, [ref]$parseErrors)
    if ($parseErrors.Count -ne 0) {
      throw ($parseErrors.Message -join [Environment]::NewLine)
    }
    foreach ($statement in $ast.EndBlock.Statements) {
      if ($statement -is [System.Management.Automation.Language.FunctionDefinitionAst]) {
        . ([scriptblock]::Create($statement.Extent.Text))
      }
    }
    function LogWarning([string]$Message) { Write-Warning $Message }
  }

  It 'Uses the release tag for <language> links' -TestCases @(
    @{
      language = '.NET'
      repository = 'Azure/azure-sdk-for-net'
      tag = 'Azure.Core_1.14.0'
      path = 'sdk/core/Azure.Core/README.md'
    },
    @{
      language = 'JavaScript'
      repository = 'Azure/azure-sdk-for-js'
      tag = '@azure/core-rest-pipeline_1.5.0'
      path = 'sdk/core/core-rest-pipeline/README.md'
    },
    @{
      language = 'Go'
      repository = 'Azure/azure-sdk-for-go'
      tag = 'sdk/azcore/v1.9.1'
      path = 'sdk/azcore/README.md'
    }
  ) {
    param($language, $repository, $tag, $path)
    $source = "https://github.com/$repository/tree/$tag/$path"
    $content = "https://github.com/$repository/blob/main/$path#section"
    ConvertToReleaseTagLinks $content $source |
      Should -BeExactly "https://github.com/$repository/blob/$tag/$path#section"
  }

  It 'Pins master, raw, and protocol-relative links and removes branch namespaces' {
    $source = 'https://github.com/Azure/azure-sdk-for-net/tree/Azure.Core_1.14.0/sdk/core/Azure.Core/CHANGELOG.md'
    $content = @'
https://github.com/Azure/azure-sdk-for-net/tree/master/sdk/core
https://raw.githubusercontent.com/Azure/azure-sdk-for-net/refs/heads/main/sdk/core/Azure.Core/README.md
//github.com/azure/azure-sdk-for-net/blob/main/sdk/core/Azure.Core/README.md
'@
    $expected = @'
https://github.com/Azure/azure-sdk-for-net/tree/Azure.Core_1.14.0/sdk/core
https://raw.githubusercontent.com/Azure/azure-sdk-for-net/Azure.Core_1.14.0/sdk/core/Azure.Core/README.md
//github.com/azure/azure-sdk-for-net/blob/Azure.Core_1.14.0/sdk/core/Azure.Core/README.md
'@
    ConvertToReleaseTagLinks $content $source | Should -BeExactly $expected
  }

  It 'Leaves other repositories, pinned refs, and main path components unchanged' {
    $source = 'https://github.com/Azure/azure-sdk-for-java/tree/azure-core_1.17.0/sdk/core/azure-core/CHANGELOG.md'
    $content = @'
https://github.com/open-telemetry/semantic-conventions/blob/main/docs/http/http-spans.md
https://github.com/Azure/azure-sdk-for-java/blob/azure-core_1.16.0/sdk/core/azure-core/src/main/java/Example.java
https://github.com/Azure/azure-sdk-for-java/tree/main-feature/sdk/core
https://othergithub.com/Azure/azure-sdk-for-java/blob/main/sdk/core
'@
    ConvertToReleaseTagLinks $content $source | Should -BeExactly $content
  }

  It 'Warns instead of inventing a tag when the release source is not pinned' -TestCases @(
    @{ Source = 'https://github.com/Azure/azure-sdk-for-net/tree/main/sdk/core/Azure.Core/CHANGELOG.md' },
    @{ Source = 'https://github.com/Azure/azure-sdk-for-net/tree/main/examples/sdk/core/CHANGELOG.md' }
  ) {
    param($Source)
    Mock LogWarning {}
    $content = 'https://github.com/Azure/azure-sdk-for-net/blob/main/sdk/core/Azure.Core/README.md'
    ConvertToReleaseTagLinks $content $Source |
      Should -BeExactly $content
    Should -Invoke LogWarning -Times 1 -Exactly
  }

  It 'Pins generated changelog content without changing release metadata' {
    Mock GetChangelogBlobLink {
      'https://github.com/Azure/azure-sdk-for-java/tree/azure-core_1.17.0/sdk/core/azure-core/CHANGELOG.md'
    }
    Mock GetChangeLogContent { '# Release History' }
    Mock GetReleaseNoteEntryContent {
      @(
        '#### Features Added',
        '',
        '- See [samples](https://github.com/Azure/azure-sdk-for-java/tree/main/sdk/core/azure-core/src/samples).'
      )
    }
    $metadata = [pscustomobject]@{
      Type = 'client'
      RepoPath = 'core'
      DisplayName = 'Core'
      ServiceName = 'Core'
      GroupId = 'com.azure'
    }
    $entry = GetReleaseNotesData 'azure-core' '1.17.0' $metadata
    $entry.Keys.Count | Should -Be 9
    $entry.Name | Should -BeExactly 'azure-core'
    $entry.Version | Should -BeExactly '1.17.0'
    $entry.DisplayName | Should -BeExactly 'Core'
    $entry.ServiceName | Should -BeExactly 'Core'
    $entry.VersionType | Should -BeExactly 'GA'
    $entry.Hidden | Should -BeFalse
    $entry.GroupId | Should -BeExactly 'com.azure'
    $entry.ChangelogUrl | Should -BeExactly 'https://github.com/Azure/azure-sdk-for-java/tree/azure-core_1.17.0/sdk/core/azure-core/CHANGELOG.md'
    $entry.ChangelogContent | Should -BeExactly (@(
      '#### Features Added',
      '',
      '- See [samples](https://github.com/Azure/azure-sdk-for-java/tree/azure-core_1.17.0/sdk/core/azure-core/src/samples).'
    ) -join [Environment]::NewLine)
  }
}

Describe 'Dated release-page injection' {
  It 'Uses the shared include for every dated language page' {
    $root = (Resolve-Path (Join-Path $PSScriptRoot '../../..')).Path
    $periods = Get-ChildItem -LiteralPath (Join-Path $root 'releases') -Directory |
      Where-Object Name -Match '^\d{4}-\d{2}(-\d{2})?$'
    $pages = @($periods | ForEach-Object {
      Get-ChildItem -LiteralPath $_.FullName -Filter '*.md' -File |
        Where-Object Name -NE 'index.md'
    })
    $pages.Count | Should -BeGreaterThan 0
    foreach ($page in $pages) {
      $content = Get-Content -LiteralPath $page.FullName -Raw
      $content | Should -Match '^---\r?\n'
      ([regex]::Matches($content, '{%\s*include releases/notes/common\.md\b')).Count |
        Should -Be 1 -Because $page.FullName
    }
  }
}
