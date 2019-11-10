$badLinks = @()

$badLinks += "a"
$badLinks += "b"


Write-Host "Found $($badLinks.Count) invalid links on page $Url"
$badLinks | % { Write-Host "$_" }

exit $badLinks.Count
