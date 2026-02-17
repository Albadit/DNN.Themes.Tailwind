# Build script for TailwindDNN skin package
# Run: powershell -ExecutionPolicy Bypass -File build.ps1

$skinName = "TailwindDNN"
$outputDir = Join-Path $PSScriptRoot "dist"
$outputZip = Join-Path $outputDir "$skinName.zip"

# Create dist folder
if (!(Test-Path $outputDir)) {
    New-Item -ItemType Directory -Path $outputDir | Out-Null
}

# Remove old zip if exists
if (Test-Path $outputZip) {
    Remove-Item $outputZip -Force
}

# Create a temp staging folder
$staging = Join-Path $env:TEMP "$skinName-staging"
if (Test-Path $staging) {
    Remove-Item $staging -Recurse -Force
}
New-Item -ItemType Directory -Path $staging | Out-Null

# --- Build Resources.zip ---
# This contains all supporting files (components, js, menus, themes, skin.doctype.xml, etc.)
$resourceStaging = Join-Path $env:TEMP "$skinName-resources"
if (Test-Path $resourceStaging) {
    Remove-Item $resourceStaging -Recurse -Force
}
New-Item -ItemType Directory -Path $resourceStaging | Out-Null

$resourceItems = @(
    "components",
    "js",
    "menus",
    "themes",
    "skin.doctype.xml"
)

foreach ($item in $resourceItems) {
    $source = Join-Path $PSScriptRoot $item
    if (Test-Path $source) {
        $dest = Join-Path $resourceStaging $item
        if ((Get-Item $source).PSIsContainer) {
            Copy-Item $source $dest -Recurse
        } else {
            Copy-Item $source $dest
        }
    } else {
        Write-Warning "Skipping missing resource: $item"
    }
}

$resourcesZip = Join-Path $staging "Resources.zip"
Compress-Archive -Path "$resourceStaging\*" -DestinationPath $resourcesZip -Force
Remove-Item $resourceStaging -Recurse -Force

# --- Copy top-level files to staging ---
# These are referenced directly in the .dnn manifest
$topLevelFiles = @(
    "default.ascx",
    "TailwindDNN.dnn",
    "LICENSE"
)

foreach ($item in $topLevelFiles) {
    $source = Join-Path $PSScriptRoot $item
    if (Test-Path $source) {
        Copy-Item $source (Join-Path $staging $item)
    } else {
        Write-Warning "Skipping missing: $item"
    }
}

# --- Copy container files into staging root (DNN expects them at zip root) ---
$containerSource = Join-Path $PSScriptRoot "container"
if (Test-Path $containerSource) {
    Get-ChildItem $containerSource -File | ForEach-Object {
        Copy-Item $_.FullName (Join-Path $staging $_.Name)
    }
}

# --- Create final install zip ---
Compress-Archive -Path "$staging\*" -DestinationPath $outputZip -Force

# Cleanup
Remove-Item $staging -Recurse -Force

Write-Host ""
Write-Host "Built: $outputZip" -ForegroundColor Green
Write-Host "Upload this zip to DNN > Host > Extensions > Install Extension"
