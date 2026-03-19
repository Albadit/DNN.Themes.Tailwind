# =============================================================================
# TailwindDNN - DNN Skin Package Build Script
# =============================================================================
# Creates an installable DNN skin package (zip) with:
#   - manifest.dnn manifest at root
#   - Resources.zip containing all skin files (ascx, css, includes, etc.)
#   - ContainerResources.zip containing container files
# =============================================================================

param(
    [string]$OutputDir = ".\dist",
    [string]$PackageName = "TailwindDNN"
)

$ErrorActionPreference = "Stop"
$version = "1.0.0"

Write-Host "============================================" -ForegroundColor Cyan
Write-Host " Building $PackageName v$version" -ForegroundColor Cyan
Write-Host "============================================" -ForegroundColor Cyan

# Step 1: Prepare output directory
Write-Host "`n[1/5] Preparing output directory..." -ForegroundColor Yellow
$distPath = Resolve-Path $OutputDir -ErrorAction SilentlyContinue
if (-not $distPath) {
    New-Item -ItemType Directory -Path $OutputDir -Force | Out-Null
    $distPath = Resolve-Path $OutputDir
}
$resourcesZip = Join-Path $distPath "Resources.zip"
$containerResourcesZip = Join-Path $distPath "ContainerResources.zip"
$packageZip = Join-Path $distPath "${PackageName}_${version}_Install.zip"

# Clean previous builds
Remove-Item $resourcesZip -ErrorAction SilentlyContinue
Remove-Item $containerResourcesZip -ErrorAction SilentlyContinue
Remove-Item $packageZip -ErrorAction SilentlyContinue
Write-Host "  Output: $distPath" -ForegroundColor Green

# Step 2: Create Resources.zip (skin files only, no dev files)
Write-Host "`n[2/5] Creating Resources.zip..." -ForegroundColor Yellow

$tempDir = Join-Path $env:TEMP "TailwindDNN_build_$(Get-Random)"
New-Item -ItemType Directory -Path $tempDir -Force | Out-Null

try {
    # Copy root .ascx files
    Get-ChildItem -Path "." -Filter "*.ascx" -File | ForEach-Object {
        Copy-Item $_.FullName -Destination $tempDir
        Write-Host "    + $($_.Name)" -ForegroundColor DarkGray
    }

    # Copy koi.json
    if (Test-Path ".\koi.json") {
        Copy-Item ".\koi.json" -Destination $tempDir
        Write-Host "    + koi.json" -ForegroundColor DarkGray
    }


    # Copy partials folder
    if (Test-Path ".\partials") {
        $partialsDir = Join-Path $tempDir "partials"
        Copy-Item ".\partials" -Destination $partialsDir -Recurse
        Write-Host "    + partials\" -ForegroundColor DarkGray
    }

    # Copy css folder
    if (Test-Path ".\css") {
        $cssDir = Join-Path $tempDir "css"
        Copy-Item ".\css" -Destination $cssDir -Recurse
        Write-Host "    + css\" -ForegroundColor DarkGray
    }

    # Copy js folder
    if (Test-Path ".\js") {
        $jsDir = Join-Path $tempDir "js"
        Copy-Item ".\js" -Destination $jsDir -Recurse
        Write-Host "    + js\" -ForegroundColor DarkGray
    }

    # Copy skin.doctype.xml
    if (Test-Path ".\skin.doctype.xml") {
        Copy-Item ".\skin.doctype.xml" -Destination $tempDir
        Write-Host "    + skin.doctype.xml" -ForegroundColor DarkGray
    }

    # Copy any additional asset folders (images, fonts, css, js, etc.)
    @("images", "fonts", "css", "js", "assets", "menus") | ForEach-Object {
        if (Test-Path ".\$_") {
            Copy-Item ".\$_" -Destination (Join-Path $tempDir $_) -Recurse
            Write-Host "    + $_\" -ForegroundColor DarkGray
        }
    }

    # Create Resources.zip
    Compress-Archive -Path "$tempDir\*" -DestinationPath $resourcesZip -Force
    $resourcesSize = [math]::Round((Get-Item $resourcesZip).Length / 1KB, 1)
    Write-Host "  Resources.zip created ($resourcesSize KB)" -ForegroundColor Green
}
finally {
    Remove-Item $tempDir -Recurse -Force -ErrorAction SilentlyContinue
}

