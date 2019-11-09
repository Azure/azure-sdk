param (
  [string] $Url
)

if ($url -eq "")
{
  Write-Host "Usage $($MyInvocation.MyCommand.Name) <url>";
  exit;
}

if ($PSVersionTable.PSVersion.Major -lt 6)
{
  Write-Warning "Some web requests will not work in versions of PS earlier then 6. You are running version $($PSVersionTable.PSVersion)."
}

$uri = [System.Uri]$Url;
$baseUri = $uri.GetLeftPart([System.UriPartial]::Authority);
$links = (Invoke-WebRequest -Uri $uri).Links | Select -ExpandProperty href -Unique
$badLinks = @();
Write-Host "Found $($links.Count) links on page $Url";
foreach ($link in $links)
{
  #Write-Host "Checking link $link..."

  try
  {
    $linkUri = [System.Uri]$link;
    if (!$linkUri.IsAbsoluteUri)
    {
      $linkUri = [System.Uri]($baseUri + $link);
    }
    $response = Invoke-WebRequest -Uri $linkUri
    $statusCode = $response.StatusCode
    if ($statusCode -ne 200)
    {
      Write-Host "For link $link we got status code $statusCode"
    }
  }
  catch
  {
      Write-Warning "Invalid link $link"
      $badLinks += $link
  }
}

Write-Host "Found $($badLinks.Count) bad links:"
$badLinks | % { Write-Host $_ }
