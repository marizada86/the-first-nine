from pathlib import Path
from PIL import Image
import json

ROOT = Path(__file__).resolve().parent
out = {}
for path in sorted(ROOT.glob('mark-*-attempt-*.png')):
    im = Image.open(path).convert('RGBA')
    w, h = im.size
    cells = []
    for i in range(36):
        x, y = i % 6, i // 6
        box = (round(x*w/6), round(y*h/6), round((x+1)*w/6), round((y+1)*h/6))
        cell = im.crop(box)
        a = cell.getchannel('A')
        bounds = a.point(lambda v: 255 if v >= 128 else 0).getbbox()
        touches = []
        if bounds:
            if bounds[0] <= 1: touches.append('left')
            if bounds[1] <= 1: touches.append('top')
            if bounds[2] >= cell.width-1: touches.append('right')
            if bounds[3] >= cell.height-1: touches.append('bottom')
        cells.append({'frame': i, 'bbox': bounds, 'edges': touches})
    out[path.name] = {'size': im.size, 'alpha_extrema': im.getchannel('A').getextrema(), 'cells': cells}
report = ROOT / 'source-audit.json'
report.write_text(json.dumps(out, indent=2), encoding='utf8')
for name, data in out.items():
    print(name, 'size', data['size'], 'alpha', data['alpha_extrema'], 'edge_cells', [(c['frame'], c['edges']) for c in data['cells'] if c['edges']])
base = Image.open(ROOT.parents[2] / 'assets/runtime_v2/characters/lolth/lolth-drow-core-sheet-v1.png').convert('RGBA')
standing = base.crop((0,0,base.width//3,base.height//3))
print('base cell', standing.size, 'visible bounds', standing.getchannel('A').point(lambda v: 255 if v>=128 else 0).getbbox())
