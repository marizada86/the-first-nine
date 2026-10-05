// Owner-approval checkpoint checks; no gameplay or publication performed.
const fs = require('node:fs');
const path = require('node:path');
const crypto = require('node:crypto');
const assert = require('node:assert/strict');
const {execFileSync} = require('node:child_process');
const BASE = 'e189184e1928efca8172ce4a9c65996be81c206a';
const STATUS = 'approved-awaiting-document-delivery';
const git = (...args) => execFileSync('git', args, {encoding:'utf8'}).trim();
const read = p => fs.readFileSync(p, 'utf8');
const normalize = s => s.replace(/\r\n/g, '\n');
function fields(text) {
  const result = {};
  for (const line of normalize(text).trimEnd().split('\n')) {
    const m = line.match(/^\s*([a-z_]+): (.+)$/);
    assert(m, 'Unexpected scoped-record syntax: '+line);
    assert(!Object.hasOwn(result,m[1]), 'Duplicate field: '+m[1]);
    const v = m[2];
    result[m[1]] = v.startsWith('"') || v.startsWith('[') || ['true','false'].includes(v) ? JSON.parse(v) : v;
  }
  return result;
}
assert.equal(git('rev-parse','HEAD'),BASE);
assert.equal(git('branch','--show-current'),'main');
assert.equal(git('diff','--name-only'),'.atena/state/plan.yaml');
assert.equal(git('diff','--cached','--name-only'),'');
const state = read('.atena/state/plan.yaml');
const before = execFileSync('git',['show',BASE+':.atena/state/plan.yaml'],{encoding:'utf8'});
assert(normalize(state.split('active_plan:')[0]) === normalize(before.split('active_plan:')[0]), 'Completed history changed');
assert(normalize(state.split('last_direct_execution:')[1]) === normalize(before.split('last_direct_execution:')[1]), 'Unrelated state changed');
assert.equal(state.startsWith('\uFEFF'),before.startsWith('\uFEFF'),'BOM changed');
const activeText = normalize(state).split('active_plan:\n')[1].split('plan_cursor:')[0];
const active = fields(activeText);
assert.equal(active.id,'2026-10-05-b07-stonehook-first-encounter');
assert.equal(active.request_execution_classification,'IN_PLAN');
assert.equal(active.approval_selection,'owner-selected-option-1');
assert.equal(active.checkpoint,'awaiting-document-publication-authorization');
assert.equal(active.delivery_verified,false);
assert.deepEqual(active.steps_completed,[]);
assert.deepEqual(active.batches_completed,[]);
assert.deepEqual(active.blocking_gaps,[]);
assert(normalize(state).includes('plan_cursor: B-07-approved-awaiting-document-delivery\n'));
const docs = [
  '.atena/specs/2026-10-05-b07-stonehook-first-encounter.md',
  '.atena/evidence/2026-10-05-b07-stonehook-first-encounter.md',
  '.atena/generated/opus-handoff/2026-10-05-b07-stonehook-first-encounter-instruction.md'
];
const approved = [active, ...docs.map(p=>fields(normalize(read(p)).split('---\n')[1]))];
for (const f of approved) {
  assert.equal(f.status,STATUS); assert.equal(f.approval_mode,'per-plan');
  assert.equal(f.approved,'2026-10-05'); assert.equal(f.implementation_approved,true);
  assert.equal(f.documentation_publication_approved,false); assert.equal(f.documentation_published,false);
}
for (const f of [active,approved[1],approved[3]]) for(const key of ['push_approved','pull_request_approved','merge_approved','dispatch_approved']) assert.equal(f[key],false);
const all = [];
function walk(dir) {for (const e of fs.readdirSync(dir,{withFileTypes:true})) {const p=path.join(dir,e.name); if(e.isDirectory()) walk(p); else if(e.name.endsWith('.md')) all.push(p);}}
walk('.atena');
let links = 0;
for(const text of [activeText, ...docs.map(read), read('.atena/evidence/2026-10-05-b06-integrated-human-acceptance.md')]) {
  for(const m of text.matchAll(/\[\[([^\]]+)\]\]/g)) {assert(all.some(p=>path.basename(p,'.md')===m[1]), 'Missing link: '+m[1]); links++;}
}
for(const p of ['add.yaml','vault/canon','vault/drafts','vault/research','specs','evidence','generated','state/plan.yaml']) assert(fs.existsSync(path.join('.atena',p)),'Missing contract path: '+p);
const earlier = JSON.parse(read('.atena/generated/2026-10-05-b06-local-sync/before.json'));
for(const f of earlier.files) assert.equal(crypto.createHash('sha256').update(fs.readFileSync(f.path)).digest('hex'),f.sha256,'Local evidence changed: '+f.path);
git('diff','--check');
console.log('B07_APPROVAL_PASS: '+links+' links; per-plan approval consistent across four records, disabled publication gates and zero executed steps; completed history/unrelated state preserved after line-ending normalization, BOM kept; '+earlier.files.length+' prior local files byte-identical; no staged/production edits. Scoped syntax checks only; no full YAML-parser or engine result.');
