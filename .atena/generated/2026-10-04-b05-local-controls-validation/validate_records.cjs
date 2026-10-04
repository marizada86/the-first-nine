// Local ADD contract/link/operational checks; this is not a general YAML parser.
const fs = require('node:fs');
const path = require('node:path');
const assert = require('node:assert/strict');
const {execFileSync} = require('node:child_process');
const mergeCommit = 'bc7796e0fad33f5d7b773af3eaefc07749ec81b4';
const featureHead = 'e5832da604226b33f424d18248b24f0825c568aa';
const git = (...args) => execFileSync('git', args, {cwd: process.cwd(), encoding: 'utf8'}).replace(/\r\n/g, '\n');
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
  'evidence/2026-10-04-b05-thornwake-combat-readability.md',
  'evidence/2026-10-04-b05-thornwake-combat-readability-implementation.md',
  'evidence/2026-10-04-b05-pull-request.md',
  'evidence/2026-10-04-b05-documentation-closure.md',
  'evidence/2026-10-04-b05-local-controls-inventory-wagon-implementation.md',
  'evidence/2026-10-04-b05-enemy-geometry-followup.md',
  'generated/opus-handoff/2026-10-04-b05-controls-and-wagon-menu-instruction.md',
  'generated/opus-handoff/2026-10-04-b05-thornwake-combat-readability-instruction.md',
];
let links = 0;
for (const record of records) {
  const content = fs.readFileSync(path.join(workspace, record), 'utf8');
  assert(!/^(<<<<<<<|=======|>>>>>>>)/m.test(content), `Conflict marker in ${record}`);
  const expectedStatus = record.startsWith('vault/canon/') ? 'approved-design-decision' : record.includes('/opus-handoff/') ? 'archived-merged-b05-instruction' : 'complete-implementation-merged';
  assert(content.includes(`status: ${expectedStatus}`), `Stale status in ${record}`);
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
assert(/^active_plan: null$/m.test(state), 'Active plan must be cleared');
assert(/^plan_cursor: complete$/m.test(state), 'Cursor must be complete');
const normalize = text => text.replace(/^\uFEFF/, '').replace(/\r\n/g, '\n');
function section(text, name) {
  text = normalize(text);
  const marker = name + ':\n';
  const start = text.indexOf(marker);
  assert(start >= 0, 'Missing section: ' + name);
  const rest = text.slice(start + marker.length);
  const next = rest.search(/^[a-z_]+:/m);
  return (next < 0 ? rest : rest.slice(0, next)).trimEnd();
}
const completed = section(state, 'last_completed_plan');
for (const expected of [
  'id: "2026-10-04-b05-thornwake-combat-readability"',
  'status: complete-implementation-merged',
  'checkpoint: complete',
  'implementation_branch: codex/b05-controls-wagon-inventory',
  'original_implementation_branch: b05-thornwake-combat-readability',
  'original_published_commit: "4400b59aab49ed2860c5c6369ba79b386a7d2e9a"',
  'published_commit: "' + featureHead + '"',
  'merge_commit: "' + mergeCommit + '"',
  'human_validation_accepted: true',
  'revision_commit: "43ab1128f62f164bdcce64d92ea1fe8bd0dfef4c"',
  'revision_first_published_commit: "bb4a0d4830563dfa487409eaab852aefe4ca5d81"',
  'followup_push_approved: true', 'revision_published: true',
  'pull_request_approved: true', 'pull_request_status: merged',
  'merge_approved: true', 'merge_verified: true',
  'documentation_closure_approved: true', 'documentation_publication_approved: true',
  'pull_request_receipt_included_in_closure: true',
  'controls/menu 33/33', 'deferred_parry:',
  'geometry_correction_approved: true', 'geometry_correction_push_approved: true',
  'geometry_correction_published: true', 'geometry_correction_human_validation_accepted: true',
  'geometry_correction_status: complete-implementation-merged',
  'geometry_correction_commit: "b8823c70c637fdbef9f36e6cf0da0925369faa47"',
  'geometry_correction_base: "e6b614c3d3554d142fe93a90c05347176796d731"',
]) assert(completed.includes(expected), 'Missing completed fact: ' + expected);
for (const match of completed.matchAll(/\[\[([^\]]+)\]\]/g)) {
  assert(indexed.has(match[1]), 'Unresolved completed-plan link: ' + match[1]);
  links++;
}
const baseline = normalize(git('show', mergeCommit + ':.atena/state/plan.yaml'));
const oldCompleted = section(baseline, 'last_completed_plan');
const oldHistory = section(baseline, 'completed_plan_history');
const promoted = oldCompleted.split('\n').map((line, index) =>
  index === 0 ? '  - ' + line.trimStart() : line ? '  ' + line : '').join('\n');
