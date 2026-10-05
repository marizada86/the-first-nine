const fs=require('fs'),path=require('path'),crypto=require('crypto'),zlib=require('zlib');
const root=path.resolve(__dirname,'../../..');
const read=p=>JSON.parse(fs.readFileSync(path.resolve(root,p),'utf8'));
const sha=p=>crypto.createHash('sha256').update(fs.readFileSync(p)).digest('hex');
function check(v,label){if(!v)throw Error(label);}
function png(p,decode=false){
 const b=fs.readFileSync(p);check(b.subarray(0,8).equals(Buffer.from([137,80,78,71,13,10,26,10])),'png-signature');
 const w=b.readUInt32BE(16),h=b.readUInt32BE(20),result={dimensions:[w,h]};
 if(!decode)return result;
 check(b[24]===8&&b[25]===6&&b[28]===0,'png-rgba8');
 let chunks=[],at=8;while(at<b.length){const n=b.readUInt32BE(at),kind=b.toString('ascii',at+4,at+8);if(kind==='IDAT')chunks.push(b.subarray(at+8,at+8+n));at+=n+12;}
 const raw=zlib.inflateSync(Buffer.concat(chunks)),stride=w*4,out=Buffer.alloc(stride*h);
 const paeth=(a,b,c)=>{const p=a+b-c,pa=Math.abs(p-a),pb=Math.abs(p-b),pc=Math.abs(p-c);return pa<=pb&&pa<=pc?a:pb<=pc?b:c;};
 for(let y=0;y<h;y++){const filter=raw[y*(stride+1)];for(let x=0;x<stride;x++){
  const a=x>=4?out[y*stride+x-4]:0,b=y?out[(y-1)*stride+x]:0,c=y&&x>=4?out[(y-1)*stride+x-4]:0;
  const predictor=[0,a,b,Math.floor((a+b)/2),paeth(a,b,c)][filter];check(predictor!==undefined,'png-filter');out[y*stride+x]=(raw[y*(stride+1)+1+x]+predictor)&255;
 }}
 let zero=0,full=0,semi=0,x0=w,y0=h,x1=-1,y1=-1;const colors=new Set();
 for(let y=0;y<h;y++)for(let x=0;x<w;x++){const i=(y*w+x)*4,a=out[i+3];if(a===0)zero++;else if(a===255)full++;else semi++;
  if(a>=128){x0=Math.min(x0,x);y0=Math.min(y0,y);x1=Math.max(x1,x);y1=Math.max(y1,y);colors.add(out.readUInt32BE(i));}
 }
 return {...result,alpha:[zero,full,semi],bounds:[x0,y0,x1,y1],colors:colors.size};
}
const same=(a,b)=>JSON.stringify(a)===JSON.stringify(b);
const report=read('.atena/generated/2026-10-05-b09-opening-art-production/package-technical-v2.json');
const results=read('.atena/generated/2026-10-05-b09-opening-art-production/results.json');
const selection=read('.atena/generated/2026-10-05-b09-opening-art-production/package-selection-v2.json');
const captions=read('.atena/generated/2026-10-05-b09-opening-art-production/panel-text.en.json');
const ending=read('.atena/generated/2026-10-05-b09-opening-art-production/ending-technical-v1.json');
function patient(e){
 check(same(e.master_dimensions,[64,64]),'patient-cell');
 check(e.landmarks?.length===5&&e.normalized_landmarks?.length===5,'measurable-landmarks');
 let length=0;for(let i=1;i<5;i++)length+=Math.hypot(e.normalized_landmarks[i][0]-e.normalized_landmarks[i-1][0],e.normalized_landmarks[i][1]-e.normalized_landmarks[i-1][1]);
 check(Math.abs(length-e.raster_landmark_length)<1e-8,'measured-length-receipt');
 check(Math.abs(e.body_ratio-length/40)<1e-8&&e.body_ratio>=.95&&e.body_ratio<=1.05,'body-ratio');
 check(same(e.ground_pivot,[32,56])&&e.normalized_bounds[3]===56,'ground-pivot');
 check(e.normalized_bounds[0]>=2&&e.normalized_bounds[1]>=2&&e.normalized_bounds[2]<=61,'safe-gutters');
 check(e.normalized_alpha_counts[0]>0&&e.normalized_alpha_counts[1]>0&&e.normalized_alpha_counts[2]===0,'binary-alpha');
 check(e.palette_colors<=16,'short-palette');
 check(e.measurement_method&&e.measurement_uncertainty,'measurement-provenance');
}
check(results.attempts.length===44&&report.generation_attempts===44,'attempt-count');
const counts=new Map();const attemptReceipt=[];
for(const a of results.attempts){
 counts.set(a.id,(counts.get(a.id)||0)+1);
 check(counts.get(a.id)<=3,'attempt-budget');
 const p=path.resolve(root,a.target);check(fs.existsSync(p)&&sha(p)===sha(a.source),'provider-original-preserved');
 check(a.provider==='built-in-imagegen'&&a.ai_disclosure_required&&a.runtime_admitted===false,'provider-boundary');
 attemptReceipt.push({id:a.id,attempt:a.attempt,status:a.status,target:a.target,dimensions:png(p).dimensions,sha256:sha(p),provider_original_sha256:sha(a.source)});
}
check(counts.size===30&&report.items.length===30&&selection.items.length===30,'target-count');
check(new Set(report.items.map(x=>x.id)).size===30,'distinct-targets');
check(captions.language==='en'&&captions.panels.length===20,'english-panel-count');
check(new Set(captions.panels.map(x=>x.id)).size===20,'distinct-panel-text');
let patients=0,comics=0,environments=0;
for(const e of report.items){
 const s=selection.items.find(x=>x.id===e.id);check(s&&s.source===e.source&&s.attempt===e.attempt,'selection-consistency');
 const a=results.attempts.find(x=>x.id===e.id&&x.attempt===e.attempt);check(a&&!/^rejected|^superseded/.test(a.status),'selected-attempt');
 for(const key of ['master','review']){check(sha(e[key])===e[key+'_sha256'],'output-hash');check(same(png(e[key]).dimensions,e[key+'_dimensions']),'output-dimensions');}
 check(sha(path.resolve(root,e.source))===e.raw_sha256&&same(png(path.resolve(root,e.source)).dimensions,e.raw_dimensions),'source-receipt');
 check(e.runtime_admitted===false,'no-runtime-admission');
 if(e.kind==='patient'){
  patients++;patient(e);
  const pixels=png(e.master,true),raw=png(path.resolve(root,e.source),true);
  check(same(pixels.alpha,e.normalized_alpha_counts)&&same(pixels.bounds,e.normalized_bounds)&&pixels.colors===e.palette_colors,'independent-patient-pixel-scan');
  check(same(raw.alpha,e.raw_alpha_counts),'raw-alpha-scan');
 }else{
  check(same(e.master_dimensions,[1920,1080])&&same(e.review_dimensions,[1280,720]),'landscape-dimensions');
  const [x,y,w,h]=e.crop;check(w*9===h*16&&x>=0&&y>=0&&x+w<=e.raw_dimensions[0]&&y+h<=e.raw_dimensions[1],'aspect-preserving-crop');
  if(e.kind==='comic'){comics++;check(captions.panels.some(x=>x.id.toLowerCase()===e.id),'caption-link');}else environments++;
 }
 if(e.owner_accepted){check(e.id.startsWith('h03-'),'acceptance-scope');const prior=ending.items.find(x=>x.id===e.id);check(prior&&prior.master_sha256===e.master_sha256,'accepted-ending-preserved');}
}
check(comics===20&&patients===8&&environments===2,'deliverable-allocation');
check(new Set(report.items.map(x=>x.master_sha256)).size===30,'distinct-master-hashes');
const contract=['.atena/add.yaml','.atena/vault/canon','.atena/vault/drafts','.atena/vault/research','.atena/specs','.atena/evidence','.atena/generated','.atena/state/plan.yaml'];
for(const p of contract)check(fs.existsSync(path.resolve(root,p)),'add-contract');
const recordPaths=['.atena/specs/2026-10-05-b09-opening-art-production.md','.atena/evidence/2026-10-05-b09-opening-art-production.md','.atena/specs/2026-10-05-b09-final-shadow-spider-art-revision.md','.atena/evidence/2026-10-05-b09-final-shadow-spider-art-revision.md','.atena/vault/canon/2026-10-05-b09-opening-art-production-approval.md'];
const names=new Set();function index(dir){for(const entry of fs.readdirSync(dir,{withFileTypes:true})){const p=path.join(dir,entry.name);if(entry.isDirectory())index(p);else if(entry.name.endsWith('.md'))names.add(entry.name.slice(0,-3));}}
for(const dir of ['specs','evidence','vault','generated'])index(path.resolve(root,'.atena',dir));
let links=0;for(const file of recordPaths){const text=fs.readFileSync(path.resolve(root,file),'utf8');for(const match of text.matchAll(/\[\[([^\]#|]+)(?:[^\]]*)\]\]/g)){check(names.has(match[1]),'wiki-link');links++;}check(!/^(<<<<<<<|=======|>>>>>>>)/m.test(text),'conflict-marker');}
const state=fs.readFileSync(path.resolve(root,'.atena/state/plan.yaml'),'utf8');
check(state.charCodeAt(0)===0xfeff,'state-bom-preserved');
check(state.includes('id: "2026-10-05-b09-opening-art-production"')||state.includes('id: 2026-10-05-b09-opening-art-production'),'active-plan-id');
const negative=[];
const example=report.items.find(x=>x.kind==='patient');
for(const [name,modify,expected] of [
 ['wrong-body-ratio',e=>e.body_ratio=.6,'body-ratio'],
 ['unsafe-ground-pivot',e=>e.ground_pivot=[32,40],'ground-pivot'],
 ['opaque-background',e=>e.normalized_alpha_counts=[0,4096,0],'binary-alpha'],
 ['missing-landmarks',e=>e.landmarks=null,'measurable-landmarks']
]){
 const altered=structuredClone(example);modify(altered);let rejection=null;try{patient(altered);}catch(e){rejection=e.message;}check(rejection===expected,'negative-control-'+name);negative.push({name,rejected_on:rejection});
}
const output={status:'PASS',generation_attempts:44,distinct_targets:30,comic_panels:20,environments:2,patients:8,source_copies_byte_identical:true,distinct_masters:30,independent_patient_pixel_scans:8,patient_body_ratios:report.items.filter(x=>x.kind==='patient').map(x=>({id:x.id,ratio:x.body_ratio,ground_y:x.normalized_bounds[3],colors:x.palette_colors})),resolved_wiki_links:links,add_contract_paths:8,negative_controls:negative,attempt_receipts:attemptReceipt,runtime_admitted:false,engine_run:false,yaml_parser_validation:false,visual_review:'Manual review recorded separately; no anatomy or story segmentation claimed.',license_verification:'not-independently-verified',ai_disclosure_required:true};
process.stdout.write(JSON.stringify(output));
