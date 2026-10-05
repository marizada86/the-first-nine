const fs=require('fs'),path=require('path'),crypto=require('crypto');
const root=path.resolve(__dirname,'../../..');
const packageRoot=__dirname;
const read=p=>JSON.parse(fs.readFileSync(path.join(packageRoot,p),'utf8'));
const text=p=>fs.readFileSync(path.resolve(root,p),'utf8');
const sha=p=>crypto.createHash('sha256').update(fs.readFileSync(path.resolve(root,p))).digest('hex');
const check=(v,k)=>{if(!v)throw Error(k);};
const normalize=s=>s.replace(/\r\n/g,'\n').replace(/\r/g,'\n');
const baseline=read('art-closure-baseline-v1.json'),acceptance=read('package-acceptance-v1.json');
const technical=read('package-technical-v2.json'),selection=read('package-selection-v2.json');
const rawState=text('.atena/state/plan.yaml'),state=normalize(rawState),before=normalize(baseline.state_before);
function section(s,key){
 const start=s.indexOf(key+':');check(start>=0,'missing-section-'+key);
 const rest=s.slice(start);const next=rest.slice(key.length+1).search(/\n[a-z_]+:/);
 return next<0?rest:rest.slice(0,key.length+1+next+1);
}
function validateAcceptance(a){
 check(a.status==='complete-art-human-accepted'&&a.accepted_targets===30&&a.items.length===30,'acceptance-count');
 check(new Set(a.items.map(x=>x.id)).size===30,'acceptance-identities');
 check(a.newly_accepted_targets===25&&a.previously_accepted_targets===5,'acceptance-history');
 check(a.runtime_admission_approved===false&&a.gameplay_implementation_approved===false&&a.b08_acceptance_inferred===false&&a.push_approved===false&&a.merge_approved===false,'authority-boundaries');
 for(const item of a.items){
  const s=selection.items.find(x=>x.id===item.id),t=technical.items.find(x=>x.id===item.id);
  check(s&&t&&s.attempt===item.attempt&&s.source===item.source,'accepted-selection');
  check(item.owner_accepted===true&&item.runtime_admitted===false,'accepted-only-offline');
  check(item.master_sha256===t.master_sha256&&item.review_sha256===t.review_sha256&&item.raw_sha256===t.raw_sha256,'accepted-hashes');
  check(sha(item.master)===item.master_sha256&&sha(item.review)===item.review_sha256&&sha(item.source)===item.raw_sha256,'unchanged-images');
 }
}
validateAcceptance(acceptance);
check(rawState.charCodeAt(0)===0xfeff,'state-bom');
check(section(state,'active_plan').trim()==='active_plan: null','cleared-active-slot');
check(section(state,'plan_cursor').trim()==='plan_cursor: complete','complete-cursor');
const last=section(state,'last_completed_plan');
for(const line of [
 'id: "2026-10-05-b09-opening-art-production"',
 'status: complete-art-human-accepted','checkpoint: complete','human_accepted_targets: 30','human_review_pending_targets: 0',
 'completion_scope: offline-art-only','runtime_admission_approved: false','gameplay_implementation_approved: false','push_approved: false','merge_approved: false'
])check(last.includes(line),'closed-plan-'+line);
const prior=section(before,'last_completed_plan').slice('last_completed_plan:\n'.length).trimEnd();
const moved=prior.split('\n').map((l,i)=>i===0?l.replace(/^  /,'  - '):l.length?'  '+l:l).join('\n');
const history=section(state,'completed_plan_history'),oldHistory=section(before,'completed_plan_history');
const expectedHistory='completed_plan_history:\n'+moved+'\n'+oldHistory.slice('completed_plan_history:\n'.length);
check(history.trimEnd()===expectedHistory.trimEnd(),'completed-history-preserved');
const historyCount=(s)=>(s.match(/^  - id:/gm)||[]).length;
check(historyCount(history)===historyCount(oldHistory)+1,'history-count');
for(const key of ['last_direct_execution','suspension','deferred_requests','approved_change_requests'])check(section(state,key).trimEnd()===section(before,key).trimEnd(),'unrelated-state-'+key);
check(section(state,'pending_plan_change_requests').trimEnd()===section(before,'pending_plan_change_requests').replace('production_status: produced-validated-awaiting-remaining-human-review','production_status: complete-art-human-accepted').replace('production_checkpoint: owner-art-review','production_checkpoint: complete').trimEnd(),'pending-request-scope');
const productionHashes={};
for(const line of baseline.production_hashes_before.trim().split('\n')){
 const [file,hash]=line.trim().split(' ');check(sha(file)===hash,'production-preserved-'+file);productionHashes[file]=hash;
}
for(const file of [
 '.atena/specs/2026-10-05-b09-opening-art-production.md','.atena/evidence/2026-10-05-b09-opening-art-production.md','.atena/vault/canon/2026-10-05-b09-opening-art-production-approval.md'
])check(text(file).startsWith('---\nstatus: complete-art-human-accepted')||text(file).startsWith('---\r\nstatus: complete-art-human-accepted'),'closed-record-status');
const gameplay=text('.atena/specs/2026-10-05-b09-opening-cave-care-and-continuous-journey.md').split(/\r?\n---/)[0];
check(gameplay.includes('approval_mode: unconfigured')&&gameplay.includes('implementation_approved: false'),'b09-still-unapproved');
const b08=JSON.parse(text('.atena/generated/2026-10-05-b08-windows-review/windows-review-receipt.json'));
check(b08.status==='technical-review-passed-awaiting-owner-playtest','b08-not-auto-accepted');
const negative=[];
for(const [name,mutate,expected] of [
 ['unauthorized-runtime-admission',a=>a.runtime_admission_approved=true,'authority-boundaries'],
 ['missing-accepted-target',a=>a.items.pop(),'acceptance-count'],
 ['changed-accepted-hash',a=>a.items[0].master_sha256='0'.repeat(64),'accepted-hashes']
]){
 const altered=structuredClone(acceptance);mutate(altered);let rejected;
 try{validateAcceptance(altered);}catch(e){rejected=e.message;}
 check(rejected===expected,'negative-control-'+name);negative.push({name,rejected_on:rejected});
}
process.stdout.write(JSON.stringify({
 status:'PASS',accepted_targets:30,newly_accepted_targets:25,previously_accepted_targets:5,
 accepted_image_hashes_preserved:true,history_entries_before:historyCount(oldHistory),history_entries_after:historyCount(history),
 preceding_completed_plan_moved_unchanged:true,earlier_history_preserved:true,unrelated_state_preserved:true,state_bom_preserved:true,
 production_hashes_preserved:productionHashes,negative_controls:negative,
 active_plan:null,plan_cursor:'complete',runtime_admitted:false,gameplay_implementation_approved:false,
 b08_owner_acceptance_pending:true,new_engine_run:false,new_remote_verification:false,yaml_parser_validation:false,
 comparison:'Scoped state text comparison normalizes universal CR/LF line endings; no semantic YAML-parser claim.'
}));
