// B-06 documentary closure checks. Run from the repository root. Structural and git checks only:
// no Godot execution, no whole-file YAML parser claim, and no engine result is produced or inferred.
// The 2026-10-04-b06-validation/validate_records.cjs validator and the 2026-10-04-enemy-facing
// validator describe earlier plan checkpoints and are intentionally left unchanged.
const fs = require('node:fs');
const path = require('node:path');
const assert = require('node:assert/strict');
const {execFileSync} = require('node:child_process');
const git = (...args) => execFileSync('git', args, {encoding: 'utf8'}).replace(/\r\n/g, '\n');
const normalize = text => text.replace(/^﻿/, '').replace(/\r\n/g, '\n').trimEnd();
const MERGE = 'e304badbbd15c6ce2bd93b114006dd26c0c7391e';
const BASE = '7e477ba799ce5b4bf9cb6e9dde44e83c97db0bbc';
const HEAD = 'cc87e1c3d88c837e16aca8f39bf7f0870f5b1246';
const TREE = '0065a0d7258519fa94e77c80e22c5f4428cb8aeb';
const COMMITS = ['42bddf8', 'ccc4fcf', 'd2012a1', '7c781ab', 'b446b7b', '9640881', '7de6d66', 'cc87e1c'];
const PR = 'https://github.com/marizada86/the-first-nine/pull/6';
const STATUS = 'complete-implementation-merged';
const records = [
  '.atena/specs/2026-10-04-b06-stonehook-foot-expedition.md',
  '.atena/evidence/2026-10-04-b06-stonehook-foot-expedition.md',
  '.atena/evidence/2026-10-04-b06-stonehook-foot-expedition-implementation.md',
  '.atena/generated/opus-handoff/2026-10-04-b06-stonehook-foot-expedition-instruction.md',
];
const validatorDir = '.atena/generated/2026-10-05-b06-closure-validation';

// ADD structure and links.
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
const checkLinks = (text, label) => { for (const match of text.matchAll(/\[\[([^\]]+)\]\]/g)) { assert(ids.has(match[1]), 'Unresolved link ' + match[1] + ' in ' + label); links++; } };

// The four records.
for (const file of records) {
  const text = fs.readFileSync(file, 'utf8');
  const frontmatter = text.slice(0, text.indexOf('\n---\n', 4));
  for (const fact of ['status: ' + STATUS, 'human_review: accepted', 'human_acceptance: accepted', 'human_acceptance_date: 2026-10-05', 'pull_request: ' + PR, 'pull_request_number: 6', 'pull_request_state: merged', 'pull_request_head: ' + HEAD, 'pull_request_base: ' + BASE, 'merge_commit: ' + MERGE, 'merge_parents: [' + BASE + ', ' + HEAD + ']', 'feature_branch_preserved: true', 'merge_verified: true', 'pull_request_approved: true', 'merge_approved: true', 'dispatch_approved: false', 'standing_publication_authority: none', 'closure_record_publication_approved: true', 'latest_published_commit: 7de6d6658a2e8b7aea5954320ef29902094d7215', 'approval_mode: per-plan']) assert(frontmatter.includes(fact), 'Missing "' + fact + '" in ' + file);
  // The implementation note never carried this key; the spec, planning evidence and instruction did.
  if (file !== records[2]) assert(frontmatter.includes('implementation_approved: true'), 'implementation_approved missing in ' + file);
  assert(frontmatter.includes('preserved_commits: [' + COMMITS.join(', ') + ']'), 'Preserved commits missing in ' + file);
  assert(!/status: (implemented-published-human-accepted-awaiting-pr|implemented-branch-published)/.test(frontmatter), 'Stale status in ' + file);
  assert(text.includes('## Closure: PR #6 Merged and B-06 Complete'), 'Closure section missing in ' + file);
  for (const wording of ['not reproduced by the executor', 'no CI result is inferred', 'Non-authorizing', 'in-memory-only saves', 'far edge (x=2998)', '101/102', 'B-07 has not been started', 'dated historical checkpoint']) assert(text.includes(wording) || text.includes(wording.toLowerCase()), 'Closure wording "' + wording + '" missing in ' + file);
  assert(!/^(<<<<<<<|=======|>>>>>>>)/m.test(text), 'Conflict marker in ' + file);
  checkLinks(text, file);
}
// Earlier dated sections must still be present (publication history, Windows results, acceptance).
const note = fs.readFileSync(records[2], 'utf8');
for (const history of ['## Authorized branch publication', '## Review follow-up', '## Follow-up publication', '## Test-isolation follow-up', '## Isolation publication', '## Combat isolation follow-up', 'Human acceptance (2026-10-05)']) assert(note.includes(history), 'Earlier section lost: ' + history);

