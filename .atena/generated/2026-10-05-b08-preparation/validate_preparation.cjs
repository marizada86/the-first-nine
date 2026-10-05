// Future proposal preparation only. No engine execution or remote access.
const fs = require('node:fs');
const path = require('node:path');
const crypto = require('node:crypto');
const assert = require('node:assert/strict');
const {execFileSync} = require('node:child_process');
const BASE = 'fcc98b63e1919c54b6df563c8de0c7173a7affcb';
const git = (...args) => execFileSync('git',args,{encoding:'utf8'}).trim();
const read = p => fs.readFileSync(p,'utf8');
const norm = s => s.replace(/\r\n/g,'\n');
const state = norm(read('.atena/state/plan.yaml'));
const before = norm(execFileSync('git',['show',BASE+':.atena/state/plan.yaml'],{encoding:'utf8'}));
assert.equal(git('rev-parse','HEAD'),BASE);
assert.equal(git('branch','--show-current'),'main');
assert.equal(git('diff','--name-only'),'.atena/state/plan.yaml');
assert.equal(git('diff','--cached','--name-only'),'');
assert.equal(state.replace(/deferred_requests:\n[\s\S]*?\npending_plan_change_requests:/,'deferred_requests: []\npending_plan_change_requests:'),before,'State changed outside the future request');
assert(/^suspension: null$/m.test(state),'Local suspension not cleared');
assert(/^plan_cursor: B-07-approved-awaiting-document-delivery$/m.test(state),'B07 cursor changed');
const active = state.split('active_plan:\n')[1].split('plan_cursor:')[0];
assert.equal(active,before.split('active_plan:\n')[1].split('plan_cursor:')[0],'B07 active block changed');
assert(active.includes('id: "2026-10-05-b07-stonehook-first-encounter"'),'B08 became active');
assert(state.includes('id: DEV-001-b08-preparation'));
const deferred = state.split('deferred_requests:\n')[1].split('pending_plan_change_requests:')[0];
function fields(text) {
  const f = {};
  for(const line of norm(text).trimEnd().split('\n')) {
    const m = line.match(/^\s*(?:- )?([a-z_]+): (.+)$/); assert(m,'Unexpected scoped syntax: '+line);
    assert(!Object.hasOwn(f,m[1]),'Duplicate key: '+m[1]);
    const value=m[2]; f[m[1]]=value.startsWith('"')||value.startsWith('[')||['true','false'].includes(value)?JSON.parse(value):value;
  }
  return f;
}
const future=fields(deferred);
assert.equal(future.status,'proposal-prepared-execution-deferred');
assert.equal(future.preparation_complete,true);
assert.equal(future.active_plan_replaced,false); assert.equal(future.external_executor_interrupted,false);
const docs=[
  '.atena/specs/2026-10-05-b08-stonehook-cliff-harrier.md',
  '.atena/evidence/2026-10-05-b08-stonehook-cliff-harrier.md',
  '.atena/generated/opus-handoff/2026-10-05-b08-stonehook-cliff-harrier-instruction.md'
];
const records=docs.map(p=>fields(norm(read(p)).split('---\n')[1]));
for(const f of [future,...records]) {assert.equal(f.approval_mode,'unconfigured');assert.equal(f.implementation_approved,false);}
for(const f of [future,records[0],records[2]]) for(const key of ['push_approved','pull_request_approved','merge_approved','dispatch_approved']) assert.equal(f[key],false);
assert.equal(records[0].active_plan,false);
assert.equal(records[0].implementation_base,'unresolved-until-b07-merged-and-closed');
assert.equal(records[0].implementation_preceded_spec,false);
assert.equal(records[2].status,'draft-not-dispatched-not-executable');
const all=[];
function walk(dir){for(const e of fs.readdirSync(dir,{withFileTypes:true})){const p=path.join(dir,e.name);if(e.isDirectory())walk(p);else if(e.name.endsWith('.md'))all.push(p);}}
walk('.atena');
let links=0;
for(const text of [deferred,...docs.map(read)]) for(const m of text.matchAll(/\[\[([^\]]+)\]\]/g)){assert(all.some(p=>path.basename(p,'.md')===m[1]),'Missing link: '+m[1]);links++;}
for(const p of ['add.yaml','vault/canon','vault/drafts','vault/research','specs','evidence','generated','state/plan.yaml'])assert(fs.existsSync(path.join('.atena',p)),'ADD contract missing');
const localManifest='.atena/generated/2026-10-05-b06-local-sync/before.json';
let hashes=0;
if(fs.existsSync(localManifest)) {for(const f of JSON.parse(read(localManifest)).files){assert.equal(crypto.createHash('sha256').update(fs.readFileSync(f.path)).digest('hex'),f.sha256,'Earlier evidence changed');hashes++;}}
git('diff','--check');
console.log('B08_PREPARATION_PASS: '+links+' links, inactive/unapproved B08 draft, unresolved B07 base explicit; B07 block/cursor/history and unrelated state unchanged, suspension cleared; '+hashes+' earlier local evidence hashes preserved; no staged/production edits. Scoped syntax checks only, no general YAML-parser or engine result.');
