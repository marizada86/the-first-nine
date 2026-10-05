param([string]$ProjectRoot = 'D:/dev/eclipse-game-jam', [string]$Version = 'v1')
$ErrorActionPreference = 'Stop'
Add-Type -AssemblyName System.Drawing
Add-Type -ReferencedAssemblies System.Drawing -TypeDefinition @'
using System;
using System.Drawing;
using System.Drawing.Imaging;
using System.Runtime.InteropServices;
using System.Collections.Generic;
public static class ArtPixelAudit {
 public static int[] Scan(Bitmap b) {
  var rect=new Rectangle(0,0,b.Width,b.Height);
  var bits=b.LockBits(rect,ImageLockMode.ReadOnly,PixelFormat.Format32bppArgb);
  try {
   byte[] buf=new byte[Math.Abs(bits.Stride)*b.Height];
   Marshal.Copy(bits.Scan0,buf,0,buf.Length);
   int x0=b.Width,y0=b.Height,x1=-1,y1=-1,zero=0,full=0,semi=0;
   for(int y=0;y<b.Height;y++)for(int x=0;x<b.Width;x++){
    int alpha=buf[y*Math.Abs(bits.Stride)+x*4+3];
    if(alpha==0)zero++;else if(alpha==255)full++;else semi++;
    if(alpha>=128){x0=Math.Min(x0,x);y0=Math.Min(y0,y);x1=Math.Max(x1,x);y1=Math.Max(y1,y);}
   }
   return new int[]{x0,y0,x1,y1,zero,full,semi};
  } finally {b.UnlockBits(bits);}
 }
 public static Bitmap Patient(Bitmap src,int[] b,double s) {
  var result=new Bitmap(64,64,PixelFormat.Format32bppArgb);
  double ox=32-(b[2]-b[0]+1)*s/2,oy=56-(b[3]-b[1])*s;
  for(int y=0;y<64;y++)for(int x=0;x<64;x++){
   int sx=(int)Math.Round((x-ox)/s+b[0]),sy=(int)Math.Round((y-oy)/s+b[1]);
   if(sx<0||sy<0||sx>=src.Width||sy>=src.Height)continue;
   var c=src.GetPixel(sx,sy);
   if(c.A>=128)result.SetPixel(x,y,Color.FromArgb(255,c.R,c.G,c.B));
  }
  var bounds=Scan(result);int dy=56-bounds[3];
  if(dy!=0){var moved=new Bitmap(64,64);for(int y=0;y<64;y++)for(int x=0;x<64;x++)if(y+dy>=0&&y+dy<64)moved.SetPixel(x,y+dy,result.GetPixel(x,y));result.Dispose();result=moved;}
  // Deterministic sixteen-color quantization of only opaque pixels.
  var hist=new Dictionary<int,int>();
  for(int y=0;y<64;y++)for(int x=0;x<64;x++){var c=result.GetPixel(x,y);if(c.A==0)continue;int k=c.ToArgb();if(!hist.ContainsKey(k))hist[k]=0;hist[k]++;}
  var palette=new List<Color>();
  while(palette.Count<16&&palette.Count<hist.Count){
   int best=0;double score=-1;
   foreach(var pair in hist){var c=Color.FromArgb(pair.Key);double d=65025*3;
    foreach(var p in palette)d=Math.Min(d,Dist(c,p));
    double candidate=d*Math.Sqrt(pair.Value);
    if(candidate>score){score=candidate;best=pair.Key;}
   }
   palette.Add(Color.FromArgb(best));
  }
  for(int step=0;step<8;step++){
   double[,] sums=new double[palette.Count,4];
   foreach(var pair in hist){var c=Color.FromArgb(pair.Key);int i=Nearest(c,palette);sums[i,0]+=c.R*pair.Value;sums[i,1]+=c.G*pair.Value;sums[i,2]+=c.B*pair.Value;sums[i,3]+=pair.Value;}
   for(int i=0;i<palette.Count;i++)if(sums[i,3]>0)palette[i]=Color.FromArgb(255,(int)Math.Round(sums[i,0]/sums[i,3]),(int)Math.Round(sums[i,1]/sums[i,3]),(int)Math.Round(sums[i,2]/sums[i,3]));
  }
  for(int y=0;y<64;y++)for(int x=0;x<64;x++){var c=result.GetPixel(x,y);if(c.A>0)result.SetPixel(x,y,palette[Nearest(c,palette)]);}
  return result;
 }
 static double Dist(Color a,Color b){return (a.R-b.R)*(a.R-b.R)+(a.G-b.G)*(a.G-b.G)+(a.B-b.B)*(a.B-b.B);}
 static int Nearest(Color c,List<Color> p){int best=0;double d=double.MaxValue;for(int i=0;i<p.Count;i++){double v=Dist(c,p[i]);if(v<d){d=v;best=i;}}return best;}
}
'@
$taskRoot = Join-Path $ProjectRoot '.atena/generated/2026-10-05-b09-opening-art-production'
$selection = Get-Content -LiteralPath (Join-Path $taskRoot ('package-selection-'+$Version+'.json')) -Encoding UTF8 -Raw | ConvertFrom-Json
$masterDir = Join-Path $taskRoot ('package-masters-'+$Version)
$reviewDir = Join-Path $taskRoot ('package-review-'+$Version)
[void](New-Item -ItemType Directory -Path $masterDir -Force)
[void](New-Item -ItemType Directory -Path $reviewDir -Force)
function Read-Sha256($path) {
 $stream=[System.IO.File]::OpenRead($path);$sha=[System.Security.Cryptography.SHA256]::Create()
 try{return ([BitConverter]::ToString($sha.ComputeHash($stream))).Replace('-','').ToLowerInvariant()}finally{$sha.Dispose();$stream.Dispose()}
}
function Save-NewPng($bitmap,$path) {
 if(Test-Path -LiteralPath $path){
  $memory=New-Object System.IO.MemoryStream;$sha=[System.Security.Cryptography.SHA256]::Create()
  try{$bitmap.Save($memory,[System.Drawing.Imaging.ImageFormat]::Png);$expected=([BitConverter]::ToString($sha.ComputeHash($memory.ToArray()))).Replace('-','').ToLowerInvariant();if((Read-Sha256 $path) -ne $expected){throw "Existing output differs; refusing to overwrite $path"};return}finally{$memory.Dispose();$sha.Dispose()}
 }
 $bitmap.Save($path,[System.Drawing.Imaging.ImageFormat]::Png)
}
function Scaled($src,$rect,$width,$height) {
 $out=New-Object System.Drawing.Bitmap($width,$height)
 $g=[System.Drawing.Graphics]::FromImage($out)
 try{$g.InterpolationMode=[System.Drawing.Drawing2D.InterpolationMode]::NearestNeighbor;$g.PixelOffsetMode=[System.Drawing.Drawing2D.PixelOffsetMode]::Half;$g.CompositingMode=[System.Drawing.Drawing2D.CompositingMode]::SourceCopy;$g.DrawImage($src,(New-Object System.Drawing.Rectangle(0,0,$width,$height)),$rect,[System.Drawing.GraphicsUnit]::Pixel)}finally{$g.Dispose()}
 return $out
}
$results=@()
foreach($item in $selection.items) {
 $sourcePath=Join-Path $ProjectRoot $item.source
 $src=New-Object System.Drawing.Bitmap($sourcePath)
 try {
  $masterPath=Join-Path $masterDir ($item.id+'.png');$reviewPath=Join-Path $reviewDir ($item.id+'.png')
  $entry=[ordered]@{id=$item.id;kind=$item.kind;attempt=$item.attempt;source=$item.source;raw_dimensions=@($src.Width,$src.Height);raw_sha256=(Read-Sha256 $sourcePath);owner_accepted=$item.owner_accepted;runtime_admitted=$false;master=$masterPath.Replace('\','/');review=$reviewPath.Replace('\','/')}
  if($item.kind -eq 'patient') {
   $stats=[ArtPixelAudit]::Scan($src)
   if($stats[4] -eq 0 -or $stats[5] -eq 0){throw "Missing real alpha in $($item.id)"}
   $length=0.0
   for($i=1;$i -lt $item.landmarks.Count;$i++){$dx=$item.landmarks[$i][0]-$item.landmarks[$i-1][0];$dy=$item.landmarks[$i][1]-$item.landmarks[$i-1][1];$length += [Math]::Sqrt($dx*$dx+$dy*$dy)}
   $scale=40.0/$length
   $out=[ArtPixelAudit]::Patient($src,$stats,$scale)
   try {
    $final=[ArtPixelAudit]::Scan($out)
    if($final[0] -lt 2 -or $final[1] -lt 2 -or $final[2] -gt 61 -or $final[3] -ne 56){throw "Unsafe gutter or pivot: $($item.id)"}
    Save-NewPng $out $masterPath
    $preview=Scaled $out (New-Object System.Drawing.Rectangle(0,0,64,64)) 512 512
    try{Save-NewPng $preview $reviewPath}finally{$preview.Dispose()}
    $colors=New-Object 'System.Collections.Generic.HashSet[int]'
    for($y=0;$y -lt 64;$y++){for($x=0;$x -lt 64;$x++){$c=$out.GetPixel($x,$y);if($c.A -gt 0){[void]$colors.Add($c.ToArgb())}}}
    $entry.raw_alpha_counts=@($stats[4],$stats[5],$stats[6]);$entry.raw_visible_bounds=@($stats[0],$stats[1],$stats[2],$stats[3])
    $entry.landmarks=$item.landmarks;$entry.raw_anatomical_length=$length;$entry.uniform_scale=$scale
    $entry.normalized_anatomical_length=40;$entry.body_ratio=1.0
    $entry.measurement_method=$selection.landmark_method
    $entry.normalization='Uniform nearest sample to 64 cell; alpha128 threshold; sixteen-color quantization; translate to ground y56. Originals preserved.'
    $entry.master_dimensions=@(64,64);$entry.review_dimensions=@(512,512);$entry.normalized_bounds=@($final[0],$final[1],$final[2],$final[3]);$entry.palette_colors=$colors.Count
    $entry.ground_pivot=@(32,56);$entry.normalized_alpha_counts=@($final[4],$final[5],$final[6])
   } finally {$out.Dispose()}
  } else {
   $factor=[Math]::Floor([Math]::Min($src.Width/16,$src.Height/9))
   $crop=New-Object System.Drawing.Rectangle(([int][Math]::Floor(($src.Width-16*$factor)/2)),([int][Math]::Floor(($src.Height-9*$factor)/2)),([int](16*$factor)),([int](9*$factor)))
   $out=Scaled $src $crop 1920 1080
   try{Save-NewPng $out $masterPath}finally{$out.Dispose()}
   $out=Scaled $src $crop 1280 720
   try{Save-NewPng $out $reviewPath}finally{$out.Dispose()}
   $entry.crop=@($crop.X,$crop.Y,$crop.Width,$crop.Height);$entry.normalization='Centered largest integer 16:9 crop; uniform nearest-neighbor resize; originals preserved.'
   $entry.master_dimensions=@(1920,1080);$entry.review_dimensions=@(1280,720)
  }
  $entry.master_sha256=Read-Sha256 $masterPath;$entry.review_sha256=Read-Sha256 $reviewPath
  $results += $entry
 } finally {$src.Dispose()}
}
function Contact-Sheet($ids,$columns,$thumbW,$thumbH,$name) {
 $rows=[int][Math]::Ceiling($ids.Count/$columns);$cellW=$thumbW+20;$cellH=$thumbH+45
 $sheet=New-Object System.Drawing.Bitmap(($columns*$cellW+20),($rows*$cellH+50))
 $g=[System.Drawing.Graphics]::FromImage($sheet);$font=New-Object System.Drawing.Font('Arial',12)
 try {
  $g.Clear([System.Drawing.Color]::FromArgb(23,25,33));$g.InterpolationMode=[System.Drawing.Drawing2D.InterpolationMode]::NearestNeighbor;$g.PixelOffsetMode=[System.Drawing.Drawing2D.PixelOffsetMode]::Half
  for($i=0;$i -lt $ids.Count;$i++) {
   $entry=$results|Where-Object {$_.id -eq $ids[$i]};$x=20+($i%$columns)*$cellW;$y=20+[int][Math]::Floor($i/$columns)*$cellH
   $image=[System.Drawing.Image]::FromFile($entry.review)
   try{$g.DrawImage($image,$x,$y,$thumbW,$thumbH)}finally{$image.Dispose()}
   if($entry.kind -eq 'patient'){$g.DrawLine([System.Drawing.Pens]::DimGray,$x,$y+56*$thumbH/64,$x+$thumbW,$y+56*$thumbH/64)}
   $g.DrawString($entry.id,$font,[System.Drawing.Brushes]::White,$x,$y+$thumbH+6)
  }
  $g.DrawString('Offline art review - not admitted into the game',$font,[System.Drawing.Brushes]::LightGray,20,$rows*$cellH+20)
  $path=Join-Path $reviewDir $name;Save-NewPng $sheet $path
  return $path.Replace('\','/')
 } finally {$font.Dispose();$g.Dispose();$sheet.Dispose()}
}
$sheets=@()
$sheets += Contact-Sheet @($results|Where-Object {$_.id -like 'h01-*'}|ForEach-Object {$_.id}) 3 480 270 'opening-contact-sheet.png'
$sheets += Contact-Sheet @($results|Where-Object {$_.id -like 'h02-*'}|ForEach-Object {$_.id}) 3 480 270 'bargain-contact-sheet.png'
$sheets += Contact-Sheet @($results|Where-Object {$_.kind -eq 'environment'}|ForEach-Object {$_.id}) 1 960 540 'cave-contact-sheet.png'
$sheets += Contact-Sheet @($results|Where-Object {$_.kind -eq 'patient'}|ForEach-Object {$_.id}) 4 256 256 'patients-contact-sheet.png'
[ordered]@{status='normalized-awaiting-visual-package-review';runtime_admitted=$false;items=$results;contact_sheets=$sheets} | ConvertTo-Json -Depth 12 -Compress
