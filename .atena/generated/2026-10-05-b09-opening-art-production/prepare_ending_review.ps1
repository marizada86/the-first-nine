param([string]$ProjectRoot = 'D:/dev/eclipse-game-jam')
$ErrorActionPreference = 'Stop'
Add-Type -AssemblyName System.Drawing
$taskRoot = Join-Path $ProjectRoot '.atena/generated/2026-10-05-b09-opening-art-production'
$selection = Get-Content -LiteralPath (Join-Path $taskRoot 'ending-shadow-form-selection-v1.json') -Encoding UTF8 -Raw | ConvertFrom-Json
$masterDir = Join-Path $taskRoot 'ending-masters-v1'
$reviewDir = Join-Path $taskRoot 'ending-review-v1'
[void](New-Item -ItemType Directory -Path $masterDir -Force)
[void](New-Item -ItemType Directory -Path $reviewDir -Force)
$results = @()
function Read-Sha256($path) {
    $stream = [System.IO.File]::OpenRead($path)
    $sha = [System.Security.Cryptography.SHA256]::Create()
    try { return ([BitConverter]::ToString($sha.ComputeHash($stream))).Replace('-', '').ToLowerInvariant() }
    finally { $sha.Dispose(); $stream.Dispose() }
}
function Save-ScaledCrop($sourceImage, $sourceRect, $width, $height, $outputPath) {
    $bitmap = New-Object System.Drawing.Bitmap($width, $height)
    $graphics = [System.Drawing.Graphics]::FromImage($bitmap)
    try {
        $graphics.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::NearestNeighbor
        $graphics.PixelOffsetMode = [System.Drawing.Drawing2D.PixelOffsetMode]::Half
        $graphics.CompositingMode = [System.Drawing.Drawing2D.CompositingMode]::SourceCopy
        $destinationRect = New-Object System.Drawing.Rectangle(0, 0, $width, $height)
        $graphics.DrawImage($sourceImage, $destinationRect, $sourceRect, [System.Drawing.GraphicsUnit]::Pixel)
        if (Test-Path -LiteralPath $outputPath) {
            $memory = New-Object System.IO.MemoryStream
            $sha = [System.Security.Cryptography.SHA256]::Create()
            try {
                $bitmap.Save($memory, [System.Drawing.Imaging.ImageFormat]::Png)
                $expectedHash = ([BitConverter]::ToString($sha.ComputeHash($memory.ToArray()))).Replace('-', '').ToLowerInvariant()
                if ((Read-Sha256 $outputPath) -ne $expectedHash) { throw "Existing output differs; refusing to overwrite $outputPath" }
            } finally { $sha.Dispose(); $memory.Dispose() }
        } else { $bitmap.Save($outputPath, [System.Drawing.Imaging.ImageFormat]::Png) }
    } finally { $graphics.Dispose(); $bitmap.Dispose() }
}
foreach ($item in $selection.items) {
    $sourcePath = Join-Path $ProjectRoot $item.source
    $sourceImage = [System.Drawing.Image]::FromFile($sourcePath)
    try {
        $factor = [Math]::Floor([Math]::Min($sourceImage.Width / 16, $sourceImage.Height / 9))
        $cropWidth = [int]($factor * 16)
        $cropHeight = [int]($factor * 9)
        $cropX = [int][Math]::Floor(($sourceImage.Width - $cropWidth) / 2)
        $cropY = [int][Math]::Floor(($sourceImage.Height - $cropHeight) / 2)
        $crop = New-Object System.Drawing.Rectangle($cropX, $cropY, $cropWidth, $cropHeight)
        $masterPath = Join-Path $masterDir ($item.id + '.png')
        $reviewPath = Join-Path $reviewDir ($item.id + '.png')
        Save-ScaledCrop $sourceImage $crop 1920 1080 $masterPath
        Save-ScaledCrop $sourceImage $crop 1280 720 $reviewPath
        $results += [ordered]@{
            id = $item.id
            attempt = $item.attempt
            source = $item.source
            raw_dimensions = @($sourceImage.Width, $sourceImage.Height)
            raw_sha256 = Read-Sha256 $sourcePath
            normalization = 'Centered largest integer 16:9 crop; uniform nearest-neighbor scaling; original unchanged'
            crop = @($cropX, $cropY, $cropWidth, $cropHeight)
            master = $masterPath.Replace('\', '/')
            master_dimensions = @(1920, 1080)
            master_sha256 = Read-Sha256 $masterPath
            review = $reviewPath.Replace('\', '/')
            review_dimensions = @(1280, 720)
            review_sha256 = Read-Sha256 $reviewPath
            crop_visual_review = 'pending'
            caption = $item.caption
            runtime_admitted = $false
        }
    } finally { $sourceImage.Dispose() }
}
$sheetPath = Join-Path $reviewDir 'ending-contact-sheet.png'
if (Test-Path -LiteralPath $sheetPath) { throw "Refusing to overwrite $sheetPath" }
$sheet = New-Object System.Drawing.Bitmap(1320, 1240)
$sheetGraphics = [System.Drawing.Graphics]::FromImage($sheet)
$font = New-Object System.Drawing.Font('Arial', 13)
try {
    $sheetGraphics.Clear([System.Drawing.Color]::FromArgb(18, 18, 27))
    $sheetGraphics.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::NearestNeighbor
    $sheetGraphics.PixelOffsetMode = [System.Drawing.Drawing2D.PixelOffsetMode]::Half
    for ($index = 0; $index -lt $results.Count; $index++) {
        $row = [Math]::Floor($index / 2)
        $column = $index % 2
        $x = [int](20 + $column * 650)
        $y = [int](20 + $row * 405)
        $preview = [System.Drawing.Image]::FromFile($results[$index].review)
        try { $sheetGraphics.DrawImage($preview, $x, $y, 630, 354) } finally { $preview.Dispose() }
        $sheetGraphics.DrawString($results[$index].id.ToUpperInvariant(), $font, [System.Drawing.Brushes]::White, $x, $y + 360)
    }
    $sheetGraphics.DrawString('Final comic candidates - owner review pending', $font, [System.Drawing.Brushes]::White, 670, 860)
    $sheetGraphics.DrawString('Existing drow-front shadow creature anatomy', $font, [System.Drawing.Brushes]::White, 670, 890)
    $sheetGraphics.DrawString('Not admitted into the game', $font, [System.Drawing.Brushes]::White, 670, 920)
    $sheet.Save($sheetPath, [System.Drawing.Imaging.ImageFormat]::Png)
} finally { $font.Dispose(); $sheetGraphics.Dispose(); $sheet.Dispose() }
[ordered]@{
    status = 'normalized-awaiting-crop-and-owner-review'
    provider = 'built-in-imagegen'
    runtime_admitted = $false
    items = $results
    contact_sheet = $sheetPath.Replace('\', '/')
    contact_sheet_sha256 = Read-Sha256 $sheetPath
} | ConvertTo-Json -Depth 10
