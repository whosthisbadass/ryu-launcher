$ErrorActionPreference = 'Stop'

$baseDir = Split-Path -Parent $MyInvocation.MyCommand.Path

Add-Type -AssemblyName System.Windows.Forms
$screen = [System.Windows.Forms.Screen]::PrimaryScreen.Bounds
$width = [double]$screen.Width
$height = [double]$screen.Height
$aspectRatio = $width / $height

if ($aspectRatio -gt 2.0) {
    $portableFolder = Join-Path $baseDir 'portable-21x9'
} else {
    $portableFolder = Join-Path $baseDir 'portable-16x9'
}

Write-Output $portableFolder
