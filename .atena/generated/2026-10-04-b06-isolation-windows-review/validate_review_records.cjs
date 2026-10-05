// Snapshot-specific local review verification. The official combat failure is preserved.
const fs = require('node:fs');
const path = require('node:path');
const assert = require('node:assert/strict');
const crypto = require('node:crypto');
const {execFileSync} = require('node:child_process');
const dir = '.atena/generated/2026-10-04-b06-isolation-windows-review';
const receipt = '.atena/evidence/2026-10-04-b06-isolation-windows-review.md';
const base = '7e477ba799ce5b4bf9cb6e9dde44e83c97db0bbc';
const previous = '7c781ab65d75251af20880cf6e9548d1239be0dd';
const head = '9640881e2c56b010fb1be93b3818f22be91d3b9c';
const scratch = 'C:/Users/gui-m/AppData/Local/Temp/atena-b06-isolation-windows-414395a9dc6e44f3b4d602d3d4f41608';
const rel = '.atena/generated/2026-10-04-b06-validation';
const text = file => fs.readFileSync(file,'utf8').replace(/^\uFEFF/,'').replace(/\r\n/g,'\n');
const git = (...args) => execFileSync('git',args,{encoding:'utf8'}).replace(/\r\n/g,'\n');
const result = name => JSON.parse(text(path.join(dir,name+'-result.json')));
const log = name => text(path.join(dir,name+'.log'));
assert.equal(git('rev-parse','HEAD').trim(),base);
assert.equal(git('rev-parse','origin/codex/b06-stonehook-foot-expedition').trim(),head);
assert.equal(git('diff','--name-only').trim(),'','Tracked main changed');
assert.equal(git('diff','--name-only','--cached').trim(),'','Unexpected staging');
assert.equal(git('-C',scratch,'rev-parse','HEAD').trim(),head);
const protectedPaths = ['main.gd','wagon_inventory_ui.gd','assets','project.godot','main.tscn','.atena/vault','.atena/generated/2026-10-04-b05-combat-validation','.atena/generated/2026-10-04-b05-local-controls-validation'];
assert.equal(git('diff','--name-only',previous,head,'--',...protectedPaths).trim(),'','Isolation follow-up changed production or historical validators');
const sourceNames = ['run_validation.cjs','validate_b06_runtime.gd','menus_regression.gd','validate_records.cjs'];
assert.equal(git('-C',scratch,'diff','--name-only','HEAD','--','main.gd','wagon_inventory_ui.gd',...sourceNames.map(n=>rel+'/'+n)).trim(),'','Reviewed sources changed');
for (const name of sourceNames) assert.equal(text(path.join(dir,'reviewed-sources',name)),git('show',head+':'+rel+'/'+name),'Source identity mismatch '+name);
const positives = ['b06-headless','b06-runtime','self-test','combat','menus','geometry','facing-headless','facing-normal','normal-smoke','headless-smoke'];
const negatives = ['bypass_departure','border_respawn','remote_wagon','paused_offscreen','lost_route_restore','lost_f4_fields','progression_unlock','new_run_keeps_route'].map(f=>'negative-'+f).concat(['leaked_camera_transform','unshifted_reflection','no_foreground_readability'].map(f=>'render-negative-'+f),['isolation-negative-late_isolation']);
for (const name of [...positives,...negatives]) {
  const r = result(name);
  assert.equal(r.name,name); assert.equal(r.platform.os,'win32');
  assert(r.platform.godot.startsWith('4.7.2'));
  assert.equal(r.project_diagnostics.length,0); assert.equal(r.error,null); assert.equal(r.signal,null);
  if (negatives.includes(name)) {
    assert.equal(r.passed,true); assert.equal(r.exit_code,1); assert(r.detections.length>0);
  } else {
    assert.equal(r.passed,name!=='combat'); assert.equal(r.exit_code,name==='combat'?1:0);
  }
}
assert(log('b06-headless').includes('B06_PASS: 30/30 checks'));
assert(log('b06-runtime').includes('B06_RUNTIME_PASS: 53/53 checks'));
assert(log('menus').includes('LOCAL_CONTROLS_PASS: 33/33 checks'));
assert(log('menus').includes('MENU_ISOLATION PASS: removed 7 joypad motion bindings'));
for (const marker of ['controller opens inventory away from camp','controller opens Wagon near camp','controller left face attacks','controller top face collects without attacking']) assert(log('menus').includes('LOCAL PASS '+marker));
assert(log('geometry').includes('GEOMETRY_PASS: 46/46 checks'));
assert(log('facing-headless').includes('FACING_PASS: 65/65 checks'));
assert(log('facing-normal').includes('FACING_PASS: 102/102 checks'));
assert.equal((log('combat').match(/^RUNTIME PASS /gm)||[]).length,8);
const combatFails = log('combat').split('\n').filter(l=>l.startsWith('RUNTIME FAIL '));
assert.equal(combatFails.length,1); assert(combatFails[0].includes('misses the stag (2 -> 2) with a distinct swing'));
const miss = log('combat').split('\n').find(l=>l.startsWith('MISS '));
assert(miss.includes('enemy_hp=2') && miss.includes('pose=strike') && miss.includes('vfx=swing') && miss.includes('msg=Lolth needs a moment before dodging again.'));
for (const marker of ['SELF_TEST_B01_PASS','SELF_TEST_B02_PASS','SELF_TEST_B03_PASS','SELF_TEST_B04_PASS','SELF_TEST_B05_PASS','SELF_TEST_B06_PASS','SELF_TEST_PLAYTESTER_PASS','SELF_TEST_PASS:']) assert(log('self-test').includes(marker));
const metrics = JSON.parse(text(path.join(dir,'runtime-metrics.json')));
for (const name of ['parity_day_differing_pixels','parity_night_differing_pixels','parity_secured_differing_pixels','translation_left_differing_pixels','translation_right_differing_pixels']) assert.equal(metrics[name],0);
assert.deepEqual(metrics.isolation_control,{dashed:true,queued:true});
assert.deepEqual(metrics.isolation_boundary,{dashed:false,queued:false});
assert.equal(metrics.restored_trigger_021_dashes,true);
assert.equal(new Set(metrics.hud_title_glyph_pixels).size,1); assert.equal(metrics.hud_title_glyph_pixels.length,10);
const views = Object.entries(metrics.foreground_readability);
assert.equal(views.length,8);
for (const [name,r] of views) {
  assert(r.visibility_ratio>=0.5);
  const bytes = fs.readFileSync(path.join(dir,'captures','readability-'+name+'.png'));
  assert.equal(bytes.readUInt32BE(16),1280); assert.equal(bytes.readUInt32BE(20),720);
}
assert.equal(log('render-negative-no_foreground_readability').split('\n').filter(l=>l.startsWith('B06RT FAIL Lolth')).length,8);
assert(log('isolation-negative-late_isolation').includes('B06RT FAIL controller isolation starts before the first journey frame'));
const diagnostic = JSON.parse(text(path.join(dir,'diagnostics','diagnostic-result.json')));
assert.equal(diagnostic.kind,'review-diagnostic-not-official-acceptance'); assert.equal(diagnostic.exit_code,0); assert.equal(diagnostic.passed,true); assert.equal(diagnostic.checks,9); assert.equal(diagnostic.error,null);
const diagnosticLog = text(path.join(dir,'diagnostics','diagnostic.log'));
assert.equal((diagnosticLog.match(/^RUNTIME PASS /gm)||[]).length,9);
assert(!/RUNTIME FAIL|SCRIPT ERROR|ERROR:/.test(diagnosticLog));
assert(diagnosticLog.includes('COMBAT_MOTION_ISOLATION_DIAGNOSTIC removed=7'));
const trigger = diagnosticLog.match(/device=0 right_trigger=([0-9.]+)/);
assert(trigger && Number(trigger[1])>0.2);
assert(diagnosticLog.includes('msg=Out of reach'));
const body = text(receipt);
for (const fact of [head,'53/53','33/33','8/9','9/9','human_acceptance: pending','new_push_approved: false','pull_request_approved: false','merge_approved: false']) assert(body.includes(fact),'Missing receipt fact '+fact);
for (const entry of ['add.yaml','state/plan.yaml','vault/canon','vault/drafts','vault/research','specs','evidence','generated']) assert(fs.existsSync('.atena/'+entry));
function walk(folder,visit) {
  for (const e of fs.readdirSync(folder,{withFileTypes:true})) {
    const file=path.join(folder,e.name); if(e.isDirectory())walk(file,visit); else visit(file);
  }
}
const ids=new Set(); walk('.atena',file=>{if(file.endsWith('.md'))ids.add(path.basename(file,'.md'));});
let links=0; for(const m of body.matchAll(/\[\[([^\]]+)\]\]/g)){assert(ids.has(m[1]));links++;}
const files=[]; walk(dir,file=>{if(path.basename(file)!=='review-manifest.json')files.push(file);}); files.push(receipt);
const hashes=files.sort().map(file=>({path:file.replace(/\\/g,'/'),bytes:fs.statSync(file).size,sha256:crypto.createHash('sha256').update(fs.readFileSync(file)).digest('hex')}));
fs.writeFileSync(path.join(dir,'review-manifest.json'),JSON.stringify({kind:'local-review-receipt-not-all-suite-acceptance',reviewed_commit:head,original_main:base,official_runner_exit:1,official_positive_cases_passing:9,official_positive_cases_failing:1,official_combat:'8/9; preserved',fault_controls_rejected:12,combat_diagnostic:'9/9; separate motion-isolated run',observed_physical_trigger:Number(trigger[1]),human_acceptance:'pending',links,hashes},null,2)+'\n');
console.log('B06_ISOLATION_WINDOWS_REVIEW_RECEIPTS_PASS: 22 official results, combat failure retained, 12 rejected controls, separate 9/9 diagnostic, exact sources, '+links+' resolved links and '+hashes.length+' file hashes; tracked main unchanged.');
