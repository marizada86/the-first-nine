// Snapshot-specific verification of the fresh official Windows review receipts.
const fs = require('node:fs');
const path = require('node:path');
const assert = require('node:assert/strict');
const crypto = require('node:crypto');
const {execFileSync} = require('node:child_process');
const dir = '.atena/generated/2026-10-05-b06-combat-isolation-windows-review';
const receipt = '.atena/evidence/2026-10-05-b06-combat-isolation-windows-review.md';
const rel = '.atena/generated/2026-10-04-b06-validation';
const base = '7e477ba799ce5b4bf9cb6e9dde44e83c97db0bbc';
const previous = '9640881e2c56b010fb1be93b3818f22be91d3b9c';
const head = '7de6d6658a2e8b7aea5954320ef29902094d7215';
const scratch = 'C:/Users/gui-m/AppData/Local/Temp/atena-b06-combat-windows-1791183529100';
const text = f => {const b=fs.readFileSync(f);return b.toString(b[0]===255&&b[1]===254?'utf16le':'utf8').replace(/^\uFEFF/,'').replace(/\r\n/g,'\n');};
const git = (...args) => execFileSync('git',args,{encoding:'utf8'}).replace(/\r\n/g,'\n').trimEnd();
const log = n => text(path.join(dir,n+'.log'));
const result = n => JSON.parse(text(path.join(dir,n+'-result.json')));
assert.equal(git('rev-parse','HEAD'),base);
assert.equal(git('rev-parse','origin/codex/b06-stonehook-foot-expedition'),head);
assert.equal(git('diff','--name-only'),'','Tracked main changed');
assert.equal(git('diff','--name-only','--cached'),'','Unexpected staging');
assert.equal(git('-C',scratch,'rev-parse','HEAD'),head);
assert.equal(git('show','-s','--format=%P',head),previous);
const protectedPaths=['main.gd','wagon_inventory_ui.gd','assets','project.godot','main.tscn','.atena/vault','.atena/generated/2026-10-04-b05-combat-validation','.atena/generated/2026-10-04-b05-local-controls-validation'];
assert.equal(git('diff','--name-only',previous,head,'--',...protectedPaths),'','Production or historical validators changed');
const sources=['combat_regression.gd','menus_regression.gd','validate_b06_runtime.gd','run_validation.cjs','validate_records.cjs'];
assert.equal(git('-C',scratch,'diff','--name-only','HEAD','--','main.gd','wagon_inventory_ui.gd',...sources.map(n=>rel+'/'+n)),'','Execution sources changed');
for(const n of sources) assert.equal(text(path.join(dir,'reviewed-sources',n)).trimEnd(),git('show',head+':'+rel+'/'+n),'Source identity '+n);
const positive=['b06-headless','b06-runtime','self-test','combat','combat-noise','menus','geometry','facing-headless','facing-normal','normal-smoke','headless-smoke'];
const negative=['bypass_departure','border_respawn','remote_wagon','paused_offscreen','lost_route_restore','lost_f4_fields','progression_unlock','new_run_keeps_route'].map(n=>'negative-'+n).concat(['leaked_camera_transform','unshifted_reflection','no_foreground_readability'].map(n=>'render-negative-'+n),['combat-negative-missing_isolation','combat-negative-late_isolation','isolation-negative-late_isolation']);
for(const n of [...positive,...negative]) {
  const r=result(n); assert.equal(r.name,n); assert.equal(r.platform.os,'win32'); assert(r.platform.godot.startsWith('4.7.2')); assert.equal(r.platform.display,'native');
  assert.equal(r.passed,true,n); assert.equal(r.exit_code,negative.includes(n)?1:0,n); assert.equal(r.project_diagnostics.length,0,n); assert.equal(r.error,null); assert.equal(r.signal,null);
  if(negative.includes(n)) assert(r.detections.length>0,n);
}
for(const [n,m] of Object.entries({'b06-headless':'B06_PASS: 30/30 checks','b06-runtime':'B06_RUNTIME_PASS: 53/53 checks','menus':'LOCAL_CONTROLS_PASS: 33/33 checks','geometry':'GEOMETRY_PASS: 46/46 checks','facing-headless':'FACING_PASS: 65/65 checks','facing-normal':'FACING_PASS: 102/102 checks'})) assert(log(n).includes(m),m);
for(const n of ['combat','combat-noise']) {
  assert.equal((log(n).match(/^RUNTIME PASS /gm)||[]).length,9);
  assert(!/^RUNTIME FAIL /m.test(log(n)));
  assert(/^COMBAT_ISOLATION PASS: removed 7 .*before gameplay=true \(game pulse 0\.000, state opening/m.test(log(n)));
  assert(log(n).includes('before=true after=false; button bindings kept=true'));
  assert(log(n).includes('B05_RUNTIME_PASS: 0 failures'));
  assert(log(n).includes('pose=strike hurt_overlay=false vfx=swing msg=Out of reach'));
}
assert(/^RUNTIME FAIL .*misses the stag/m.test(log('combat-negative-missing_isolation')));
assert(/^COMBAT_ISOLATION FAIL: .*before gameplay=false/m.test(log('combat-negative-late_isolation')));
assert(log('isolation-negative-late_isolation').includes('B06RT FAIL controller isolation starts before the first journey frame'));
assert.equal((log('render-negative-no_foreground_readability').match(/^B06RT FAIL Lolth/gm)||[]).length,8);
for(const m of ['SELF_TEST_B01_PASS','SELF_TEST_B02_PASS','SELF_TEST_B03_PASS','SELF_TEST_B04_PASS','SELF_TEST_B05_PASS','SELF_TEST_B06_PASS','SELF_TEST_PLAYTESTER_PASS','SELF_TEST_PASS:']) assert(log('self-test').includes(m));
const metrics=JSON.parse(text(path.join(dir,'runtime-metrics.json')));
for(const n of ['parity_day_differing_pixels','parity_night_differing_pixels','parity_secured_differing_pixels','translation_left_differing_pixels','translation_right_differing_pixels']) assert.equal(metrics[n],0);
assert.deepEqual(metrics.isolation_control,{dashed:true,queued:true}); assert.deepEqual(metrics.isolation_boundary,{dashed:false,queued:false}); assert.equal(metrics.restored_trigger_021_dashes,true);
assert.equal(metrics.hud_title_glyph_pixels.length,10); assert.equal(new Set(metrics.hud_title_glyph_pixels).size,1);
assert.equal(Object.keys(metrics.foreground_readability).length,8);
for(const [n,r] of Object.entries(metrics.foreground_readability)) {assert(r.visibility_ratio>=0.5); const b=fs.readFileSync(path.join(dir,'captures','readability-'+n+'.png')); assert.equal(b.readUInt32BE(16),1280); assert.equal(b.readUInt32BE(20),720);}
assert(log('records-validation').includes('B06_IMPLEMENTATION_RECORDS_PASS: 39 resolved links'));
assert(log('records-validation').includes('B06_SAVED_RESULTS_PASS:'));
const body=text(receipt); for(const f of [head,'53/53','9/9','14','human_acceptance: accepted','human_acceptance_date: 2026-10-05','owner replied `aprovado`','new_push_approved: false','pull_request_approved: false','merge_approved: false']) assert(body.includes(f),'Receipt fact '+f);
function walk(folder,visit){for(const e of fs.readdirSync(folder,{withFileTypes:true})){const f=path.join(folder,e.name);e.isDirectory()?walk(f,visit):visit(f);}}
const ids=new Set();walk('.atena',f=>{if(f.endsWith('.md'))ids.add(path.basename(f,'.md'));});
let links=0;for(const m of body.matchAll(/\[\[([^\]]+)\]\]/g)){assert(ids.has(m[1]),m[1]);links++;}
for(const n of ['add.yaml','state/plan.yaml','vault/canon','vault/drafts','vault/research','specs','evidence','generated']) assert(fs.existsSync('.atena/'+n));
const files=[];walk(dir,f=>{if(path.basename(f)!=='review-manifest.json')files.push(f);});files.push(receipt);
const hashes=files.sort().map(f=>({path:f.replace(/\\/g,'/'),bytes:fs.statSync(f).size,sha256:crypto.createHash('sha256').update(fs.readFileSync(f)).digest('hex')}));
fs.writeFileSync(path.join(dir,'review-manifest.json'),JSON.stringify({kind:'local-official-windows-review-receipt',reviewed_commit:head,original_main:base,official_runner_exit:0,positive_cases:11,fault_controls_rejected:14,combat:'9/9',combat_noise:'9/9',human_acceptance:'accepted',human_acceptance_date:'2026-10-05',human_acceptance_source:'Owner replied aprovado; overall acceptance only, no additional engine runs or publication authority.',links,hashes},null,2)+'\n');
console.log('B06_COMBAT_WINDOWS_REVIEW_RECEIPTS_PASS: 25 fresh official results, combat 9/9 with and without noise, 14 rejected controls, exact sources, '+links+' resolved links and '+hashes.length+' hashes; tracked main unchanged.');
