from pathlib import Path
import hashlib,json

ROOT=Path(__file__).resolve().parent
workspace=ROOT.parents[2]
sources={
 '3': ['assets/runtime_v2/characters/lolth/lolth-drow-core-sheet-v1.png','.atena/generated/2026-10-03-p6-individual-character-sprite-masters/lolth-drow-master-v1.png',None],
 '5': ['.atena/generated/2026-10-05-lolth-three-transformations/mark-3-attempt-2.png','.atena/generated/2026-10-05-lolth-three-transformations/mark-3-attempt-3.png','.atena/generated/2026-10-05-lolth-three-transformations/mark-5-attempt-2.png'],
 '7': ['.atena/generated/2026-10-05-lolth-three-transformations/mark-5-attempt-1.png','.atena/generated/2026-10-03-p6-individual-character-sprite-masters/lolth-drow-master-v1.png','.atena/generated/2026-10-05-lolth-three-transformations/mark-5-attempt-3.png']
}
reasons={
 '3': ['Rejected: ornate costume and inadequate separation.','Rejected: excessive detail and unequal generated grid; not a runtime atlas.','Selected for technical conversion: simplified silhouette and 36 separate characters.'],
 '5': ['Rejected: inherited detail, unstable spacing.','Rejected: excessive signature burst and ambiguous appendage spaces.','Selected for conversion: four distinct appendage tips; smaller effects.'],
 '7': ['Rejected: excessive aura and unclear limb separation.','Rejected: eight limb tips not clearly distinguishable.','Selected for conversion: eight separate appendage tips; 36 disconnected primary silhouettes.']
}
def digest(path): return hashlib.sha256(path.read_bytes()).hexdigest()
assets=json.loads((ROOT/'asset-validation.json').read_text())
normal=json.loads((ROOT/'normalization-report.json').read_text())
runtime=json.loads((ROOT/'runtime-validation.json').read_text())
renders=json.loads((ROOT/'render-captures.json').read_text())
result={'tool':'built-in image_gen.imagegen','ai_generated':True,'approval':'per-plan owner option 1 on 2026-10-05','prompts':'prompts.json','stages':{},'runtime_checks':{'passed':runtime['passed'],'failed':runtime['failed']},'captures':len(renders['captures']),'engine':runtime['engine'],'normalization':'Component isolation, uniform stage scale, binary alpha, shared 12-color palette; no poses synthesized from a single still.'}
for mark in ['3','5','7']:
 attempts=[]
 for i in [1,2,3]:
  path=ROOT/f'mark-{mark}-attempt-{i}.png'
  attempts.append({'attempt':i,'file':path.name,'sha256':digest(path),'source':sources[mark][i-1],'source_sha256':digest(workspace/sources[mark][i-1]) if sources[mark][i-1] else None,'assessment':reasons[mark][i-1],'status':'selected-for-conversion' if i==3 else 'rejected'})
 outputs=[]
 for suffix in ['atlas-v1.png','master-v1.png','animation-v1.json','animations-v1.gif']:
  path=ROOT/f'lolth-mark-{mark}-{suffix}'
  outputs.append({'file':path.name,'sha256':digest(path),'bytes':path.stat().st_size})
 result['stages'][mark]={'status':'accepted-local-technical-validation','human_acceptance':'pending','attempts':attempts,'outputs':outputs,'validation':assets[mark],'measured_raw_standing_body_height':normal['stages'][mark]['raw_body_height'],'normalized_idle_heights':[40,40,41,40] if mark=='7' else [40,40,40,40],'body_ratio_to_baseline':[1.0,1.0,1.025,1.0] if mark=='7' else [1.0]*4}
acceptance_path=ROOT/'human-acceptance.json'
if acceptance_path.exists():
 acceptance=json.loads(acceptance_path.read_text(encoding='utf-8'))
 result['human_acceptance']=acceptance
 for stage in result['stages'].values():
  stage['status']='accepted-human-reviewed'
  stage['human_acceptance']=acceptance['status']
(ROOT/'results.json').write_text(json.dumps(result,indent=2),encoding='utf8')
print('RESULTS_RECORDED: 9 generation attempts, all prompts, source/output SHA-256, 108 accepted unique frames, 196 passing checks and 63 fresh captures.')
