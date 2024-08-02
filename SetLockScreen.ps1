#get files from GitHub
Invoke-WebRequest https://github.com/drewpchannel/LockScreenSet/archive/refs/heads/main.zip -OutFile .\lss.zip
Expand-Archive .\lss.zip -Force

$regKey = 'HKLM:\\SOFTWARE\\Policies\\Microsoft\\Windows\\Personalization'
if (!(Test-Path -Path $regKey)) {
    $null = New-Item -Path $regKey
}

#unused at the moment
$regKey2 = 'HKLM:\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\PersonalizationCSP'
if (!(Test-Path -Path $regKey2)) {
    $null = New-Item -Path $regKey2
}

#change to path of downloaded wallpaper.
$filePath = Resolve-Path ".\lss\LockScreenSet-main"

$imgPath = "$filePath\Treeline Lockscreen.png"
Write-Host $imgPath

Set-ItemProperty -Path $regKey -Name LockScreenImage -Value $imgPath
Set-ItemProperty -Path $regKey -Name LockScreenImageStatus -Value 1 -Type DWORD 
Set-ItemProperty -Path $regKey -Name LockScreenImagePath -Value $imgPath
Set-ItemProperty -Path $regKey -Name LockScreenImageUrl -Value $imgPath

Set-ItemProperty -Path $regKey2 -Name LockScreenImage -Value $imgPath
Set-ItemProperty -Path $regKey2 -Name LockScreenImageStatus -Value 1 -Type DWORD 
Set-ItemProperty -Path $regKey2 -Name LockScreenImagePath -Value $imgPath
Set-ItemProperty -Path $regKey2 -Name LockScreenImageUrl -Value $imgPath