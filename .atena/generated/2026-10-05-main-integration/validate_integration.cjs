const fs=require('node:fs'),path=require('node:path'),crypto=require('node:crypto'),cp=require('node:child_process'),assert=require('node:assert/strict');
const root=path.resolve(__dirname,'../../..');
const read=p=>fs.readFileSync(path.join(root,p),'utf8');
const baseline=JSON.parse(read('.atena/generated/2026-10-05-main-integration/baseline.json'));
const sha=p=>crypto.createHash('sha256').update(fs.readFileSync(p)).digest('hex');
const local=p=>path.join(root,p.slice(p.indexOf('.atena/')));
let hashes=0;
function artCheck(items){
  assert.equal(items.length,30);
  for(const item of items){
    assert.equal(item.owner_accepted,true);assert.equal(item.runtime_admitted,false);
    for(const [field,hash] of [['source','raw_sha256'],['master','master_sha256'],['review','review_sha256']]){
      assert.equal(sha(local(item[field])),item[hash],item.id+' '+field);hashes++;
    }
  }
}
artCheck(baseline.art.items);
for(const item of baseline.forms)assert.equal(sha(path.join(root,item.path)),item.sha256);
assert.equal(sha(path.join(root,'wagon_inventory_ui.gd')),baseline.production.find(x=>x.path==='wagon_inventory_ui.gd').sha256);
assert.equal(sha(path.join(root,'lolth_transformations.gd')),baseline.production.find(x=>x.path==='lolth_transformations.gd').sha256);
const current=read('.atena/state/plan.yaml'), norm=t=>t.replace(/^\uFEFF/,'').replace(/\r\n/g,'\n').replace(/\r/g,'\n').trimEnd();
assert.equal(current.charCodeAt(0),0xfeff,'state BOM');
// Preserve all pre-integration plan history and unrelated operational fields.
const removeIntegration=t=>norm(t).replace(/^active_plan:\n[\s\S]*?^plan_cursor:.*$/m,'active_plan: null\nplan_cursor: complete').replace(/\nrepository_integration:\n[\s\S]*$/,'').trimEnd();
assert.equal(removeIntegration(current),norm(baseline.state),'prior local state retained');
assert(/active_plan: null/.test(current),'integration closed');
assert(/plan_cursor: complete/.test(current));
assert(current.includes('b09_runtime_admission_approved: false'));
const production=read('main.gd');
const strings=production.match(/"(?:[^"\\\r\n]|\\.)*"/g)||[];
assert(!strings.some(s=>/\b(?:Lolth|LOLTH|Shar|SHAR)\b/.test(s)),'approved current display names');
for(const target of ['CLIFF_HARRIER_ID','SCREE_CRAWLER_ID','LOLTH_TRANSFORMATIONS','apply_cliff_harrier_state','apply_scree_crawler_state','begin_lolth_transformation'])assert(production.includes(target));
assert(!production.includes('package-masters-v2')&&!production.includes('b09-opening-art-production'),'offline art not admitted');
const paths=cp.execFileSync('git',['ls-files','-z'],{cwd:root,encoding:'utf8'}).split('\0').filter(Boolean);
assert(!paths.some(p=>/\/(?:checkout|godot-profile|\.git|\.godot|scratch)\//.test(p)),'no nested replicas staged');
const ids=new Set(paths.filter(p=>p.endsWith('.md')).map(p=>path.basename(p,'.md')));
const docs=['.atena/specs/2026-10-05-main-integration.md','.atena/evidence/2026-10-05-main-integration.md','.atena/specs/2026-10-05-b08-stonehook-cliff-harrier.md','.atena/evidence/2026-10-05-b08-stonehook-cliff-harrier.md','.atena/evidence/2026-10-05-b08-stonehook-cliff-harrier-implementation.md','.atena/generated/opus-handoff/2026-10-05-b08-stonehook-cliff-harrier-instruction.md'];
let links=0;for(const file of docs){const text=read(file);assert(!/^(<<<<<<<|=======|>>>>>>>)/m.test(text));for(const m of text.matchAll(/\[\[([^\]#|]+)(?:[^\]]*)\]\]/g)){assert(ids.has(m[1]),file+' '+m[1]);links++;}}
for(const entry of ['add.yaml','vault/canon','vault/drafts','vault/research','specs','evidence','generated','state/plan.yaml'])assert(fs.existsSync(path.join(root,'.atena',entry)));
const tests=path.join(__dirname,'combined-results');
const records=fs.readdirSync(tests).filter(p=>p.endsWith('-result.json')).map(p=>JSON.parse(fs.readFileSync(path.join(tests,p),'utf8')));
assert.equal(records.length,26);
assert(records.every(r=>(r.passed||r.name==='b06-runtime')&&r.project_diagnostics.length===0),'combined regression results');
const rawParity=records.find(r=>r.name==='b06-runtime');
const adjustedParity=JSON.parse(fs.readFileSync(path.join(__dirname,'b06-current-names-result.json'),'utf8'));
assert(adjustedParity.passed&&adjustedParity.markers.includes('B06_RUNTIME_PASS: 53/53 checks'),'all unchanged B-06 assertions after approved names');
if(!rawParity.passed){
  const log=fs.readFileSync(path.join(tests,'b06-runtime.log'),'utf8');
  const failures=log.split(/\r?\n/).filter(line=>line.startsWith('B06RT FAIL '));
  assert.equal(failures.length,3);assert(failures.every(line=>/cave view at zero offset.*292 differing pixels/.test(line)),'only the known name-label differences');
}
for(const name of ['import','forms'])assert(JSON.parse(fs.readFileSync(path.join(__dirname,name+'-result.json'),'utf8')).passed);
const forms=JSON.parse(fs.readFileSync(path.join(__dirname,'forms-validation.json'),'utf8'));assert.equal(forms.passed,196);assert.equal(forms.failed.length,0);
const negative=[];
for(const [name,mutate] of [['tampered-master-hash',items=>items[0].master_sha256='0'.repeat(64)],['unaccepted-target',items=>items[0].owner_accepted=false],['runtime-admission',items=>items[0].runtime_admitted=true]]){
  const items=structuredClone(baseline.art.items);mutate(items);let rejected=false;try{artCheck(items);}catch{rejected=true;}assert(rejected);negative.push(name);
}
const report={status:'PASS',art_targets:30,accepted_art_hashes:90,forms:196,engine_cases:26,faulty_controls:11,b06_original_parity:'Preserved 50/53 result from the approved name change only',b06_current_names:53,links,previous_state_preserved:true,negative_controls:negative,yaml_validation:'Scoped exact state preservation, not a whole-file YAML parser',runtime_art_admission:false};
fs.writeFileSync(path.join(__dirname,'integration-validation.json'),JSON.stringify(report,null,2)+'\n');
console.log(JSON.stringify(report));
