#Requires -Version 7.0
#Requires -Modules @{ ModuleName = 'Pester'; ModuleVersion = '5.7.1' }

BeforeAll {
  Set-StrictMode -Version 3
  $ErrorActionPreference = 'Stop'
  $repoRoot = (Resolve-Path (Join-Path $PSScriptRoot '..\..\..')).Path
  $baselineScript = Join-Path $repoRoot 'eng\scripts\Get-SiteLinkBaseline.ps1'
  $verifier = Join-Path $repoRoot 'eng\common\scripts\Verify-Links.ps1'

  function Write-TestPage([string]$path, [string]$content) {
    New-Item -ItemType Directory -Path (Split-Path $path -Parent) -Force | Out-Null
    Set-Content -LiteralPath $path -Value $content -Encoding utf8
  }
}

Describe 'Site link baseline' {
  BeforeEach {
    $testRoot = Join-Path $TestDrive ([guid]::NewGuid().ToString())
    $baseIndex = Join-Path $testRoot 'base\index.html'
    $headIndex = Join-Path $testRoot 'head\index.html'
    $cache = Join-Path $testRoot 'baseline.txt'
    $ignore = Join-Path $testRoot 'ignore.txt'
  }

  It 'normalizes and deduplicates external links without caching local links' {
    Write-TestPage $baseIndex @'
<a href="https://EXAMPLE.test/a?x=1&amp;y=2#one">one</a>
<a href="https://example.test/a?x=1&amp;y=2#two">two</a>
<a href="file:///not-present">file</a>
<a href="/relative">relative</a>
<a href="mailto:contact@example.test">email</a>
'@
    Write-TestPage (Join-Path $testRoot 'base\nested\page.html') '<a href="http://example.test/other">other</a>'

    & $baselineScript -SitePath (Split-Path $baseIndex -Parent) -OutputPath $cache
    $lines = @(Get-Content $cache | Where-Object { !$_.StartsWith('#') })

    $lines | Should -HaveCount 2
    $lines | Should -Contain 'https://example.test/a?x=1&y=2'
    $lines | Should -Contain 'http://example.test/other'
  }

  It 'fails if the baseline site index is missing' {
    New-Item -ItemType Directory -Path $testRoot -Force | Out-Null

    { & $baselineScript -SitePath (Join-Path $testRoot 'missing') -OutputPath $cache } | Should -Throw '*index.html*'
  }

  It 'does not request an existing broken external destination' {
    $url = 'https://learn.microsoft.com/dotnet/api/overview/azure/AI.AnomalyDetector-readme?view=azure-dotnet-preview&preserve-view=true'
    $html = '<a href="' + $url.Replace('&', '&amp;') + '">docs</a>'
    Write-TestPage $baseIndex $html
    Write-TestPage $headIndex $html
    & $baselineScript -SitePath (Split-Path $baseIndex -Parent) -OutputPath $cache
    Mock Invoke-WebRequest { throw 'Unexpected network request' }

    $null = & $verifier -urls $headIndex -ignoreLinksFile $ignore -inputCacheFile $cache -recursive:$false 6>&1

    $LASTEXITCODE | Should -Be 0
    Should -Invoke Invoke-WebRequest -Times 0 -Exactly
  }

  It 'rejects a newly introduced broken external destination' {
    Write-TestPage $baseIndex '<a href="https://example.test/existing">existing</a>'
    Write-TestPage $headIndex '<a href="https://example.test/new">new</a>'
    & $baselineScript -SitePath (Split-Path $baseIndex -Parent) -OutputPath $cache
    Mock Invoke-WebRequest {
      throw [Microsoft.PowerShell.Commands.HttpResponseException]::new(
        'Not Found', [System.Net.Http.HttpResponseMessage]::new([System.Net.HttpStatusCode]::NotFound))
    }

    $null = & $verifier -urls $headIndex -ignoreLinksFile $ignore -inputCacheFile $cache -recursive:$false 6>&1

    $LASTEXITCODE | Should -Be 1
    Should -Invoke Invoke-WebRequest -Times 2 -Exactly
  }

  It 'rejects missing local links without making external requests' {
    Write-TestPage $baseIndex '<a href="https://example.test/existing">existing</a>'
    Write-TestPage $headIndex '<a href="https://example.test/existing">existing</a><a href="missing.html">missing</a>'
    & $baselineScript -SitePath (Split-Path $baseIndex -Parent) -OutputPath $cache
    Mock Invoke-WebRequest { throw 'Unexpected network request' }

    $null = & $verifier -urls $headIndex -ignoreLinksFile $ignore -inputCacheFile $cache -recursive:$false 6>&1

    $LASTEXITCODE | Should -Be 1
    Should -Invoke Invoke-WebRequest -Times 0 -Exactly
  }
}
