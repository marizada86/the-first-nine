// B-08 implementation-checkpoint record and saved-result checks. Run from the repository root.
// Structural checks only: no Godot execution and no whole-file YAML parser claim.
const fs = require('node:fs');
const path = require('node:path');
const assert = require('node:assert/strict');
const {execFileSync} = require('node:child_process');
const baseline = '4d3c5c1ae5411aaf58e6fd7ae8333e45ecef7ac1';
const status = 'status: implemented-awaiting-human-review';
const dir = '.atena/generated/2026-10-05-b08-validation';
const git = (...args) => execFileSync('git', args, {encoding: 'utf8'}).replace(/\r\n/g, '\n');
const normalize = text => text.replace(/^﻿/, '').replace(/\r\n/g, '\n').trimEnd();
const spec = '.atena/specs/2026-10-05-b08-stonehook-cliff-harrier.md';
const planning = '.atena/evidence/2026-10-05-b08-stonehook-cliff-harrier.md';
const instruction = '.atena/generated/opus-handoff/2026-10-05-b08-stonehook-cliff-harrier-instruction.md';
const note = '.atena/evidence/2026-10-05-b08-stonehook-cliff-harrier-implementation.md';

for (const entry of ['add.yaml', 'state/plan.yaml', 'vault/canon', 'specs', 'evidence', 'generated']) assert(fs.existsSync('.atena/' + entry), 'Missing ADD entry ' + entry);
const ids = new Set();
(function walk(folder) {
  for (const entry of fs.readdirSync(folder, {withFileTypes: true})) {
    const file = path.join(folder, entry.name);
    if (entry.isDirectory()) walk(file);
    else if (entry.name.endsWith('.md')) ids.add(entry.name.slice(0, -3));
  }
})('.atena');
let links = 0;
const countLinks = (text, where) => {
  for (const match of text.matchAll(/\[\[([^\]]+)\]\]/g)) {
    assert(ids.has(match[1]), 'Unresolved link ' + match[1] + ' in ' + where);
    links++;
  }
};
for (const file of [spec, planning, instruction, note]) {
  const text = fs.readFileSync(file, 'utf8');
  assert(text.includes(status), 'Status not reconciled in ' + file);
  for (const fact of ['approval_mode: per-plan', 'implementation_approved: true', 'baseline_commit: ' + baseline, 'push_approved: false', 'pull_request_approved: false', 'merge_approved: false', 'dispatch_approved: false', 'implementation_branch: codex/b08-stonehook-cliff-harrier', 'human_acceptance: pending']) assert(text.includes(fact), 'Fact ' + fact + ' missing in ' + file);
  assert(!/^(<<<<<<<|=======|>>>>>>>)/m.test(text), 'Conflict marker in ' + file);
  countLinks(text, file);
}
for (const file of [spec, planning, instruction]) assert(fs.readFileSync(file, 'utf8').includes('implementation_evidence: "[[2026-10-05-b08-stonehook-cliff-harrier-implementation]]"'), 'Implementation link missing in ' + file);
const noteText = fs.readFileSync(note, 'utf8');
for (const fact of ['origin: planned', 'implementation_preceded_spec: false', 'engine_rerun: true', '## Starting point verification', '## Implemented behavior', '## Tuning adjustments and decisions for review', '## Validation', '## Acceptance comparison', '## Limitations and review steps']) assert(noteText.includes(fact), 'Note missing ' + fact);

