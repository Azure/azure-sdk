#Requires -Version 7.0
#Requires -Modules @{ ModuleName = 'Pester'; ModuleVersion = '5.7.1' }

BeforeAll {
  Set-StrictMode -Version 3
  $ErrorActionPreference = 'Stop'
  $repoRoot = Resolve-Path (Join-Path $PSScriptRoot '..\..\..')
  . (Join-Path $repoRoot 'eng\scripts\Generate-Release-Structure.ps1')
}

Describe 'Monthly release note archiving' {
  BeforeEach {
    $sidebarPath = Join-Path $TestDrive 'sidebar.yml'
    $ignoreLinksPath = Join-Path $TestDrive 'ignore-links.txt'
    $releaseNotesRoot = Join-Path $TestDrive 'releases'
    New-Item -ItemType Directory -Path $releaseNotesRoot -Force | Out-Null
    Set-Content $ignoreLinksPath @(
      '# Static exclusions'
      'https://example.test/keep-before'
      $script:ArchivedReleasesBeginMarker
      '/azure-sdk/releases/stale/index.html'
      $script:ArchivedReleasesEndMarker
      'https://example.test/keep-after'
    )
    $archiveArguments = @{
      sidebarPath = $sidebarPath
      ignoreLinksPath = $ignoreLinksPath
      releaseNotesRoot = $releaseNotesRoot
      referenceDate = [datetime]'2026-10-28'
    }
  }

  It 'keeps exactly twelve months including the current month and handles legacy release dates' {
    Set-Content $sidebarPath @(
      'entries:'
      '- url: /releases/latest/index.html'
      '  folderitems:'
      '  - title: Current'
      '    url: /releases/2026-10/index.html'
      '    archived: true'
      '  - title: Boundary'
      '    url: /releases/2025-11/index.html'
      '    archived: false'
      '  - title: Old'
      '    url: "/releases/2025-10/index.html"'
      '  - title: Legacy'
      "    url: '/releases/2019-07-10/index.html'"
    )

    Update-ArchivedReleaseNotes @archiveArguments

    $sidebar = Get-Content $sidebarPath -Raw
    $sidebar | Should -Match '2025-10/index.html"\r?\n    archived: true'
    $sidebar | Should -Match "2019-07-10/index.html'\r?\n    archived: true"
    @([regex]::Matches($sidebar, 'archived: true')).Count | Should -Be 2
    $ignore = Get-Content $ignoreLinksPath
    $ignore | Should -Contain '/azure-sdk/releases/2025-10/index.html'
    $ignore | Should -Contain '/azure-sdk/releases/2019-07-10/index.html'
    $ignore | Should -Not -Contain '/azure-sdk/releases/2025-11/index.html'
    $ignore | Should -Not -Contain '/azure-sdk/releases/latest/index.html'
    $ignore | Should -Not -Contain '/azure-sdk/releases/stale/index.html'
    $ignore | Should -Contain 'https://example.test/keep-before'
    $ignore | Should -Contain 'https://example.test/keep-after'
  }

  It 'handles no archived pages and removes the obsolete generated block' {
    Set-Content $sidebarPath '    url: /releases/2026-10/index.html'

    Update-ArchivedReleaseNotes @archiveArguments

    Get-Content $ignoreLinksPath | Should -Not -Contain $script:ArchivedReleasesBeginMarker
    Get-Content $ignoreLinksPath | Should -Contain 'https://example.test/keep-after'
  }

  It 'handles a single archived page and is idempotent' {
    Set-Content $sidebarPath '    url: /releases/2025-10/index.html'
    Update-ArchivedReleaseNotes @archiveArguments
    $firstSidebar = Get-Content $sidebarPath -Raw
    $firstIgnore = Get-Content $ignoreLinksPath -Raw

    Update-ArchivedReleaseNotes @archiveArguments

    Get-Content $sidebarPath -Raw | Should -BeExactly $firstSidebar
    Get-Content $ignoreLinksPath -Raw | Should -BeExactly $firstIgnore
    @(Get-Content $ignoreLinksPath | Where-Object { $_ -eq '/azure-sdk/releases/2025-10/index.html' }).Count | Should -Be 1
  }

  It 'fails before changing either file when generated markers are malformed' {
    Set-Content $sidebarPath '    url: /releases/2025-10/index.html'
    Set-Content $ignoreLinksPath @($script:ArchivedReleasesBeginMarker, 'https://example.test/keep')
    $originalSidebar = Get-Content $sidebarPath -Raw
    $originalIgnore = Get-Content $ignoreLinksPath -Raw

    { Update-ArchivedReleaseNotes @archiveArguments } | Should -Throw '*Invalid archived release note markers*'

    Get-Content $sidebarPath -Raw | Should -BeExactly $originalSidebar
    Get-Content $ignoreLinksPath -Raw | Should -BeExactly $originalIgnore
  }

  It 'excludes language pages reached directly without excluding current release pages' {
    Set-Content $sidebarPath @(
      '    url: /releases/2025-10/index.html'
      '    url: /releases/2026-10/index.html'
    )
    $oldDirectory = Join-Path $releaseNotesRoot '2025-10'
    New-Item -ItemType Directory $oldDirectory | Out-Null
    Set-Content (Join-Path $oldDirectory 'index.md') 'Old notes'
    Set-Content (Join-Path $oldDirectory 'dotnet.md') 'Old .NET notes'

    Update-ArchivedReleaseNotes @archiveArguments

    $ignore = Get-Content $ignoreLinksPath
    $ignore | Should -Contain '/azure-sdk/releases/2025-10/dotnet.html'
    $ignore | Should -Not -Contain '/azure-sdk/releases/2026-10/index.html'
  }
}

