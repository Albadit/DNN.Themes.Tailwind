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
$ScriptDir = $PSScriptRoot
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
    $ascxFiles = Get-ChildItem -Path "." -Filter "*.ascx" -File
    foreach ($f in $ascxFiles) {
        Copy-Item $f.FullName -Destination $tempDir
    }
    if ($ascxFiles.Count -gt 0) {
        Write-Host "    + *.ascx ($($ascxFiles.Count) files)" -ForegroundColor DarkGray
    }

    # Copy koi.json
    if (Test-Path ".\koi.json") {
        Copy-Item ".\koi.json" -Destination $tempDir
        Write-Host "    + koi.json" -ForegroundColor DarkGray
    }


    # Copy folders
    @("partials", "css", "js", "images", "fonts", "assets", "menus") | ForEach-Object {
        if (Test-Path ".\$_") {
            Copy-Item ".\$_" -Destination (Join-Path $tempDir $_) -Recurse
            $count = (Get-ChildItem ".\$_" -Recurse -File).Count
            Write-Host "    + $_\ ($count files)" -ForegroundColor DarkGray
        }
    }

    # Copy skin.doctype.xml
    if (Test-Path ".\skin.doctype.xml") {
        Copy-Item ".\skin.doctype.xml" -Destination $tempDir
        Write-Host "    + skin.doctype.xml" -ForegroundColor DarkGray
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
        $containerFiles = Get-ChildItem -Path ".\containers" -Filter "*.ascx" -File
        foreach ($f in $containerFiles) {
            Copy-Item $f.FullName -Destination $containerTempDir
        }
        if ($containerFiles.Count -gt 0) {
            Write-Host "    + containers\ ($($containerFiles.Count) files)" -ForegroundColor DarkGray
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
    # Copy root files
    $rootFiles = @(
        "manifest.dnn",
        "License.txt",
        "ReleaseNotes.txt"
    )
    foreach ($file in $rootFiles) {
        $src = Join-Path $ScriptDir $file
        if (Test-Path $src) {
            Copy-Item $src (Join-Path $packageTemp $file)
            Write-Host "    + $file" -ForegroundColor DarkGray
        } else {
            Write-Warning "Missing: $file"
        }
    }

    # Copy Resources.zip and ContainerResources.zip
    Copy-Item $resourcesZip -Destination $packageTemp
    Write-Host "    + Resources.zip" -ForegroundColor DarkGray
    Copy-Item $containerResourcesZip -Destination $packageTemp
    Write-Host "    + ContainerResources.zip" -ForegroundColor DarkGray

    # Copy skin .ascx files (DNN SkinInstaller needs them at package root)
    $skinAscx = Get-ChildItem -Path "." -Filter "*.ascx" -File
    foreach ($f in $skinAscx) {
        Copy-Item $f.FullName -Destination $packageTemp
    }
    if ($skinAscx.Count -gt 0) {
        Write-Host "    + Skin\ ($($skinAscx.Count) files)" -ForegroundColor DarkGray
    }

    # Copy container .ascx files (DNN ContainerInstaller needs them at package root)
    if (Test-Path ".\containers") {
        $containerAscx = Get-ChildItem -Path ".\containers" -Filter "*.ascx" -File
        foreach ($f in $containerAscx) {
            Copy-Item $f.FullName -Destination $packageTemp
        }
        if ($containerAscx.Count -gt 0) {
            Write-Host "    + Containers\ ($($containerAscx.Count) files)" -ForegroundColor DarkGray
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
