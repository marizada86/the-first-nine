param(
    [string]$Source,
    [string]$Destination,
    [int]$MinimumComponentPixels = 64
)

Add-Type -AssemblyName System.Drawing
$image = [System.Drawing.Bitmap]::FromFile($Source)
$width = $image.Width
$height = $image.Height
$seen = [bool[]]::new($width * $height)

for ($y = 0; $y -lt $height; $y++) {
    for ($x = 0; $x -lt $width; $x++) {
        $seed = $y * $width + $x
        if ($seen[$seed] -or $image.GetPixel($x, $y).A -eq 0) { continue }
        $stack = [System.Collections.Generic.Stack[System.Drawing.Point]]::new()
        $pixels = [System.Collections.Generic.List[System.Drawing.Point]]::new()
        $stack.Push([System.Drawing.Point]::new($x, $y))
        $seen[$seed] = $true
        while ($stack.Count -gt 0) {
            $point = $stack.Pop()
            $pixels.Add($point)
            for ($dy = -1; $dy -le 1; $dy++) {
                for ($dx = -1; $dx -le 1; $dx++) {
                    $nx = $point.X + $dx; $ny = $point.Y + $dy
                    if (($dx -eq 0 -and $dy -eq 0) -or $nx -lt 0 -or $ny -lt 0 -or $nx -ge $width -or $ny -ge $height) { continue }
                    $index = $ny * $width + $nx
                    if (-not $seen[$index] -and $image.GetPixel($nx, $ny).A -gt 0) {
                        $seen[$index] = $true
                        $stack.Push([System.Drawing.Point]::new($nx, $ny))
                    }
                }
            }
        }
        if ($pixels.Count -lt $MinimumComponentPixels) {
            foreach ($point in $pixels) { $image.SetPixel($point.X, $point.Y, [System.Drawing.Color]::FromArgb(0, 0, 0, 0)) }
        }
    }
}

$image.Save($Destination, [System.Drawing.Imaging.ImageFormat]::Png)
$image.Dispose()
