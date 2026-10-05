$ErrorActionPreference='Stop'
Add-Type -AssemblyName System.Drawing
$taskRoot='D:/dev/eclipse-game-jam/.atena/generated/2026-10-05-b09-opening-art-production'
$data=Get-Content -LiteralPath (Join-Path $taskRoot 'package-technical-v2.json') -Encoding UTF8 -Raw|ConvertFrom-Json
$output=Join-Path $taskRoot 'package-review-v2/patients-scale-comparison.png'
if(Test-Path -LiteralPath $output){throw "Refusing to overwrite $output"}
$sheet=New-Object System.Drawing.Bitmap(1280,720)
$g=[System.Drawing.Graphics]::FromImage($sheet)
$font=New-Object System.Drawing.Font('Arial',11)
$pointPen=New-Object System.Drawing.Pen([System.Drawing.Color]::Coral,1)
try {
 $g.Clear([System.Drawing.Color]::FromArgb(23,25,33))
 $g.InterpolationMode=[System.Drawing.Drawing2D.InterpolationMode]::NearestNeighbor
 $g.PixelOffsetMode=[System.Drawing.Drawing2D.PixelOffsetMode]::Half
 $g.DrawString('Common body scale - standing Nolf and eight reclining patients',$font,[System.Drawing.Brushes]::White,20,10)
 $entries=@([pscustomobject]@{id='Nolf existing Mark III idle';kind='reference';master='D:/dev/eclipse-game-jam/.atena/generated/2026-10-05-lolth-three-transformations/lolth-mark-3-atlas-v1.png'})
 $entries+=@($data.items|Where-Object {$_.kind -eq 'patient'})
 for($i=0;$i -lt $entries.Count;$i++){
  $e=$entries[$i];$cx=20+($i%3)*420;$cy=35+[int][Math]::Floor($i/3)*220
  $image=[System.Drawing.Image]::FromFile($e.master)
  try {
   $rect=New-Object System.Drawing.Rectangle(0,0,64,64)
   if($e.kind -eq 'reference'){$rect=New-Object System.Drawing.Rectangle(24,43,64,64)}
   $dest=New-Object System.Drawing.Rectangle(($cx+40),($cy-34),256,256)
   $g.DrawImage($image,$dest,$rect,[System.Drawing.GraphicsUnit]::Pixel)
   $g.DrawLine([System.Drawing.Pens]::DimGray,$cx,$cy+190,$cx+390,$cy+190)
   if($e.kind -eq 'patient'){
    for($j=0;$j -lt $e.normalized_landmarks.Count;$j++){
     $p=$e.normalized_landmarks[$j];$px=$cx+40+4*$p[0];$py=$cy-34+4*$p[1]
     $g.DrawEllipse($pointPen,$px-2,$py-2,4,4)
     if($j -gt 0){$last=$e.normalized_landmarks[$j-1];$g.DrawLine($pointPen,($cx+40+4*$last[0]),($cy-34+4*$last[1]),$px,$py)}
    }
    $label=$e.id+'  body '+([Math]::Round($e.raster_landmark_length,2))+' / 40'
   }else{$label=$e.id+'  body baseline 40'}
   $g.DrawString($label,$font,[System.Drawing.Brushes]::White,$cx,$cy+195)
  }finally{$image.Dispose()}
 }
 $g.DrawString('Coral points: manually reviewed crown, neck, hip, knee, heel. No runtime admission.',$font,[System.Drawing.Brushes]::LightGray,20,704)
 $sheet.Save($output,[System.Drawing.Imaging.ImageFormat]::Png)
}finally{$font.Dispose();$pointPen.Dispose();$g.Dispose();$sheet.Dispose()}
$output
