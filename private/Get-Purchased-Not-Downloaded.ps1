$downloaded = . $PSScriptRoot\Get-Downloaded.ps1
$purchased = . $PSScriptRoot\Get-Purchased.ps1
$purchased | ?{ $_ -notin $downloaded } | % { (. $PSScriptRoot\Get-Key.ps1) + $_ }
