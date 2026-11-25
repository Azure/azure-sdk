[CmdletBinding()]
param (
  [Parameter(Mandatory)]
  [string] $SitePath,
  [Parameter(Mandatory)]
  [string] $OutputPath
)

Set-StrictMode -Version 3
$ErrorActionPreference = 'Stop'

if (!(Test-Path -LiteralPath (Join-Path $SitePath 'index.html') -PathType Leaf)) {
  throw "Baseline site index.html not found in '$SitePath'."
}

$links = [System.Collections.Generic.HashSet[string]]::new([StringComparer]::Ordinal)
$seenHrefs = [System.Collections.Generic.HashSet[string]]::new([StringComparer]::Ordinal)
# Match the anchor parsing and URI normalization in Verify-Links.ps1.
$options = [System.Text.RegularExpressions.RegexOptions]::IgnoreCase -bor [System.Text.RegularExpressions.RegexOptions]::Singleline -bor [System.Text.RegularExpressions.RegexOptions]::Compiled
$hrefPattern = [regex]::new('<a[^>]+href\s*=\s*["'']?(?<href>[^"'']*)["'']?', $options)

foreach ($file in (Get-ChildItem -LiteralPath $SitePath -Filter '*.html' -File -Recurse)) {
  $content = Get-Content -LiteralPath $file.FullName -Raw
  if (!$content) { continue }

  foreach ($match in $hrefPattern.Matches($content)) {
    $href = $match.Groups['href'].Value
    if (!$seenHrefs.Add($href)) { continue }
    $href = [System.Web.HttpUtility]::HtmlDecode($href)
    [System.Uri]$uri = $null
    if (![System.Uri]::TryCreate($href, [System.UriKind]::Absolute, [ref]$uri) -or $uri.Scheme -notin @('http', 'https')) {
      continue
    }

    $normalizedUri = [System.Uri]$uri.GetComponents([System.UriComponents]::HttpRequestUrl, [System.UriFormat]::SafeUnescaped)
    $link = $normalizedUri.ToString()
    if ($link.IndexOfAny([char[]]"`r`n") -ge 0) {
      throw "Cannot add a link containing a newline to the baseline: $link"
    }
    [void]$links.Add($link)
  }
}

$cacheContent = @('# Existing external destinations from the pull request base.') + @($links | Sort-Object -CaseSensitive)
Set-Content -LiteralPath $OutputPath -Value $cacheContent -Encoding utf8
Write-Host "Recorded $($links.Count) external destinations from the base site."