Describe 'Site crawler archive exclusions' {
  BeforeAll {
    $verifier = Join-Path $repoRoot 'eng\common\scripts\Verify-Links.ps1'
    $pwsh = (Get-Process -Id $PID).Path
  }

  It 'does not crawl archived pages but still detects broken links in current pages' {
    $siteRoot = Join-Path $TestDrive 'site'
    $siteDirectory = Join-Path $siteRoot 'azure-sdk'
    $oldDirectory = Join-Path $siteDirectory 'releases\2025-10'
    $currentDirectory = Join-Path $siteDirectory 'releases\2026-10'
    New-Item -ItemType Directory $oldDirectory, $currentDirectory -Force | Out-Null
    $entry = Join-Path $siteDirectory 'index.html'
    Set-Content $entry @(
      '<a href="/azure-sdk/releases/2025-10/index.html">Archived</a>'
      '<a href="/azure-sdk/releases/2025-10/dotnet.html">Archived .NET</a>'
      '<a href="/azure-sdk/releases/2026-10/index.html">Current</a>'
    )
    Set-Content (Join-Path $oldDirectory 'index.html') '<a href="missing-old.html">Broken historical link</a>'
    Set-Content (Join-Path $oldDirectory 'dotnet.html') '<a href="missing-old.html">Broken historical link</a>'
    $currentIndex = Join-Path $currentDirectory 'index.html'
    Set-Content $currentIndex '<p>Current release notes</p>'
    $sidebarPath = Join-Path $TestDrive 'sidebar.yml'
    Set-Content $sidebarPath '    url: /releases/2025-10/index.html'
    $ignoreLinksPath = Join-Path $TestDrive 'ignore-links.txt'
    Set-Content $ignoreLinksPath '# Static exclusions'
    Update-ArchivedReleaseNotes -sidebarPath $sidebarPath -ignoreLinksPath $ignoreLinksPath `
      -referenceDate ([datetime]'2026-10-28') -releaseNotesRoot (Join-Path $siteDirectory 'releases')
    $verifierArguments = @(
      '-NoProfile', '-File', $verifier, '-urls', $entry,
      '-ignoreLinksFile', $ignoreLinksPath,
      '-baseUrl', ([uri]::new(($siteDirectory + [IO.Path]::DirectorySeparatorChar), [UriKind]::Absolute)).AbsoluteUri,
      '-rootUrl', ([uri]::new(($siteRoot + [IO.Path]::DirectorySeparatorChar), [UriKind]::Absolute)).AbsoluteUri
    )

    $output = & $pwsh @verifierArguments 2>&1
    $LASTEXITCODE | Should -Be 0 -Because ($output -join "`n")
    $output -join "`n" | Should -Not -Match 'missing-old'

    Set-Content $currentIndex '<a href="missing-current.html">Broken current link</a>'
    $output = & $pwsh @verifierArguments 2>&1
    $LASTEXITCODE | Should -Be 1 -Because ($output -join "`n")
    $output -join "`n" | Should -Match 'missing-current'
  }
}
