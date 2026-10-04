param([string]$Path, [int]$Threshold = 32)

Add-Type -AssemblyName System.Drawing
$image = [System.Drawing.Bitmap]::FromFile($Path)
$width = $image.Width
$height = $image.Height
$seen = [bool[]]::new($width * $height)
$components = [System.Collections.Generic.List[object]]::new()

for ($y = 0; $y -lt $height; $y++) {
    for ($x = 0; $x -lt $width; $x++) {
        $seed = $y * $width + $x
        if ($seen[$seed] -or $image.GetPixel($x, $y).A -lt $Threshold) { continue }
        $stack = [System.Collections.Generic.Stack[System.Drawing.Point]]::new()
        $stack.Push([System.Drawing.Point]::new($x, $y))
        $seen[$seed] = $true
        $count = 0; $minX = $x; $maxX = $x; $minY = $y; $maxY = $y
        while ($stack.Count -gt 0) {
            $point = $stack.Pop(); $count++
            $minX = [Math]::Min($minX, $point.X); $maxX = [Math]::Max($maxX, $point.X)
            $minY = [Math]::Min($minY, $point.Y); $maxY = [Math]::Max($maxY, $point.Y)
            for ($dy = -1; $dy -le 1; $dy++) {
                for ($dx = -1; $dx -le 1; $dx++) {
                    $nx = $point.X + $dx; $ny = $point.Y + $dy
                    if (($dx -eq 0 -and $dy -eq 0) -or $nx -lt 0 -or $ny -lt 0 -or $nx -ge $width -or $ny -ge $height) { continue }
                    $index = $ny * $width + $nx
                    if (-not $seen[$index] -and $image.GetPixel($nx, $ny).A -ge $Threshold) {
                        $seen[$index] = $true
                        $stack.Push([System.Drawing.Point]::new($nx, $ny))
                    }
                }
            }
        }
        $components.Add([PSCustomObject]@{ pixels = $count; bounds = "$minX,$minY-$maxX,$maxY" })
    }
}
$image.Dispose()
$components | Sort-Object pixels | Select-Object -First 40 | ConvertTo-Json
