// Checkpoint-specific preparation checks; no engine run or general YAML parser.
const fs = require('node:fs');
const path = require('node:path');
const crypto = require('node:crypto');
const assert = require('node:assert/strict');
const {execFileSync} = require('node:child_process');
const baseline = 'e189184e1928efca8172ce4a9c65996be81c206a';
const git = (...args) => execFileSync('git', args, {encoding:'utf8'}).trim();
const read = p => fs.readFileSync(p, 'utf8');
const statePath = '.atena/state/plan.yaml';
const state = read(statePath);
const old = execFileSync('git', ['show', baseline + ':' + statePath], {encoding:'utf8'});
assert.equal(git('rev-parse', 'HEAD'), baseline);
assert.equal(git('branch', '--show-current'), 'main');
assert.equal(git('diff', '--name-only'), statePath);
assert.equal(git('diff', '--cached', '--name-only'), '');
// Git blobs use LF; the owner's Windows checkout uses CRLF. Compare content
// without treating that existing checkout conversion as a history modification.
const normalize = s => s.replace(/\r\n/g, '\n');
assert(normalize(state.split('active_plan:')[0]) === normalize(old.split('active_plan:')[0]), 'Completed history changed');
assert(normalize(state.split('last_direct_execution:')[1]) === normalize(old.split('last_direct_execution:')[1]), 'Unrelated state changed');
assert.equal(state.startsWith('\uFEFF'), old.startsWith('\uFEFF'), 'BOM changed');
const active = normalize(state).split('active_plan:\n')[1].split('plan_cursor:')[0];
const fields = {};
for (const line of active.trimEnd().split(/\r?\n/)) {
  const m = line.match(/^  ([a-z_]+): (.+)$/);
  assert(m, 'Unexpected prepared-block syntax: ' + line);
  assert(!Object.hasOwn(fields, m[1]), 'Duplicate key');
  const value = m[2];
  fields[m[1]] = value.startsWith('"') || value.startsWith('[') || ['true','false'].includes(value) ? JSON.parse(value) : value;
}
assert.equal(fields.id, '2026-10-05-b07-stonehook-first-encounter');
assert.equal(fields.status, 'prepared-awaiting-approval-selection');
assert.equal(fields.approval_mode, 'unconfigured');
for (const key of ['implementation_approved','push_approved','pull_request_approved','merge_approved','dispatch_approved']) assert.equal(fields[key], false);
assert.deepEqual(fields.blocking_gaps, []);
assert.equal(fields.steps.length, 3); assert.equal(fields.batches.length, 3);
assert(state.includes('plan_cursor: B-07-prepared-awaiting-approval-selection'));
const docs = [
  '.atena/evidence/2026-10-05-b06-integrated-human-acceptance.md',
  '.atena/specs/2026-10-05-b07-stonehook-first-encounter.md',
  '.atena/evidence/2026-10-05-b07-stonehook-first-encounter.md'
];
const all = [];
function walk(dir) { for (const e of fs.readdirSync(dir,{withFileTypes:true})) {const p=path.join(dir,e.name); if(e.isDirectory()) walk(p); else if(e.name.endsWith('.md')) all.push(p);} }
walk('.atena');
let links = 0;
for (const p of docs) for (const match of read(p).matchAll(/\[\[([^\]]+)\]\]/g)) {assert(all.some(f=>path.basename(f,'.md')===match[1]), 'Unresolved link '+match[1]); links++;}
const contract = ['add.yaml','vault/canon','vault/drafts','vault/research','specs','evidence','generated','state/plan.yaml'];
for (const p of contract) assert(fs.existsSync(path.join('.atena',p)), 'Missing ADD contract '+p);
const previous = JSON.parse(read('.atena/generated/2026-10-05-b06-local-sync/before.json'));
for (const f of previous.files) assert.equal(crypto.createHash('sha256').update(fs.readFileSync(f.path)).digest('hex'), f.sha256, 'Earlier local evidence changed: '+f.path);
git('diff','--check');
console.log('B07_PREPARATION_PASS: '+links+' links resolved; ADD contract present; prepared block syntax and disabled gates checked; completed history/unrelated state preserved after checkout line-ending normalization and BOM kept; '+previous.files.length+' prior local files byte-identical; no production or staged edits. No full YAML-parser or engine result claimed.');