// Plan state and exact history preservation, against the pre-closure plan at the merge commit.
const state = normalize(fs.readFileSync('.atena/state/plan.yaml', 'utf8'));
const before = normalize(git('show', MERGE + ':.atena/state/plan.yaml'));
assert(fs.readFileSync('.atena/state/plan.yaml', 'utf8').startsWith('﻿') === git('show', MERGE + ':.atena/state/plan.yaml').startsWith('﻿'), 'BOM changed');
assert(!/\t/.test(state), 'Tab in plan state');
assert(/^active_plan: null$/m.test(state) && /^plan_cursor: complete$/m.test(state), 'Plan not cleared');
const section = (text, from, to) => text.slice(text.indexOf(from), text.indexOf(to));
const lastNew = section(state, 'last_completed_plan:\n', 'completed_plan_history:\n');
const lastOld = section(before, 'last_completed_plan:\n', 'completed_plan_history:\n');
const histNew = section(state, 'completed_plan_history:\n', 'active_plan:');
const histOld = section(before, 'completed_plan_history:\n', 'active_plan:');
const activeOld = section(before, 'active_plan:\n', 'plan_cursor:');
for (const fact of ['id: "2026-10-04-b06-stonehook-foot-expedition"', 'status: ' + STATUS, 'checkpoint: complete', 'approval_mode: per-plan', 'implementation_approved: true', 'human_acceptance: accepted', 'dispatch_approved: false', 'pull_request: "' + PR + '"', 'pull_request_state: merged', 'merge_commit: "' + MERGE + '"', 'merge_parents: ["' + BASE + '", "' + HEAD + '"]', 'merge_verified: true', 'feature_branch_preserved: true', 'standing_publication_authority: none', 'blocking_gaps: []', 'latest_published_commit: "7de6d6658a2e8b7aea5954320ef29902094d7215"']) assert(lastNew.includes(fact), 'Plan fact missing: ' + fact);
assert(lastNew.includes('preserved_commits: ["' + COMMITS.join('", "') + '"]'), 'Plan preserved commits');
assert(/next_recommendation: "Non-authorizing\./.test(lastNew), 'B-07 recommendation must be explicitly non-authorizing');
assert(!/status: implemented/.test(lastNew), 'Stale status in the completed plan');
checkLinks(lastNew, 'plan last_completed_plan');
// The previous latest completed plan moved, unchanged, to the first history entry.
const reindent = block => block.split('\n').filter(Boolean).slice(1).map((line, index) => (index === 0 ? '  - ' : '    ') + line.slice(2)).join('\n');
const oldLastLines = lastOld.split('\n').filter(Boolean).slice(1);
const movedFacing = oldLastLines.map((line, index) => (index === 0 ? '  - ' : '    ') + line.slice(2)).join('\n');
assert(histNew.startsWith('completed_plan_history:\n' + movedFacing + '\n'), 'Previous latest completed plan was not moved unchanged to the first history entry');
assert(movedFacing.includes('id: "2026-10-04-enemy-facing-correction"'));
// Every older history entry follows, byte for byte.
assert.equal(histNew, histOld.replace('completed_plan_history:\n', 'completed_plan_history:\n' + movedFacing + '\n'), 'Earlier completed-plan history changed');
const count = text => (text.match(/^  - id:/gm) || []).length;
assert.equal(count(histNew), count(histOld) + 1, 'History entry count');
// The new completed plan equals the pre-closure active plan except for the intended closure edits.
const newKeys = lastNew.split('\n').filter(Boolean).slice(1);
const intended = ['status', 'push_approved', 'pull_request_approved', 'merge_approved', 'checkpoint', 'pull_request_state', 'exception'];
for (const line of activeOld.split('\n').filter(Boolean).slice(1)) {
  const key = line.match(/^  ([a-z_0-9]+):/)[1];
  if (!intended.includes(key)) assert(newKeys.includes(line), 'Pre-closure plan line lost or changed: ' + key);
}
// Everything outside the moved and replaced blocks is unchanged.
const outside = text => text.replace(/^last_completed_plan:\n[\s\S]*?^completed_plan_history:\n[\s\S]*?^(active_plan:)[\s\S]*?^plan_cursor:.*$/m, 'PLAN_BLOCKS');
assert.equal(outside(state), outside(before), 'State outside the plan blocks changed');

// Git facts about the merge (read from the fetched refs; no network call).
const parents = git('rev-list', '--parents', '-n', '1', MERGE).trim().split(' ');
assert.deepEqual(parents, [MERGE, BASE, HEAD], 'Merge parents');
assert.equal(git('rev-parse', MERGE + '^{tree}').trim(), TREE, 'Merge tree');
assert.equal(git('rev-parse', HEAD + '^{tree}').trim(), TREE, 'PR head tree');
for (const commit of COMMITS) git('merge-base', '--is-ancestor', commit, MERGE);
git('merge-base', '--is-ancestor', MERGE, 'HEAD');
assert.equal(git('rev-parse', 'refs/remotes/origin/codex/b06-stonehook-foot-expedition').trim(), HEAD, 'Feature branch must stay at the reviewed PR head');

// Documentation-only scope.
const allowed = new Set([...records, '.atena/state/plan.yaml']);
const changed = git('diff', '--name-only', MERGE, '--').trim().split('\n').filter(Boolean);
const untracked = git('ls-files', '--others', '--exclude-standard').trim().split('\n').filter(Boolean);
for (const file of [...changed, ...untracked]) assert(allowed.has(file) || file.startsWith(validatorDir + '/'), 'Out-of-scope change ' + file);
assert.equal(git('diff', '--name-only', MERGE, '--', 'main.gd', 'wagon_inventory_ui.gd', 'main.gd.uid', 'wagon_inventory_ui.gd.uid', 'main.tscn', 'project.godot', 'assets', 'README.md', 'AGENTS.md', '.atena/add.yaml', '.atena/vault', '.atena/generated/2026-10-04-b06-validation', '.atena/generated/2026-10-04-b06-preparation', '.atena/generated/2026-10-04-b05-combat-validation', '.atena/generated/2026-10-04-b05-geometry-validation', '.atena/generated/2026-10-04-b05-local-controls-validation', '.atena/generated/2026-10-04-enemy-facing-validation', '.atena/generated/2026-10-04-playtester-validation').trim(), '', 'Gameplay, assets, canon, historical tests, saved engine results or validators changed');
git('-c', 'core.whitespace=-blank-at-eof', 'diff', '--check', MERGE, '--');
console.log('B06_CLOSURE_PASS: ' + links + ' resolved links, ' + STATUS + ' across four records and plan state, B-06 as latest completed plan, previous latest moved unchanged to history (' + count(histNew) + ' entries, older entries byte-identical), active_plan null with cursor complete, merge e304bad parents/tree/ancestry and feature branch verified, documentation-only scope.');
console.log('No engine run, saved engine result, CI claim or B-07 work is represented by this validator.');
