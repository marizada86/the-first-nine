from pathlib import Path
from PIL import Image, ImageDraw
import json, hashlib

ROOT = Path(__file__).resolve().parent
NAMES = {3:'BLACK PULSE',5:'NIGHT CHOIR',7:"SPIDER'S PROMISE"}
report = {}
board = Image.new('RGB',(1280,320),'#1e1b2c')
draw = ImageDraw.Draw(board)
base=Image.open(ROOT.parents[2]/'assets/runtime_v2/characters/lolth/lolth-drow-core-sheet-v1.png').convert('RGBA')
base=base.crop((0,0,408,428)).resize((119,125),Image.Resampling.NEAREST)
board.paste(base,(100,150),base)
draw.text((40,25),'MARKS 1-2 - EXISTING DROW',fill='#e8d8f6')
for slot,mark in enumerate([3,5,7]):
    path=ROOT/f'lolth-mark-{mark}-atlas-v1.png'
    atlas=Image.open(path).convert('RGBA')
    manifest=json.loads((ROOT/f'lolth-mark-{mark}-animation-v1.json').read_text())
    cells=[atlas.crop(((i%6)*112,(i//6)*112,(i%6+1)*112,(i//6+1)*112)) for i in range(36)]
    colors={p[:3] for p in atlas.getdata() if p[3]}
    assert len(colors)<=12 and atlas.size==(672,672)
    bounds=[c.getchannel('A').getbbox() for c in cells]
    assert all(b and b[0]>=2 and b[1]>=2 and b[2]<=110 and b[3]<=110 for b in bounds)
    unique=len({hashlib.sha256(c.tobytes()).hexdigest() for c in cells})
    assert unique==36, (mark,unique)
    animation=[]; durations=[]
    for clip,(start,count,fps,loop) in manifest['clips'].items():
        for i in range(start,start+count):
            canvas=Image.new('RGB',(640,320),'#1e1b2c')
            d=ImageDraw.Draw(canvas)
            d.text((16,16),f'MARK {mark} - {NAMES[mark]} / {clip.upper()}',fill='#e8d8f6')
            sprite=cells[i].crop((0,35,112,106)).resize((336,213),Image.Resampling.NEAREST)
            canvas.paste(sprite,(0,80),sprite)
            mirrored=sprite.transpose(Image.Transpose.FLIP_LEFT_RIGHT)
            canvas.paste(mirrored,(304,80),mirrored)
            animation.append(canvas)
            durations.append(max(70,round(1000/fps)))
        durations[-1]+=350
    animation[0].save(ROOT/f'lolth-mark-{mark}-animations-v1.gif',save_all=True,append_images=animation[1:],duration=durations,loop=0,disposal=2)
    sprite=cells[0].crop((0,35,112,106)).resize((336,213),Image.Resampling.NEAREST)
    board.paste(sprite,((slot+1)*320-8,80),sprite)
    draw.text(((slot+1)*320+30,25),f'MARK {mark} - {NAMES[mark]}',fill='#e8d8f6')
    report[str(mark)]={'atlas_size':atlas.size,'palette':len(colors),'unique_frames':unique,'cell_bounds':bounds,'sha256':hashlib.sha256(path.read_bytes()).hexdigest(),'clips':manifest['clips']}
board.save(ROOT/'three-transformations-comparison-v1.png')
(ROOT/'asset-validation.json').write_text(json.dumps(report,indent=2),encoding='utf8')
print('ASSET_VALIDATION_PASS: 3 atlases, 108 unique frames, 12 colors max, transparent 2px gutters, GIFs for both facings')