# Step 3: Create ContainerResources.zip
Write-Host "`n[3/5] Creating ContainerResources.zip..." -ForegroundColor Yellow

$containerTempDir = Join-Path $env:TEMP "TailwindDNN_containers_$(Get-Random)"
New-Item -ItemType Directory -Path $containerTempDir -Force | Out-Null

try {
    if (Test-Path ".\containers") {
        Get-ChildItem -Path ".\containers" -Filter "*.ascx" -File | ForEach-Object {
            Copy-Item $_.FullName -Destination $containerTempDir
            Write-Host "    + $($_.Name)" -ForegroundColor DarkGray
        }
    }

    Compress-Archive -Path "$containerTempDir\*" -DestinationPath $containerResourcesZip -Force
    $containerSize = [math]::Round((Get-Item $containerResourcesZip).Length / 1KB, 1)
    Write-Host "  ContainerResources.zip created ($containerSize KB)" -ForegroundColor Green
}
finally {
    Remove-Item $containerTempDir -Recurse -Force -ErrorAction SilentlyContinue
}

# Step 4: Create final install package
Write-Host "`n[4/5] Creating install package..." -ForegroundColor Yellow

$packageTemp = Join-Path $env:TEMP "TailwindDNN_pkg_$(Get-Random)"
New-Item -ItemType Directory -Path $packageTemp -Force | Out-Null

try {
    # Copy manifest
    Copy-Item ".\manifest.dnn" -Destination $packageTemp
    Write-Host "    + manifest.dnn" -ForegroundColor DarkGray

    # Copy skin .ascx files (DNN SkinInstaller needs them at package root)
    Get-ChildItem -Path "." -Filter "*.ascx" -File | ForEach-Object {
        Copy-Item $_.FullName -Destination $packageTemp
        Write-Host "    + $($_.Name)" -ForegroundColor DarkGray
    }

    # Copy container .ascx files (DNN ContainerInstaller needs them at package root)
    if (Test-Path ".\containers") {
        Get-ChildItem -Path ".\containers" -Filter "*.ascx" -File | ForEach-Object {
            Copy-Item $_.FullName -Destination $packageTemp
            Write-Host "    + $($_.Name) (container)" -ForegroundColor DarkGray
        }
    }

    # Copy Resources.zip and ContainerResources.zip
    Copy-Item $resourcesZip -Destination $packageTemp
    Write-Host "    + Resources.zip" -ForegroundColor DarkGray
    Copy-Item $containerResourcesZip -Destination $packageTemp
    Write-Host "    + ContainerResources.zip" -ForegroundColor DarkGray

    # Copy License and Release Notes if they exist
    @("License.txt", "ReleaseNotes.txt") | ForEach-Object {
        if (Test-Path ".\$_") {
            Copy-Item ".\$_" -Destination $packageTemp
            Write-Host "    + $_" -ForegroundColor DarkGray
        }
    }

    # Create final package zip
    Compress-Archive -Path "$packageTemp\*" -DestinationPath $packageZip -Force
    $packageSize = [math]::Round((Get-Item $packageZip).Length / 1KB, 1)
    Write-Host "  Install package created ($packageSize KB)" -ForegroundColor Green
}
finally {
    Remove-Item $packageTemp -Recurse -Force -ErrorAction SilentlyContinue
    Remove-Item $resourcesZip -ErrorAction SilentlyContinue
    Remove-Item $containerResourcesZip -ErrorAction SilentlyContinue
}

# Done
Write-Host "`n============================================" -ForegroundColor Cyan
Write-Host " Build complete!" -ForegroundColor Green
Write-Host " Package: $packageZip" -ForegroundColor White
Write-Host " Install via: Host > Extensions > Install Extension" -ForegroundColor White
Write-Host "============================================`n" -ForegroundColor Cyan
