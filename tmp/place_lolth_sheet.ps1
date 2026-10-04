param([string]$Source,[string]$Destination,[int]$Columns,[int]$Rows,[double]$CanvasScale,[double[]]$FeetRatios,[int]$CellSize = 256,[double]$Baseline = 0.90)
$ErrorActionPreference = 'Stop'
Add-Type -AssemblyName System.Drawing
$frameCount = $Columns * $Rows
if ($FeetRatios.Count -eq 0) { $FeetRatios = @(0.93) * $frameCount }
if ($FeetRatios.Count -ne $frameCount) { throw 'FeetRatios must contain one value per frame.' }
$sourceBitmap=[System.Drawing.Bitmap]::FromFile($Source)
$sourceW=[int]($sourceBitmap.Width/$Columns); $sourceH=[int]($sourceBitmap.Height/$Rows)
$out=[System.Drawing.Bitmap]::new($Columns*$CellSize,$Rows*$CellSize,[System.Drawing.Imaging.PixelFormat]::Format32bppArgb)
$g=[System.Drawing.Graphics]::FromImage($out); $g.Clear([System.Drawing.Color]::Transparent); $g.InterpolationMode=[System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
$destH=[int]($CellSize*$CanvasScale); $destW=[int]($destH*$sourceW/$sourceH)
for($row=0;$row -lt $Rows;$row++){for($column=0;$column -lt $Columns){$index=$row*$Columns+$column;$feet=$FeetRatios[$index];$x=$column*$CellSize+[int](($CellSize-$destW)/2);$y=$row*$CellSize+[int]($CellSize*$Baseline-$destH*$feet);$sourceRect=[System.Drawing.Rectangle]::new($column*$sourceW,$row*$sourceH,$sourceW,$sourceH);$destRect=[System.Drawing.Rectangle]::new($x,$y,$destW,$destH);$g.DrawImage($sourceBitmap,$destRect,$sourceRect,[System.Drawing.GraphicsUnit]::Pixel)}}
$out.Save($Destination,[System.Drawing.Imaging.ImageFormat]::Png);$g.Dispose();$out.Dispose();$sourceBitmap.Dispose()
