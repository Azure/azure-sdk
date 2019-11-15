param (
  [string] $Url,
  [string] $ignoreLinksFile = "$PSScriptRoot/ignore-links.txt",
  [switch] $devOpsLogging = $false
)

function LogWarning
{
  if ($devOpsLogging)
  {
    Write-Host "##vso[task.LogIssue type=warning;]$args"
  }
  else
  {
    Write-Warning "$args"
  }
}

if ($url -eq "")
{
  Write-Host "Usage $($MyInvocation.MyCommand.Name) <url>";
  exit;
}

if ($PSVersionTable.PSVersion.Major -lt 6)
{
  LogWarning "Some web requests will not work in versions of PS earlier then 6. You are running version $($PSVersionTable.PSVersion)."
}

$badLinks = @();
$ignoreLinks = @();
if (Test-Path $ignoreLinksFile)
{
  $ignoreLinks = [Array](gc $ignoreLinksFile | % { ($_ -replace "#.*", "").Trim() } | ? { $_ -ne "" })
}

$uri = [System.Uri]$Url;
$links = (Invoke-WebRequest -Uri $uri).Links | % { $_.href } | Select -unique
Write-Host "Found $($links.Count) links on page $Url";
foreach ($link in $links)
{
  Write-Verbose "Checking link $link..."

  try
  {
    $linkUri = [System.Uri]$link;
    if (!$linkUri.IsAbsoluteUri)
    {
      $linkUri = new-object System.Uri($Url, $link);
      Write-Verbose "Resolved relative link to $linkUri"
    }
    # If the link is not a web request, like mailto, skip it.
    if (!$linkUri.Scheme.StartsWith("http")) {
      Write-Verbose "Skipping $linkUri because it is not http based."
      continue;
    }
    $linkUri = [System.Uri]$linkUri.GetComponents([System.UriComponents]::HttpRequestUrl, [System.UriFormat]::SafeUnescaped)
    $response = Invoke-WebRequest -Uri $linkUri
    $statusCode = $response.StatusCode
    if ($statusCode -ne 200)
    {
      Write-Host "For link $linkUri we got status code $statusCode"
    }
  }
  catch
  {
    if (!$ignoreLinks.Contains($link))
    {
      $statusCode = $_.Exception.Response.StatusCode.value__
      LogWarning "Invalid link[$statusCode] $linkUri"
      $badLinks += $link
    }
    else
    {
      Write-Verbose "Ignoring invalid line $linkUri because it is in the ignore file."
    }
  }
}

Write-Host "Found $($badLinks.Count) invalid links on page $Url"
$badLinks | % { Write-Host "$_" }

exit $badLinks.Count