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
$version = (Get-Content .\package.json | ConvertFrom-Json).version

Write-Host "============================================" -ForegroundColor Cyan
Write-Host " Building $PackageName v$version" -ForegroundColor Cyan
Write-Host "============================================" -ForegroundColor Cyan

# Step 1: Build Tailwind CSS
Write-Host "`n[1/6] Compiling Tailwind CSS..." -ForegroundColor Yellow
npm run build
if ($LASTEXITCODE -ne 0) { throw "Tailwind CSS build failed." }
Write-Host "  CSS compiled successfully." -ForegroundColor Green

# Step 2: Prepare output directory
Write-Host "`n[2/6] Preparing output directory..." -ForegroundColor Yellow
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

# Step 3: Create Resources.zip (skin files only, no dev files)
Write-Host "`n[3/6] Creating Resources.zip..." -ForegroundColor Yellow

$tempDir = Join-Path $env:TEMP "TailwindDNN_build_$(Get-Random)"
New-Item -ItemType Directory -Path $tempDir -Force | Out-Null

try {
    # Copy skin files
    $includes = @(
        "*.ascx",
        "includes",
        "src\css\style.min.css",
        "src\css\input.css"
    )

    # Copy root .ascx files
    Get-ChildItem -Path "." -Filter "*.ascx" -File | ForEach-Object {
        Copy-Item $_.FullName -Destination $tempDir
        Write-Host "    + $($_.Name)" -ForegroundColor DarkGray
    }

    # Copy includes folder
    if (Test-Path ".\includes") {
        $includesDir = Join-Path $tempDir "includes"
        Copy-Item ".\includes" -Destination $includesDir -Recurse
        Write-Host "    + includes\" -ForegroundColor DarkGray
    }

    # Copy compiled CSS
    $cssDir = Join-Path $tempDir "src\css"
    New-Item -ItemType Directory -Path $cssDir -Force | Out-Null
    if (Test-Path ".\src\css\style.min.css") {
        Copy-Item ".\src\css\style.min.css" -Destination $cssDir
        Write-Host "    + src\css\style.min.css" -ForegroundColor DarkGray
    }
    if (Test-Path ".\src\css\input.css") {
        Copy-Item ".\src\css\input.css" -Destination $cssDir
        Write-Host "    + src\css\input.css" -ForegroundColor DarkGray
    }
    if (Test-Path ".\src\css\browser-config.css") {
        Copy-Item ".\src\css\browser-config.css" -Destination $cssDir
        Write-Host "    + src\css\browser-config.css" -ForegroundColor DarkGray
    }

    # Copy JS files
    if (Test-Path ".\src\js") {
        $jsDir = Join-Path $tempDir "src\js"
        New-Item -ItemType Directory -Path $jsDir -Force | Out-Null
        Get-ChildItem -Path ".\src\js" -File | ForEach-Object {
            Copy-Item $_.FullName -Destination $jsDir
            Write-Host "    + src\js\$($_.Name)" -ForegroundColor DarkGray
        }
    }

    # Copy skin.doctype.xml
    if (Test-Path ".\skin.doctype.xml") {
        Copy-Item ".\skin.doctype.xml" -Destination $tempDir
        Write-Host "    + skin.doctype.xml" -ForegroundColor DarkGray
    }

    # Copy any additional asset folders (images, fonts, js, etc.)
    @("images", "fonts", "js", "assets", "menus") | ForEach-Object {
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

# Step 4: Create ContainerResources.zip
Write-Host "`n[4/6] Creating ContainerResources.zip..." -ForegroundColor Yellow

$containerTempDir = Join-Path $env:TEMP "TailwindDNN_containers_$(Get-Random)"
New-Item -ItemType Directory -Path $containerTempDir -Force | Out-Null

try {
    if (Test-Path ".\containers") {
        Get-ChildItem -Path ".\containers" -Filter "*.ascx" -File | ForEach-Object {
            Copy-Item $_.FullName -Destination $containerTempDir
            Write-Host "    + $($_.Name)" -ForegroundColor DarkGray
        }
    }

    # Copy compiled CSS for containers (same Tailwind CSS)
    $containerCssDir = Join-Path $containerTempDir "src\css"
    New-Item -ItemType Directory -Path $containerCssDir -Force | Out-Null
    if (Test-Path ".\src\css\style.min.css") {
        Copy-Item ".\src\css\style.min.css" -Destination $containerCssDir
        Write-Host "    + src\css\style.min.css" -ForegroundColor DarkGray
    }

    Compress-Archive -Path "$containerTempDir\*" -DestinationPath $containerResourcesZip -Force
    $containerSize = [math]::Round((Get-Item $containerResourcesZip).Length / 1KB, 1)
    Write-Host "  ContainerResources.zip created ($containerSize KB)" -ForegroundColor Green
}
finally {
    Remove-Item $containerTempDir -Recurse -Force -ErrorAction SilentlyContinue
}

# Step 5: Create final install package
Write-Host "`n[5/6] Creating install package..." -ForegroundColor Yellow

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
