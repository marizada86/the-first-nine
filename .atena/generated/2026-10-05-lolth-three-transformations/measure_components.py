from pathlib import Path
from PIL import Image
import numpy as np
import json

ROOT = Path(__file__).resolve().parent

def components(mask):
    parent, records, prev = [], [], []
    def find(i):
        while parent[i] != i:
            parent[i] = parent[parent[i]]
            i = parent[i]
        return i
    for y, line in enumerate(mask):
        ends = np.flatnonzero(np.diff(np.r_[False, line, False]))
        current = []
        for x0,x1 in zip(ends[::2], ends[1::2]):
            overlaps = [find(i) for a,b,i in prev if a <= x1 and b >= x0]
            if overlaps:
                idx = min(overlaps)
                for other in overlaps: parent[find(other)] = idx
            else:
                idx = len(parent); parent.append(idx)
            current.append((int(x0),int(x1),idx))
            records.append((y,int(x0),int(x1),idx))
        prev = current
    groups = {}
    for y,a,b,i in records:
        idx=find(i)
        g=groups.setdefault(idx, {'area':0,'bbox':[a,y,b,y+1],'runs':[]})
        g['area']+=b-a
        g['bbox']=[min(g['bbox'][0],a),min(g['bbox'][1],y),max(g['bbox'][2],b),max(g['bbox'][3],y+1)]
        g['runs'].append([y,a,b])
    return list(groups.values())

results={}
for mark in [3,5,7]:
    name=f'mark-{mark}-attempt-3.png'
    pixels=np.array(Image.open(ROOT/name).convert('RGBA'))
    groups=components(pixels[:,:,3]>=128)
    large=sorted([g for g in groups if g['area']>1000], key=lambda g:g['bbox'][1])
    print(name, 'large count',len(large), 'areas', sorted(g['area'] for g in large))
    if len(large)!=36:
        print('large bounds', [(g['area'],g['bbox']) for g in large])
    # Rows are grouped by sprite floor/bottom, rather than inaccurate generated grid lines.
    # Expected floor levels are spaced regularly with considerable empty vertical gaps.
    rows=[[] for _ in range(6)]
    for g in large:
        row=min(5,max(0,round((g['bbox'][3]-185)/208)))
        rows[row].append(g)
    print('row counts', [len(r) for r in rows])
    for row in rows: row.sort(key=lambda g:g['bbox'][0])
    if any(len(r)!=6 for r in rows): continue
    frames=[g for row in rows for g in row]
    # Small detached effects are assigned to the nearest sprite centre.
    for g in groups:
        if g['area']<=1000 and g['area']>=4:
            cx=(g['bbox'][0]+g['bbox'][2])/2
            cy=(g['bbox'][1]+g['bbox'][3])/2
            best=min(range(36),key=lambda i: ((frames[i]['bbox'][0]+frames[i]['bbox'][2])/2-cx)**2+((frames[i]['bbox'][1]+frames[i]['bbox'][3])/2-cy)**2)
            frames[best]['runs']+=g['runs']
    results[str(mark)]={'source':name,'frames':frames}
(ROOT/'components.json').write_text(json.dumps(results),encoding='utf8')
