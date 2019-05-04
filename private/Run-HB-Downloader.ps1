if ((. $PSScriptRoot\Get-Purchased-Not-Downloaded.ps1).count -gt 0) {
    . $PSScriptRoot\Get-Purchased-Not-Downloaded.ps1 | Set-Content $PSScriptRoot\..\HB-DRM-free-bulk-downloader\links.txt
    . $PSScriptRoot\..\HB-DRM-free-bulk-downloader\HB-DRM-Free_download.ps1
    Remove-Item $PSScriptRoot\..\HB-DRM-free-bulk-downloader\links.txt
    Get-ChildItem $PSScriptRoot\..\HB-DRM-free-bulk-downloader\downloads\ | % { 
        $file = $_

        if ($file.Name -eq 'temp') {
            if ((Get-ChildItem $file.FullName).Count -eq 0) {
                Remove-Item $file.FullName -Force
            } else {
                "ERROR TEMP NOT EMPTY. MOVE INCOMPLETE."
            }
        } else {
            $appendCounter = 0

            while ((. $PSScriptRoot\Get-Purchased | ? {$_.Name -eq ($file.Name + $(if ($appendCounter -ne 0) { '_' + $appendCounter }))}).Count -ne 0) {
                $appendCounter++
            }
            Move-Item $file.FullName "$PSScriptRoot\..\downloads\$(if ($appendCounter -ne 0) { '_' + $appendCounter })" -Force
        }
    }
    if ((Get-ChildItem $PSScriptRoot\..\HB-DRM-free-bulk-downloader\downloads).Count -eq 0) {
        Remove-Item $PSScriptRoot\..\HB-DRM-free-bulk-downloader\downloads -Force
    } else {
        throw "ERROR MOVING FILES. MOVE INCOMPLETE."
    }
} else {
    "No New Purchases"
}
