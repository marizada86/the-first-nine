// Scoped receipt validation and generated hash manifest, not new Godot execution.
const fs = require('node:fs');
const path = require('node:path');
const assert = require('node:assert/strict');
const crypto = require('node:crypto');
const {execFileSync} = require('node:child_process');
const dir = __dirname;
const root = path.resolve(dir, '../../..');
const git = (...args) => execFileSync('git', args, {cwd: root, encoding:'utf8'}).trim();
const baseline = '7e477ba799ce5b4bf9cb6e9dde44e83c97db0bbc';
const head = 'ccc4fcf69271d88e421e26a81841cf6cce834a37';
assert.equal(git('rev-parse', 'HEAD'), baseline, 'Original main must be unchanged');
assert.equal(git('rev-parse', 'origin/codex/b06-stonehook-foot-expedition'), head);
assert.equal(git('diff', '--name-only', baseline, '--'), '', 'Tracked production/records changed');
const result = name => JSON.parse(fs.readFileSync(path.join(dir, name+'-result.json'), 'utf8'));
const log = name => fs.readFileSync(path.join(dir, name+'.log'), 'utf8');
const positive = ['b06-headless','self-test','combat','menus','geometry','facing-headless','facing-normal','normal-smoke','headless-smoke'];
for (const name of positive) {
  const r = result(name);
  assert(r.passed && r.exit_code === 0 && r.project_diagnostics.length === 0, name);
}
const raw = result('b06-runtime');
assert(!raw.passed && raw.exit_code === 1 && raw.project_diagnostics.length === 0);
assert(log('b06-runtime').includes('B06_RUNTIME_FAIL: 36/40 checks'));
assert.equal((log('b06-runtime').match(/^B06RT FAIL /gm)||[]).length, 4);
assert(log('facing-normal').includes('FACING_PASS: 102/102 checks'));
const faults = ['bypass_departure','border_respawn','remote_wagon','paused_offscreen','lost_route_restore','lost_f4_fields','progression_unlock','new_run_keeps_route'].map(f=>'negative-'+f).concat(['render-negative-leaked_camera_transform','render-negative-unshifted_reflection']);
for (const name of faults) {
  const r = result(name);
  assert(r.passed && r.exit_code === 1 && r.detections.length > 0 && r.project_diagnostics.length === 0, name);
}
assert(!result('windows-input-probe').passed && result('windows-input-probe').exit_code === 1);
assert(log('windows-input-probe').includes('B06_RUNTIME_FAIL: 39/40 checks'));
assert(result('windows-input-probe-settled').passed && result('windows-input-probe-settled').exit_code === 0);
assert(log('windows-input-probe-settled').includes('B06_RUNTIME_PASS: 40/40 checks'));
assert(log('windows-input-probe-settled').includes('B06_PROBE SETTLED velocity=0.0'));
assert(log('windows-hardware-input-probe').includes('samples=30')&&log('windows-hardware-input-probe').includes('dash_pressed_events=30'));
const metrics = JSON.parse(fs.readFileSync(path.join(dir,'diagnostic-runtime-metrics.json'),'utf8'));
for (const key of ['parity_day_differing_pixels','parity_night_differing_pixels','parity_secured_differing_pixels','translation_left_differing_pixels','translation_right_differing_pixels']) assert.equal(metrics[key],0,key);
const note = fs.readFileSync(path.join(root,'.atena/evidence/2026-10-04-b06-windows-review.md'),'utf8');
assert(note.includes(head)&&note.includes('human_acceptance: pending')&&note.includes('merge_approved: false'));
assert(note.includes('There is still no clean unmodified 40/40 Windows acceptance run.'));
for (const entry of ['add.yaml','state/plan.yaml','vault/canon','vault/drafts','vault/research','specs','evidence','generated']) assert(fs.existsSync(path.join(root,'.atena',entry)));
assert(fs.existsSync(path.join(root,'.atena/specs/2026-10-04-b06-stonehook-foot-expedition.md')));
const files = [];
function walk(folder) {
  for (const entry of fs.readdirSync(folder,{withFileTypes:true})) {
    const file = path.join(folder,entry.name);
    if (entry.isDirectory()) walk(file);
    else if (entry.name !== 'review-manifest.json') files.push(file);
  }
}
walk(dir);
files.push(path.join(root,'.atena/evidence/2026-10-04-b06-windows-review.md'));
const hashes = files.sort().map(file=>({path:path.relative(root,file).replaceAll('\\','/'),sha256:crypto.createHash('sha256').update(fs.readFileSync(file)).digest('hex')}));
fs.writeFileSync(path.join(dir,'review-manifest.json'),JSON.stringify({reviewed_head:head,original_main:baseline,platform:'Windows',godot:'4.7.2.stable.official.ed1daf0bf',original_suite_exit:1,original_route_checks:'36/40',hardware_filtered_diagnostic:'39/40',hardware_filtered_settled_diagnostic:'40/40',human_acceptance:'pending',files:hashes},null,2)+'\n');
console.log('B06_WINDOWS_REVIEW_RECEIPTS_PASS: 20 original cases, 2 distinct diagnostic results, raw controller sample, exact reviewed HEAD and unchanged main verified.');
console.log('Original route failure preserved; diagnostic 40/40 is not an unmodified acceptance pass. Human review and publication follow-up remain pending.');