const history = section(state, 'completed_plan_history');
assert.equal(history, promoted + '\n' + oldHistory, 'Prior history/B-04 altered or reordered');
const ids = [...history.matchAll(/^  - id: "([^"]+)"/gm)].map(match => match[1]);
assert.equal(ids.length, 29);
assert.equal(new Set(ids).size, 29);
assert.equal(ids[0], '2026-10-04-b04-thornwake-mark-one-stabilization');
assert(!/^  - id: "2026-10-04-b06/m.test(history), 'B-06 must not be started');
for (const match of baseline.matchAll(/^([a-z_]+):\n/gm)) {
  const name = match[1];
  if (['last_completed_plan', 'completed_plan_history', 'active_plan', 'approved_change_requests'].includes(name)) continue;
  assert.equal(section(state, name), section(baseline, name), 'Unrelated state changed: ' + name);
}
const priorChanges = section(baseline, 'approved_change_requests');
const expectedChanges = priorChanges.replace('status: implemented-published-awaiting-technical-review', 'status: complete-implementation-merged');
assert.equal(section(state, 'approved_change_requests'), expectedChanges, 'Unrelated change request modified');
assert.equal(git('rev-parse', mergeCommit + '^{tree}').trim(), git('rev-parse', featureHead + '^{tree}').trim());
for (const sha of ['4400b59', '43ab112', 'bb4a0d4', 'e6b614c', 'b8823c7', 'e5832da']) git('merge-base', '--is-ancestor', sha, mergeCommit);
assert.equal(git('rev-parse', 'refs/heads/codex/b05-controls-wagon-inventory').trim(), '3b37c9f5e24b15ddb98fccd9963c9e04c9f7fcde');
assert.equal(git('rev-parse', 'refs/heads/b05-thornwake-combat-readability').trim(), '4400b59aab49ed2860c5c6369ba79b386a7d2e9a');
assert.equal(git('rev-parse', 'refs/remotes/origin/codex/b05-controls-wagon-inventory').trim(), featureHead);
assert.equal(git('rev-parse', 'refs/remotes/origin/b05-thornwake-combat-readability').trim(), '4400b59aab49ed2860c5c6369ba79b386a7d2e9a');
const changed = git('diff', '--name-only', mergeCommit, '--').trim().split('\n').filter(Boolean);
const allowed = new Set([...records.map(record => '.atena/' + record),
  '.atena/state/plan.yaml',
  '.atena/generated/2026-10-04-b05-local-controls-validation/validate_records.cjs']);
assert(changed.every(file => allowed.has(file)), 'Unexpected change outside closure records: ' + changed.filter(file => !allowed.has(file)).join(', '));
git('diff', '--check', mergeCommit, '--');
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
console.log(`ADD_RECORDS_PASS: contract, ${links} record/completed-plan links, closed/merged state, 29 preserved history entries, documentation-only boundary`);
console.log('GEOMETRY_RECORDS_PASS: 46 historical checks, 5 rejected faults, saved process exits, owner acceptance/publication/merge facts; no new engine run');
console.log('YAML parser check: not performed; no new dependency installed.');
