// B-06 approval/delivery checkpoint checks only. No Godot execution or whole-file YAML parsing.
const fs=require('node:fs'),path=require('node:path'),assert=require('node:assert/strict');
const {execFileSync}=require('node:child_process');
const baseline='2f34635ff5adf735e51a7c144862e7c1bba37bed';
const git=(...args)=>execFileSync('git',args,{encoding:'utf8'}).replace(/\r\n/g,'\n');
const normalize=text=>text.replace(/^\uFEFF/,'').replace(/\r\n/g,'\n').trimEnd();
const spec='.atena/specs/2026-10-04-b06-stonehook-foot-expedition.md';
const evidence='.atena/evidence/2026-10-04-b06-stonehook-foot-expedition.md';
const instruction='.atena/generated/opus-handoff/2026-10-04-b06-stonehook-foot-expedition-instruction.md';
const validator='.atena/generated/2026-10-04-b06-preparation/validate_records.cjs';
const allowed=new Set([spec,evidence,instruction,validator,'.atena/state/plan.yaml']);
for(const entry of ['add.yaml','state/plan.yaml','vault/canon','vault/drafts','vault/research','specs','evidence','generated'])assert(fs.existsSync('.atena/'+entry));
const ids=new Set();
function walk(dir){for(const entry of fs.readdirSync(dir,{withFileTypes:true})){const file=path.join(dir,entry.name);if(entry.isDirectory())walk(file);else if(entry.name.endsWith('.md'))ids.add(entry.name.slice(0,-3));}}
walk('.atena');
let links=0;
for(const file of [spec,evidence,instruction]){
  const text=fs.readFileSync(file,'utf8');
  assert(text.includes('status: approved-awaiting-external-execution'));
  assert(text.includes('approval_mode: per-plan'));
  assert(text.includes('approved: 2026-10-04'));
  assert(text.includes('approval_source: owner-selected-1-to-approve-the-presented-B06-implementation-scope'));
  assert(text.includes('implementation_approved: true'));
  assert(text.includes('execution_target: opus-5.5'));
  assert(text.includes('documentation_publication_approved: true')&&text.includes('documentation_published: true'));
  assert(text.includes('delivery_commit: 77ee387d5649a131ae20c5910b2dc7421c76f22f'));
  assert(text.includes('push_approved: false')&&text.includes('dispatch_approved: false'));
  assert(!/^(<<<<<<<|=======|>>>>>>>)/m.test(text));
  for(const match of text.matchAll(/\[\[([^\]]+)\]\]/g)){assert(ids.has(match[1]),'Unresolved link '+match[1]);links++;}
}
const specText=fs.readFileSync(spec,'utf8');
assert(specText.includes('origin: planned')&&specText.includes('implementation_preceded_spec: false'));
assert(specText.includes('BLOCKING design gaps: none'));
for(const id of ['S-001','S-002','S-003','S-004','B-001','B-002','B-003'])assert(specText.includes(id));
const state=normalize(fs.readFileSync('.atena/state/plan.yaml','utf8'));
const before=normalize(git('show',baseline+':.atena/state/plan.yaml'));
const active=state.match(/^active_plan:\n([\s\S]*?)^plan_cursor:/m)[1];
for(const fact of ['id: "2026-10-04-b06-stonehook-foot-expedition"','status: approved-awaiting-external-execution','approval_mode: per-plan','approval_selection: owner-selected-option-1','approved: "2026-10-04"','request_execution_classification: IN_PLAN','implementation_approved: true','execution_target: opus-5.5','steps_completed: []','push_approved: false','pull_request_approved: false','merge_approved: false','dispatch_approved: false','blocking_gaps: []','checkpoint: external-execution-ready-after-checkout-verification','preparation_commit: "0a82ead8384969a11399f20ef3dcf3828734df27"','documentation_publication_approved: true','documentation_published: true','documentation_publication_branch: main','delivery_commit: "77ee387d5649a131ae20c5910b2dc7421c76f22f"','delivery_verified: true'])assert(active.includes(fact),'Missing gate '+fact);
assert(/^  approval_source: "Owner selected 1 /m.test(active),'Missing explicit owner approval provenance');
assert(state.includes('plan_cursor: B-06-approved-awaiting-external-execution'));
assert.equal(state.replace(/^active_plan:\n[\s\S]*?^plan_cursor:.*$/m,'active_plan: null\nplan_cursor: complete'),before,'Completed plan/history or unrelated state changed');
assert(!/\t/.test(state));
for(const match of active.matchAll(/\[\[([^\]]+)\]\]/g)){assert(ids.has(match[1]));links++;}
assert.equal(git('diff','--name-only',baseline,'--','main.gd','wagon_inventory_ui.gd','project.godot','main.tscn','assets','.atena/vault/canon').trim(),'','Preparation changed runtime, assets, settings or canon');
for(const file of git('diff','--name-only',baseline,'--').trim().split('\n').filter(Boolean))assert(allowed.has(file),'Out-of-scope tracked change '+file);
for(const line of git('status','--porcelain').split('\n').filter(Boolean)){
  const file=line.slice(3).replace(/\\/g,'/');
  assert(allowed.has(file)||file==='.atena/generated/2026-10-04-b06-preparation/','Out-of-scope worktree change '+file);
}
git('-c','core.whitespace=-blank-at-eof','diff','--check',baseline,'--');
git('merge-base','--is-ancestor','77ee387d5649a131ae20c5910b2dc7421c76f22f','origin/main');
console.log('B06_DELIVERY_PASS: '+links+' links, ADD contract, explicit per-plan approval, authorized documentation delivery, separate implementation publication gates, exact completed state/history and scoped documentation preserved.');
console.log('No B-06 implementation, new engine results, implementation publication, external dispatch or full YAML parser claim.');