// Plan state: only the active plan block and cursor change; completed history is preserved exactly.
const state = normalize(fs.readFileSync('.atena/state/plan.yaml', 'utf8'));
assert(fs.readFileSync('.atena/state/plan.yaml', 'utf8').startsWith('﻿'), 'Plan state BOM removed');
const before = normalize(git('show', baseline + ':.atena/state/plan.yaml'));
const active = state.match(/^active_plan:\n([\s\S]*?)^plan_cursor:/m)[1];
for (const fact of ['id: "2026-10-05-b08-stonehook-cliff-harrier"', 'status: implemented-awaiting-human-review', 'approval_mode: per-plan', 'implementation_approved: true', 'checkpoint: implementation-awaiting-human-review', 'baseline_commit: "' + baseline + '"', 'implementation_branch: codex/b08-stonehook-cliff-harrier', 'implementation_evidence: "[[2026-10-05-b08-stonehook-cliff-harrier-implementation]]"', 'human_acceptance: pending', 'push_approved: false', 'pull_request_approved: false', 'merge_approved: false', 'dispatch_approved: false', 'blocking_gaps: []', 'steps_completed: ["S-001-harrier-combat", "S-002-two-actor-restoration", "S-003-validation"]', 'batches_completed: ["B-001-harrier-combat", "B-002-two-actor-restoration", "B-003-validation"]']) assert(active.includes(fact), 'Plan state missing ' + fact);
assert(!active.includes('status: complete'), 'Plan marked complete before human acceptance');
countLinks(active, 'plan.yaml');
assert(state.includes('plan_cursor: B-08-implemented-awaiting-human-review'), 'Plan cursor not reconciled');
const strip = text => text.replace(/^active_plan:[^\n]*\n[\s\S]*?^plan_cursor:.*$/m, 'ACTIVE');
assert.equal(strip(state), strip(before), 'Completed plans or history changed');
assert(/^last_completed_plan:\n  id: "2026-10-05-b07-stonehook-first-encounter"/m.test(state), 'B-07 is no longer the last completed plan');
assert(!/\t/.test(state), 'Tab in plan state');

// Scope: production limited to main.gd; records and validation under .atena.
git('merge-base', '--is-ancestor', baseline, 'HEAD');
const allowed = new Set(['main.gd', spec, planning, instruction, note, '.atena/state/plan.yaml']);
const changed = git('diff', '--name-only', baseline, '--').trim().split('\n').filter(Boolean);
const untracked = git('ls-files', '--others', '--exclude-standard').trim().split('\n').filter(Boolean);
for (const file of [...changed, ...untracked]) assert(allowed.has(file) || file.startsWith(dir + '/'), 'Out-of-scope change ' + file);
assert.equal(git('diff', '--name-only', baseline, '--', 'assets', 'project.godot', 'main.tscn', 'wagon_inventory_ui.gd', '.atena/vault', '.atena/add.yaml', '.atena/generated/2026-10-05-b07-validation', '.atena/generated/2026-10-05-b07-delivery', '.atena/generated/2026-10-04-b06-validation', '.atena/generated/2026-10-04-b05-combat-validation', '.atena/generated/2026-10-04-b05-geometry-validation', '.atena/generated/2026-10-04-b05-local-controls-validation', '.atena/generated/2026-10-04-enemy-facing-validation', '.atena/generated/2026-10-04-playtester-validation').trim(), '', 'Protected or historical files changed');
git('-c', 'core.whitespace=-blank-at-eof', 'diff', '--check', baseline, '--');
console.log('B08_IMPLEMENTATION_RECORDS_PASS: ' + links + ' resolved links, implementation-awaiting-review status, verified baseline ' + baseline.slice(0, 7) + ', per-plan approval with publication gates closed, exact completed-plan history and scoped paths.');

