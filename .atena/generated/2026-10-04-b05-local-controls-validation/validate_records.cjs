// Local ADD contract/link/operational checks; this is not a general YAML parser.
const fs = require('node:fs');
const path = require('node:path');
const assert = require('node:assert/strict');
const root = process.cwd();
const workspace = path.join(root, '.atena');
for (const name of ['add.yaml', 'state/plan.yaml', 'vault/canon', 'vault/drafts', 'vault/research', 'specs', 'evidence', 'generated']) {
  assert(fs.existsSync(path.join(workspace, name)), `Missing ADD contract path: ${name}`);
}
const indexed = new Set();
function walk(directory) {
  for (const entry of fs.readdirSync(directory, {withFileTypes: true})) {
    const file = path.join(directory, entry.name);
    if (entry.isDirectory()) walk(file);
    else if (entry.name.endsWith('.md')) indexed.add(entry.name.slice(0, -3));
  }
}
walk(workspace);
const records = [
  'vault/canon/2026-10-04-separated-controls-and-wagon-management.md',
  'specs/2026-10-04-b05-controls-and-wagon-menu-revision.md',
  'specs/2026-10-04-b05-enemy-geometry-followup.md',
  'specs/2026-10-04-b05-thornwake-combat-readability.md',
  'evidence/2026-10-04-b05-controls-and-wagon-menu-review.md',
  'evidence/2026-10-04-b05-local-controls-inventory-wagon-implementation.md',
  'evidence/2026-10-04-b05-enemy-geometry-followup.md',
  'generated/opus-handoff/2026-10-04-b05-controls-and-wagon-menu-instruction.md',
  'generated/opus-handoff/2026-10-04-b05-thornwake-combat-readability-instruction.md',
];
let links = 0;
for (const record of records) {
  const content = fs.readFileSync(path.join(workspace, record), 'utf8');
  assert(!/^(<<<<<<<|=======|>>>>>>>)/m.test(content), `Conflict marker in ${record}`);
  for (const match of content.matchAll(/\[\[([^\]]+)\]\]/g)) {
    const target = match[1].split('|')[0].split('#')[0];
    assert(indexed.has(target), `Unresolved ${target} in ${record}`);
    links++;
  }
}
const state = fs.readFileSync(path.join(workspace, 'state/plan.yaml'), 'utf8');
assert(!/^(<<<<<<<|=======|>>>>>>>)/m.test(state), 'Plan conflict marker');
assert(!/\t/.test(state), 'YAML indentation contains tabs');
assert.equal((state.match(/^active_plan:/gm) || []).length, 1);
assert.equal((state.match(/^plan_cursor:/gm) || []).length, 1);
const active = state.split(/^active_plan:\r?\n/m)[1].split(/^plan_cursor:/m)[0];
assert(active.includes('status: implemented-local-awaiting-geometry-review'));
assert(active.includes('human_validation_accepted: true'));
assert(active.includes('revision_commit: "43ab1128f62f164bdcce64d92ea1fe8bd0dfef4c"'));
assert(active.includes('revision_branch: codex/b05-controls-wagon-inventory'));
assert(active.includes('followup_push_approved: true'));
assert(active.includes('revision_published: true'));
assert(active.includes('revision_first_published_commit: "bb4a0d4830563dfa487409eaab852aefe4ca5d81"'));
assert(active.includes('pull_request_approved: false'));
assert(active.includes('merge_approved: false'));
assert(active.includes('controls/menu 33/33'));
assert(active.includes('deferred_parry:'));
assert(active.includes('geometry_correction_approved: true'));
assert(active.includes('geometry_correction_push_approved: false'));
assert(active.includes('geometry_correction_published: false'));
assert(active.includes('geometry_correction_human_validation_accepted: false'));
assert(active.includes('checkpoint: local-enemy-geometry-human-review'));
assert(active.includes('geometry_correction_base: "e6b614c3d3554d142fe93a90c05347176796d731"'));
for (const match of active.matchAll(/\[\[([^\]]+)\]\]/g)) {
  assert(indexed.has(match[1]), `Unresolved active-plan link: ${match[1]}`);
  links++;
}
for (const name of ['runtime.log', 'combat.log', 'self-test.log', 'normal-smoke.log', 'headless-smoke.log']) {
  const log = fs.readFileSync(path.join(__dirname, name), 'utf8');
  assert(!/SCRIPT ERROR:|ERROR:|WARNING:/.test(log), `Godot diagnostic in final ${name}`);
}
assert(fs.readFileSync(path.join(__dirname, 'runtime.log'), 'utf8').includes('LOCAL_CONTROLS_PASS: 33/33'));
assert(fs.readFileSync(path.join(__dirname, 'combat.log'), 'utf8').includes('B05_RUNTIME_PASS: 0 failures'));
const geometryDir = path.join(workspace, 'generated/2026-10-04-b05-geometry-validation');
for (const name of ['geometry', 'combat', 'runtime', 'self-test', 'normal-smoke', 'headless-smoke']) {
  const result = JSON.parse(fs.readFileSync(path.join(geometryDir, `${name}-result.json`), 'utf8'));
  assert(result.passed && result.exit_code === 0, `Actual Godot process failed: ${name}`);
  const log = fs.readFileSync(path.join(geometryDir, name === 'geometry' ? 'geometry-render.log' : `${name}.log`), 'utf8');
  assert(!/SCRIPT ERROR:|ERROR:|WARNING:/.test(log), `Diagnostic in geometry follow-up ${name}`);
}
const geometry = JSON.parse(fs.readFileSync(path.join(geometryDir, 'geometry-metrics.json'), 'utf8'));
assert.equal(geometry.checks, 46);
assert.equal(geometry.failures, 0);
assert.equal(geometry.startup_cells, 22);
assert.equal(geometry.gameplay_added_scans, 0);
const negatives = JSON.parse(fs.readFileSync(path.join(geometryDir, 'negative-controls.json'), 'utf8'));
assert.equal(negatives.length, 5);
assert(negatives.every(result => result.detected && result.exit_code === 1 && result.detections.length > 0));
assert(fs.readFileSync(path.join(geometryDir, 'runtime.log'), 'utf8').includes('LOCAL_CONTROLS_PASS: 33/33'));
assert(fs.readFileSync(path.join(geometryDir, 'combat.log'), 'utf8').includes('B05_RUNTIME_PASS: 0 failures'));
console.log(`ADD_RECORDS_PASS: contract, ${links} record/active-plan links, review/publication state, final log diagnostics`);
console.log('GEOMETRY_RECORDS_PASS: 46 checks, 5 rejected faults, actual process exits, local-only review gate');
console.log('YAML parser check: not performed; no new dependency installed.');
