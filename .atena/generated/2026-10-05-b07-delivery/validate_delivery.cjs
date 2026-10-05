// Documentation delivery checkpoint, not runtime validation or remote proof.
const fs = require('node:fs');
const path = require('node:path');
const assert = require('node:assert/strict');
const {execFileSync} = require('node:child_process');
const BASE = 'e189184e1928efca8172ce4a9c65996be81c206a';
const git = (...args) => execFileSync('git', args, {encoding:'utf8'}).trim();
const read = p => fs.readFileSync(p,'utf8');
const normal = s => s.replace(/\r\n/g,'\n');
const mode = process.argv[2] || 'committed';
assert(['working','staged','committed'].includes(mode),'Unknown checkpoint');
const files = [
  '.atena/evidence/2026-10-05-b06-integrated-human-acceptance.md',
  '.atena/evidence/2026-10-05-b07-stonehook-first-encounter.md',
  '.atena/generated/2026-10-05-b07-approval/validate_approval.cjs',
  '.atena/generated/2026-10-05-b07-delivery/validate_delivery.cjs',
  '.atena/generated/2026-10-05-b07-preparation/validate_preparation.cjs',
  '.atena/generated/opus-handoff/2026-10-05-b07-stonehook-first-encounter-instruction.md',
  '.atena/specs/2026-10-05-b07-stonehook-first-encounter.md',
  '.atena/state/plan.yaml'
].sort();
const lines = s => s ? s.split(/\r?\n/).sort() : [];
if(mode==='committed') {
  assert.equal(git('rev-parse','HEAD^'),BASE,'Unexpected document commit parent');
  assert.deepEqual(lines(git('diff','--name-only','HEAD^','HEAD')),files,'Publication scope mismatch');
  assert.equal(git('diff','--name-only'),'','Tracked working edits');
  assert.equal(git('diff','--cached','--name-only'),'','Staged edits');
} else {
  assert.equal(git('rev-parse','HEAD'),BASE);
  assert.equal(git('branch','--show-current'),'main');
  assert.deepEqual(lines(git('diff','--name-only')),mode==='working'?['.atena/state/plan.yaml']:[]);
  assert.deepEqual(lines(git('diff','--cached','--name-only')),mode==='working'?[]:files);
}
function fields(text) {
  const f = {};
  for(const line of normal(text).trimEnd().split('\n')) {
    const m = line.match(/^\s*([a-z_]+): (.+)$/); assert(m,'Unexpected scoped syntax: '+line);
    assert(!Object.hasOwn(f,m[1]),'Duplicate key');
    const v = m[2]; f[m[1]] = v.startsWith('"') || v.startsWith('[') || ['true','false'].includes(v) ? JSON.parse(v) : v;
  }
  return f;
}
const state = normal(read('.atena/state/plan.yaml'));
const old = normal(execFileSync('git',['show',BASE+':.atena/state/plan.yaml'],{encoding:'utf8'}));
assert(state.split('active_plan:')[0]===old.split('active_plan:')[0],'Completed history changed');
assert(state.split('last_direct_execution:')[1]===old.split('last_direct_execution:')[1],'Unrelated state changed');
const activeText = state.split('active_plan:\n')[1].split('plan_cursor:')[0];
const active = fields(activeText);
assert.equal(active.id,'2026-10-05-b07-stonehook-first-encounter');
assert.equal(active.checkpoint,'awaiting-authorized-document-delivery-verification');
assert.equal(active.delivery_verified,false);
assert.deepEqual(active.steps_completed,[]); assert.deepEqual(active.batches_completed,[]);
assert.deepEqual(active.blocking_gaps,[]);
const docs = files.filter(p=>p.endsWith('.md')&&!p.includes('integrated-human'));
const records = [active,...docs.map(p=>fields(normal(read(p)).split('---\n')[1]))];
for(const r of records) {
  assert.equal(r.status,'approved-awaiting-document-delivery');
  assert.equal(r.approval_mode,'per-plan'); assert.equal(r.implementation_approved,true);
  assert.equal(r.documentation_publication_approved,true);
  assert.equal(r.publication_snapshot,'pre-push'); assert.equal(r.documentation_published,false);
}
for(const r of records.filter(r=>Object.hasOwn(r,'push_approved'))) {
  for(const k of ['push_approved','pull_request_approved','merge_approved','dispatch_approved']) assert.equal(r[k],false);
}
assert(state.includes('plan_cursor: B-07-approved-awaiting-document-delivery\n'));
const markdown = [];
function walk(dir){for(const e of fs.readdirSync(dir,{withFileTypes:true})){const p=path.join(dir,e.name);if(e.isDirectory())walk(p);else if(e.name.endsWith('.md'))markdown.push(p);}}
walk('.atena');
let links=0;
for(const text of [activeText,...files.filter(p=>p.endsWith('.md')).map(read)]) {
  for(const m of text.matchAll(/\[\[([^\]]+)\]\]/g)) {
    // Resolve only against tracked baseline/package files, not unrelated local receipts.
    const candidates=markdown.filter(p=>path.basename(p,'.md')===m[1]);
    assert(candidates.some(p=>files.includes(p.replaceAll('\\','/'))||git('ls-files','--',p)!==''),'Unpublished link: '+m[1]);links++;
  }
}
for(const p of ['add.yaml','vault/canon','vault/drafts','vault/research','specs','evidence','generated','state/plan.yaml'])assert(fs.existsSync(path.join('.atena',p)),'Missing ADD contract path');
git('diff','--check'); git('diff','--cached','--check');
console.log('B07_DELIVERY_RECORDS_PASS: checkpoint='+mode+', 8 package files, '+links+' delivered/baseline links, consistent per-plan and document-only authority; protected history/state preserved, zero implementation steps, no production edits. Scoped record syntax only; remote publication and engine runs are not inferred.');