// Saved results from the recorded engine runs (no new Godot run).
const result = name => JSON.parse(fs.readFileSync(path.join(dir, name + '-result.json'), 'utf8'));
const log = name => fs.readFileSync(path.join(dir, name + '.log'), 'utf8');
const passing = ['b08-headless', 'b08-runtime', 'self-test', 'b07-headless', 'b07-runtime', 'b06-headless', 'b06-runtime', 'combat', 'combat-noise', 'menus', 'geometry', 'facing-headless', 'normal-smoke', 'headless-smoke'];
for (const name of passing) {
  const record = result(name);
  assert(record.passed === true && record.exit_code === 0 && record.project_diagnostics.length === 0, 'Saved result not passing: ' + name);
  assert(record.platform && String(record.platform.godot).startsWith('4.7.2'), 'Missing platform tag in ' + name);
}
assert(log('b08-headless').includes('B08_PASS: 34/34 checks'));
assert(/B08_RUNTIME_PASS: (\d+)\/\1 checks/.test(log('b08-runtime')), 'Runtime marker');
assert(['SELF_TEST_B06_PASS', 'SELF_TEST_B07_PASS', 'SELF_TEST_B08_PASS', 'SELF_TEST_PLAYTESTER_PASS', 'SELF_TEST_PASS:'].every(marker => log('self-test').includes(marker)));
assert(log('b07-headless').includes('B07_PASS: 24/24 checks'));
assert(log('b07-runtime').includes('B07_RUNTIME_PASS: 28/28 checks'));
assert(log('b06-headless').includes('B06_PASS: 30/30 checks'));
assert(log('b06-runtime').includes('B06_RUNTIME_PASS: 53/53 checks'));
assert(log('menus').includes('LOCAL_CONTROLS_PASS: 33/33 checks') && log('menus').includes('MENU_ISOLATION PASS'));
assert(log('geometry').includes('GEOMETRY_PASS: 46/46 checks'));
assert(log('facing-headless').includes('FACING_PASS: 65/65 checks'));
for (const name of ['combat', 'combat-noise']) {
  assert.equal((log(name).match(/^RUNTIME PASS /gm) || []).length, 9, 'Combat checks in ' + name);
  assert(/^COMBAT_ISOLATION PASS: .*before gameplay=true/m.test(log(name)), 'Combat isolation marker missing in ' + name);
}
const faults = {wrong_artwork: 'harrier_geometry_crop', unreachable_flight: 'harrier_reachable_in_live_flight', late_bounds: 'harrier_bounds_ready_before_first_frame', retargeting: 'harrier_windup_locks_target', repeated_damage: 'harrier_single_hit_per_dive', boundary_escape: 'harrier_stays_in_bounds', shared_defeat_state: 'independent_defeat_and_reward', duplicate_reward: 'independent_defeat_and_reward', incomplete_rollback: 'save_combo_neither', incomplete_f4_restore: 'f4_restores_both_exactly', duplicate_spawn: 'harrier_activation_at_2600'};
for (const [fault, assertion] of Object.entries(faults)) {
  const record = result('negative-' + fault);
  assert(record.passed === true && record.exit_code === 1 && record.project_diagnostics.length === 0, 'Faulty control not rejected: ' + fault);
  assert(record.detections.some(line => line === 'B08 FAIL ' + assertion || line.startsWith('B08 FAIL ' + assertion + ' ')), 'Named assertion missing for ' + fault);
  assert(!/SCRIPT ERROR|Parse Error|B08_LOAD_FAIL/.test(log('negative-' + fault)), 'Crash counted as rejection: ' + fault);
}
// Rendered facing: 102/102 on any platform, or only the known Linux software-OpenGL difference.
const facing = result('facing-normal');
const knownDifference = ['FACING FAIL ANTLERED HUNGER frame 1 labels/bars stay unmirrored'];
if (facing.passed === true) {
  assert(log('facing-normal').includes('FACING_PASS: 102/102 checks'));
} else {
  assert(facing.exit_code === 1 && facing.platform.os === 'linux' && /llvmpipe/.test(String(facing.platform.device)), 'facing-normal failure outside the known Linux software-OpenGL case');
  assert.deepEqual(log('facing-normal').split(/\r?\n/).filter(line => line.startsWith('FACING FAIL ')), knownDifference);
  // The same single difference reproduces on the unchanged pre-B-08 build.
  assert.deepEqual(log('facing-normal-baseline-4d3c5c1').split(/\r?\n/).filter(line => line.startsWith('FACING FAIL ')), knownDifference);
}
for (const capture of ['harrier-day-left', 'harrier-day-right', 'harrier-night-left', 'harrier-night-right', 'harrier-windup', 'harrier-hit', 'harrier-miss', 'harrier-retreat', 'harrier-recovery', 'both-actors-day', 'both-actors-night', 'both-actors-fight']) assert(fs.existsSync(path.join(dir, capture + '.png')), 'Missing capture ' + capture);
const metrics = JSON.parse(fs.readFileSync(path.join(dir, 'b08-runtime-metrics.json'), 'utf8'));
assert.equal(metrics.isolation.pulse, 0, 'Isolation after the first gameplay frame');
assert(metrics.isolation.first_gameplay_frame > metrics.isolation.isolated_frame, 'Isolation timing proof missing');
assert.deepEqual([metrics.noise.dashed, metrics.noise.queued], [false, false], 'Trigger noise acted');
assert.equal(metrics.activation.spawned_early, false, 'Harrier appeared before x=2600');
assert(metrics.activation.first_spawn_player_x >= 2596, 'Activation x');
for (const view of ['day-left', 'day-right', 'night-left', 'night-right']) assert.equal(metrics['view_' + view].padding_changes, 0, 'Padding drawn in ' + view);
console.log('B08_SAVED_RESULTS_PASS: ' + passing.length + ' passing suites, 11 faulty controls rejected by their named assertions, 12 captures, clean padding in 4 frozen views, activation at x>=2600 and isolation before the first gameplay frame; rendered facing ' + (facing.passed ? '102/102' : '101/102 (known Linux software-OpenGL difference)') + ' on ' + facing.platform.os + '.');
