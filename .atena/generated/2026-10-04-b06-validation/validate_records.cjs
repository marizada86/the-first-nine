// B-06 implementation-checkpoint record and saved-result checks. Run from the repository root.
// Structural checks only: no Godot execution and no whole-file YAML parser claim.
const fs = require('node:fs');
const path = require('node:path');
const assert = require('node:assert/strict');
const {execFileSync} = require('node:child_process');
const base = '7e477ba799ce5b4bf9cb6e9dde44e83c97db0bbc';
const implementation = '42bddf87b64eafb2046a47b1f2695df3ad9d4075';
const dir = '.atena/generated/2026-10-04-b06-validation';
const git = (...args) => execFileSync('git', args, {encoding: 'utf8'}).replace(/\r\n/g, '\n');
const normalize = text => text.replace(/^﻿/, '').replace(/\r\n/g, '\n').trimEnd();
const spec = '.atena/specs/2026-10-04-b06-stonehook-foot-expedition.md';
const planning = '.atena/evidence/2026-10-04-b06-stonehook-foot-expedition.md';
const instruction = '.atena/generated/opus-handoff/2026-10-04-b06-stonehook-foot-expedition-instruction.md';
const note = '.atena/evidence/2026-10-04-b06-stonehook-foot-expedition-implementation.md';

for (const entry of ['add.yaml', 'state/plan.yaml', 'vault/canon', 'vault/drafts', 'vault/research', 'specs', 'evidence', 'generated']) assert(fs.existsSync('.atena/' + entry), 'Missing ADD entry ' + entry);
const ids = new Set();
(function walk(folder) {
  for (const entry of fs.readdirSync(folder, {withFileTypes: true})) {
    const file = path.join(folder, entry.name);
    if (entry.isDirectory()) walk(file);
    else if (entry.name.endsWith('.md')) ids.add(entry.name.slice(0, -3));
  }
})('.atena');
let links = 0;
for (const file of [spec, planning, instruction, note]) {
  const text = fs.readFileSync(file, 'utf8');
  assert(text.includes('status: implemented-awaiting-review'), 'Status not reconciled in ' + file);
  assert(text.includes('approval_mode: per-plan'), 'Approval mode missing in ' + file);
  assert(text.includes('push_approved: false'), 'Push gate missing in ' + file);
  assert(text.includes(implementation), 'Implementation commit missing in ' + file);
  assert(!/^(<<<<<<<|=======|>>>>>>>)/m.test(text), 'Conflict marker in ' + file);
  for (const match of text.matchAll(/\[\[([^\]]+)\]\]/g)) {
    assert(ids.has(match[1]), 'Unresolved link ' + match[1] + ' in ' + file);
    links++;
  }
}
for (const file of [spec, planning, instruction]) {
  const text = fs.readFileSync(file, 'utf8');
  assert(text.includes('implementation_approved: true') && text.includes('dispatch_approved: false'), 'Gate facts missing in ' + file);
  assert(text.includes('implementation_evidence: "[[2026-10-04-b06-stonehook-foot-expedition-implementation]]"'), 'Implementation link missing in ' + file);
}
const noteText = fs.readFileSync(note, 'utf8');
for (const fact of ['origin: planned', 'implementation_preceded_spec: false', 'human_review: pending', 'pull_request_approved: false', 'merge_approved: false', 'published: false', 'base_commit: ' + base]) assert(noteText.includes(fact), 'Note missing ' + fact);

// Plan state: only the active plan block and cursor change; completed history is preserved exactly.
const state = normalize(fs.readFileSync('.atena/state/plan.yaml', 'utf8'));
const before = normalize(git('show', base + ':.atena/state/plan.yaml'));
const active = state.match(/^active_plan:\n([\s\S]*?)^plan_cursor:/m)[1];
for (const fact of ['id: "2026-10-04-b06-stonehook-foot-expedition"', 'status: implemented-awaiting-review', 'approval_mode: per-plan', 'implementation_approved: true', 'checkpoint: owner-review-of-local-implementation', 'implementation_branch: codex/b06-stonehook-foot-expedition', 'implementation_base: "' + base + '"', 'implementation_commit: "' + implementation + '"', 'implementation_published: false', 'human_review: pending', 'push_approved: false', 'pull_request_approved: false', 'merge_approved: false', 'dispatch_approved: false', 'blocking_gaps: []', 'steps_completed: ["S-001-route-rendering", "S-002-camp-resource-guards", "S-003-restoration", "S-004-validation-review"]']) assert(active.includes(fact), 'Plan state missing ' + fact);
for (const match of active.matchAll(/\[\[([^\]]+)\]\]/g)) { assert(ids.has(match[1]), 'Unresolved plan link ' + match[1]); links++; }
assert(state.includes('plan_cursor: B-06-implemented-awaiting-owner-review'), 'Plan cursor not reconciled');
const strip = text => text.replace(/^active_plan:\n[\s\S]*?^plan_cursor:.*$/m, 'ACTIVE');
assert.equal(strip(state), strip(before), 'Completed plans or history changed');
assert(!/\t/.test(state), 'Tab in plan state');

