// Local review receipt verification. Failure observations are expected and retained.
const fs = require('node:fs');
const path = require('node:path');
const assert = require('node:assert/strict');
const crypto = require('node:crypto');
const {execFileSync} = require('node:child_process');
const project = process.cwd();
const dir = '.atena/generated/2026-10-04-b06-followup-windows-review';
const receipt = '.atena/evidence/2026-10-04-b06-followup-windows-review.md';
const base = '7e477ba799ce5b4bf9cb6e9dde44e83c97db0bbc';
const head = '7c781ab65d75251af20880cf6e9548d1239be0dd';
const scratch = 'C:/Users/gui-m/AppData/Local/Temp/atena-b06-followup-windows-ad732e923be54a078a0479175f04c8e5';
const rel = '.atena/generated/2026-10-04-b06-validation';
const text = file => fs.readFileSync(file,'utf8').replace(/^\uFEFF/,'').replace(/\r\n/g,'\n');
const git = (...args) => execFileSync('git',args,{encoding:'utf8'}).replace(/\r\n/g,'\n');
const result = name => JSON.parse(text(path.join(dir,name+'-result.json')));
const log = name => text(path.join(dir,name+'.log'));
assert.equal(git('rev-parse','HEAD').trim(),base,'Original checkout changed');
assert.equal(git('rev-parse','origin/codex/b06-stonehook-foot-expedition').trim(),head);
assert.equal(git('diff','--name-only').trim(),'','Tracked main edits are not review artifacts');
assert.equal(git('diff','--name-only','--cached').trim(),'','Unexpected staging');
assert.equal(git('-C',scratch,'rev-parse','HEAD').trim(),head);
assert.equal(git('-C',scratch,'diff','--name-only','HEAD','--','main.gd','wagon_inventory_ui.gd',rel+'/validate_b06_runtime.gd',rel+'/run_validation.cjs').trim(),'','Reviewed sources changed');
for (const name of ['run_validation.cjs','validate_b06_runtime.gd']) {
  assert.equal(text(path.join(dir,'diagnostics',name)),git('show',head+':'+rel+'/'+name),'Published source identity lost');
}
const positives = ['b06-headless','b06-runtime','self-test','combat','menus','geometry','facing-headless','facing-normal','normal-smoke','headless-smoke'];
const negatives = ['bypass_departure','border_respawn','remote_wagon','paused_offscreen','lost_route_restore','lost_f4_fields','progression_unlock','new_run_keeps_route'].map(f=>'negative-'+f).concat(['leaked_camera_transform','unshifted_reflection','no_foreground_readability'].map(f=>'render-negative-'+f));
for (const name of [...positives,...negatives]) {
  const r = result(name);
  assert.equal(r.name,name);
  assert.equal(r.platform.os,'win32');
  assert(r.platform.godot.startsWith('4.7.2'));
  assert.equal(r.project_diagnostics.length,0);
  assert.equal(r.error,null);
  assert.equal(r.signal,null);
  if (negatives.includes(name)) {
    assert.equal(r.passed,true); assert.equal(r.exit_code,1); assert(r.detections.length>0);
  } else {
    const failed = ['b06-runtime','menus'].includes(name);
    assert.equal(r.passed,!failed); assert.equal(r.exit_code,failed ? 1 : 0);
  }
}
assert(log('b06-headless').includes('B06_PASS: 30/30 checks'));
assert(log('b06-runtime').includes('B06_RUNTIME_FAIL: 50/51 checks'));
assert.deepEqual(log('b06-runtime').split('\n').filter(l=>l.startsWith('B06RT FAIL ')),['B06RT FAIL controller bindings are suspended for the keyboard-only route section (resting trigger 0.21 ignored)']);
assert(log('menus').includes('LOCAL_CONTROLS_FAIL: 32/33 checks'));
assert.deepEqual(log('menus').split('\n').filter(l=>l.startsWith('LOCAL FAIL ')),['LOCAL FAIL right-click parry remains reserved and inactive']);
assert(log('facing-normal').includes('FACING_PASS: 102/102 checks'));
assert(log('facing-headless').includes('FACING_PASS: 65/65 checks'));
assert(log('geometry').includes('GEOMETRY_PASS: 46/46 checks'));
assert.equal((log('combat').match(/^RUNTIME PASS /gm)||[]).length,9);
for (const marker of ['SELF_TEST_B01_PASS','SELF_TEST_B02_PASS','SELF_TEST_B03_PASS','SELF_TEST_B04_PASS','SELF_TEST_B05_PASS','SELF_TEST_B06_PASS','SELF_TEST_PLAYTESTER_PASS','SELF_TEST_PASS:']) assert(log('self-test').includes(marker));
const metrics = JSON.parse(text(path.join(dir,'runtime-metrics.json')));
for (const name of ['parity_day_differing_pixels','parity_night_differing_pixels','parity_secured_differing_pixels','translation_left_differing_pixels','translation_right_differing_pixels']) assert.equal(metrics[name],0);
assert.equal(new Set(metrics.hud_title_glyph_pixels).size,1);
assert.equal(metrics.hud_title_glyph_pixels.length,10);
const views = Object.entries(metrics.foreground_readability);
assert.equal(views.length,8);
for (const [name,r] of views) {
  assert(r.visibility_ratio>=0.5);
  const bytes = fs.readFileSync(path.join(dir,'captures','readability-'+name+'.png'));
  assert.equal(bytes.readUInt32BE(16),1280); assert.equal(bytes.readUInt32BE(20),720);
}
assert.equal(log('render-negative-no_foreground_readability').split('\n').filter(l=>l.startsWith('B06RT FAIL Lolth')).length,8);
const diagnostic = JSON.parse(text(path.join(dir,'diagnostics','early-isolation-diagnostic-result.json')));
assert.equal(diagnostic.exit_code,0); assert.equal(diagnostic.passed,true);
assert.equal(diagnostic.kind,'diagnostic-not-unmodified-acceptance');
assert(text(path.join(dir,'diagnostics','early-isolation-diagnostic.log')).includes('B06_RUNTIME_PASS: 51/51 checks'));
const menuDiagnostic = text(path.join(dir,'diagnostics','windows-menus-physical-filter.log'));
assert(menuDiagnostic.includes('LOCAL_CONTROLS_PASS: 33/33 checks'));
assert(!/LOCAL FAIL|SCRIPT ERROR|ERROR:/.test(menuDiagnostic));
for (const marker of ['controller opens inventory away from camp','controller opens Wagon near camp','controller left face attacks','controller top face collects without attacking']) assert(menuDiagnostic.includes('LOCAL PASS '+marker));
const probe = text(path.join(dir,'diagnostics','windows-isolation-probe.log'));
assert(probe.includes('trial=late-queued-trigger') && probe.includes('requests=["shadow_action"]') && probe.includes('result early=false dashed=true'));
assert(probe.includes('WINDOWS_ISOLATION_END: 2/3 (diagnostic, not acceptance)'));
assert(!/SCRIPT ERROR|ERROR:/.test(probe));
const body = text(receipt);
for (const fact of [head,'human_acceptance: pending','new_push_approved: false','pull_request_approved: false','merge_approved: false','50/51','32/33','51/51','33/33']) assert(body.includes(fact),'Missing review fact '+fact);
for (const entry of ['add.yaml','state/plan.yaml','vault/canon','vault/drafts','vault/research','specs','evidence','generated']) assert(fs.existsSync('.atena/'+entry));
const ids = new Set();
function walk(folder, visitor) {
  for (const e of fs.readdirSync(folder,{withFileTypes:true})) {
    const file = path.join(folder,e.name);
    if(e.isDirectory()) walk(file,visitor); else visitor(file);
  }
}
walk('.atena',file=>{if(file.endsWith('.md')) ids.add(path.basename(file,'.md'));});
let links=0;
for (const m of body.matchAll(/\[\[([^\]]+)\]\]/g)) { assert(ids.has(m[1])); links++; }
const files=[];
walk(dir,file=>{if(path.basename(file)!=='review-manifest.json')files.push(file);});
files.push(receipt);
const hashes=files.sort().map(file=>({path:file.replace(/\\/g,'/'),bytes:fs.statSync(file).size,sha256:crypto.createHash('sha256').update(fs.readFileSync(file)).digest('hex')}));
fs.writeFileSync(path.join(dir,'review-manifest.json'),JSON.stringify({kind:'local-review-receipt-not-acceptance',reviewed_commit:head,original_main:base,platform:'Windows Godot 4.7.2 NVIDIA GTX 1650',official_runner_exit:1,official_positive_cases_passing:8,official_positive_cases_failing:2,fault_controls_rejected:11,diagnostics:{route:'51/51; earlier isolation; original 51 assertions inherited',menus:'33/33; physical dispatch filtered, synthetic controls preserved'},human_acceptance:'pending',links,hashes},null,2)+'\n');
console.log('B06_FOLLOWUP_WINDOWS_REVIEW_RECEIPTS_PASS: 21 official results, 2 retained failures, 11 rejected controls, separate passing diagnostics, exact source identities, '+links+' resolved review links and '+hashes.length+' file hashes; tracked main unchanged.');