// Scope: runtime limited to main.gd and wagon_inventory_ui.gd; records and validation under .atena.
git('merge-base', '--is-ancestor', base, 'HEAD');
git('merge-base', '--is-ancestor', implementation, 'HEAD');
const allowed = new Set(['main.gd', 'wagon_inventory_ui.gd', spec, planning, instruction, note, '.atena/state/plan.yaml']);
const changed = git('diff', '--name-only', base, '--').trim().split('\n').filter(Boolean);
const untracked = git('ls-files', '--others', '--exclude-standard').trim().split('\n').filter(Boolean);
for (const file of [...changed, ...untracked]) assert(allowed.has(file) || file.startsWith(dir + '/'), 'Out-of-scope change ' + file);
assert.equal(git('diff', '--name-only', base, '--', 'assets', 'project.godot', 'main.tscn', '.atena/vault', '.atena/add.yaml', '.atena/generated/2026-10-04-b06-preparation', '.atena/generated/2026-10-04-b05-combat-validation', '.atena/generated/2026-10-04-b05-geometry-validation', '.atena/generated/2026-10-04-b05-local-controls-validation', '.atena/generated/2026-10-04-enemy-facing-validation', '.atena/generated/2026-10-04-playtester-validation').trim(), '', 'Protected or historical files changed');
git('-c', 'core.whitespace=-blank-at-eof', 'diff', '--check', base, '--');
console.log('B06_IMPLEMENTATION_RECORDS_PASS: ' + links + ' resolved links, reconciled implemented-awaiting-review status, per-plan approval with closed publication gates, exact completed-plan history and scoped paths.');

// Saved results from the recorded engine runs (no new Godot run).
const result = name => JSON.parse(fs.readFileSync(path.join(dir, name + '-result.json'), 'utf8'));
const log = name => fs.readFileSync(path.join(dir, name + '.log'), 'utf8');
for (const name of ['b06-headless', 'b06-runtime', 'self-test', 'combat', 'menus', 'geometry', 'facing-headless', 'normal-smoke', 'headless-smoke']) {
  const record = result(name);
  assert(record.passed === true && record.exit_code === 0 && record.project_diagnostics.length === 0, 'Saved result not passing: ' + name);
}
assert(log('b06-headless').includes('B06_PASS: 30/30 checks'));
assert(log('b06-runtime').includes('B06_RUNTIME_PASS: 40/40 checks'));
assert(log('self-test').includes('SELF_TEST_B06_PASS') && log('self-test').includes('SELF_TEST_PASS:'));
assert(log('menus').includes('LOCAL_CONTROLS_PASS: 33/33 checks'));
assert(log('geometry').includes('GEOMETRY_PASS: 46/46 checks'));
assert(log('facing-headless').includes('FACING_PASS: 65/65 checks'));
assert.equal((log('combat').match(/^RUNTIME PASS /gm) || []).length, 9);
const negatives = ['bypass_departure', 'border_respawn', 'remote_wagon', 'paused_offscreen', 'lost_route_restore', 'lost_f4_fields', 'progression_unlock', 'new_run_keeps_route'].map(f => 'negative-' + f).concat(['render-negative-leaked_camera_transform', 'render-negative-unshifted_reflection']);
for (const name of negatives) {
  const record = result(name);
  assert(record.passed === true && record.exit_code === 1 && record.detections.length > 0 && record.project_diagnostics.length === 0, 'Faulty control not rejected: ' + name);
}
// The rendered facing suite keeps its single environment-specific difference, reproduced on the baseline.
const facing = result('facing-normal');
assert(facing.passed === false && facing.exit_code === 1, 'facing-normal must stay recorded as failing');
const failLines = text => text.split(/\r?\n/).filter(line => line.startsWith('FACING FAIL '));
assert.deepEqual(failLines(log('facing-normal')), ['FACING FAIL ANTLERED HUNGER frame 1 labels/bars stay unmirrored']);
assert.deepEqual(failLines(fs.readFileSync(path.join(dir, 'facing-normal-baseline-7e477ba.log'), 'utf8')), ['FACING FAIL ANTLERED HUNGER frame 1 labels/bars stay unmirrored']);
const metrics = JSON.parse(fs.readFileSync(path.join(dir, 'runtime-metrics.json'), 'utf8'));
for (const key of ['parity_day_differing_pixels', 'parity_night_differing_pixels', 'parity_secured_differing_pixels', 'translation_left_differing_pixels', 'translation_right_differing_pixels']) assert.equal(metrics[key], 0, key);
assert.equal(new Set(metrics.hud_title_glyph_pixels).size, 1);
for (const capture of ['day', 'night']) for (const x of ['1000', '1280', '1520', '1760', '2400']) assert(fs.existsSync(path.join(dir, `transition-${capture}-${x}.png`)), 'Missing capture ' + capture + x);
console.log('B06_SAVED_RESULTS_PASS: 9 passing suites, 10 rejected faulty controls, pixel-exact cave parity and translation, 10 transition captures; facing-normal 101/102 kept as the baseline-reproduced environment difference.');
