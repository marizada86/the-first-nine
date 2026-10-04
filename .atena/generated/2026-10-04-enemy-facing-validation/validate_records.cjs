// Scoped ADD checks for the local enemy-facing plan; not a general YAML parser.
const fs=require('node:fs'),path=require('node:path'),assert=require('node:assert/strict');
const {execFileSync}=require('node:child_process');
const baseline='39cd7d3d46a8afb3894889920e0840cbae573e7b';
const git=(...args)=>execFileSync('git',args,{encoding:'utf8'}).replace(/\r\n/g,'\n');
const normalize=text=>text.replace(/^\uFEFF/,'').replace(/\r\n/g,'\n').trimEnd();
for(const name of ['add.yaml','state/plan.yaml','vault/canon','vault/drafts','vault/research','specs','evidence','generated'])assert(fs.existsSync('.atena/'+name));
const ids=new Set();
function walk(dir){for(const entry of fs.readdirSync(dir,{withFileTypes:true})){const file=path.join(dir,entry.name);if(entry.isDirectory())walk(file);else if(entry.name.endsWith('.md'))ids.add(entry.name.slice(0,-3));}}
walk('.atena');
let links=0;
const paths=['.atena/specs/2026-10-04-enemy-facing-correction.md','.atena/evidence/2026-10-04-enemy-facing-correction.md'];
for(const file of paths){
  const text=fs.readFileSync(file,'utf8');
  assert(text.includes('status: implemented-human-validated-awaiting-publication-authorization'));
  assert(text.includes('human_validation_accepted: true'));
  assert(text.includes('implementation_commit: e7812e6ac969e899292a6c0c4845769ccaba2404'));
  assert(text.includes('implementation_approved: true'));
  assert(text.includes('approval_mode: per-plan'));
  assert(!/^(<<<<<<<|=======|>>>>>>>)/m.test(text));
  for(const match of text.matchAll(/\[\[([^\]]+)\]\]/g)){assert(ids.has(match[1]),'Unresolved link '+match[1]);links++;}
}
const state=normalize(fs.readFileSync('.atena/state/plan.yaml','utf8'));
const before=normalize(git('show',baseline+':.atena/state/plan.yaml'));
const active=state.split(/^active_plan:\n/m)[1].split(/^plan_cursor:/m)[0];
assert(active.includes('status: implemented-human-validated-awaiting-publication-authorization'));
assert(active.includes('approval_mode: per-plan'));
assert(active.includes('request_execution_classification: IN_PLAN'));
assert(active.includes('human_validation_accepted: true'));
assert(active.includes('implementation_commit: "e7812e6ac969e899292a6c0c4845769ccaba2404"'));
assert(active.includes('checkpoint: accepted-local-fix-awaiting-publication-authorization'));
git('merge-base','--is-ancestor','e7812e6ac969e899292a6c0c4845769ccaba2404','HEAD');
assert.equal(git('diff','--name-only','e7812e6ac969e899292a6c0c4845769ccaba2404','--','main.gd','assets','project.godot','wagon_inventory_ui.gd').trim(),'','Acceptance reconciliation must not change the game');
for(const gate of ['push_approved: false','pull_request_approved: false','merge_approved: false'])assert(active.includes(gate));
assert.equal(state.replace(/^active_plan:\n[\s\S]*?^plan_cursor:.*$/m,'active_plan: null\nplan_cursor: complete'),before,'Completed history/unrelated state changed');
assert(!/\t/.test(state));
for(const match of active.matchAll(/\[\[([^\]]+)\]\]/g)){assert(ids.has(match[1]));links++;}
const changed=git('diff','--name-only',baseline,'--').trim().split('\n').filter(Boolean);
const allowed=new Set(['main.gd','.atena/state/plan.yaml',...paths]);
assert(changed.every(file=>allowed.has(file)||file.startsWith('.atena/generated/2026-10-04-enemy-facing-validation/')),'Out-of-scope change');
const source=fs.readFileSync('main.gd','utf8').replace(/\r\n/g,'\n');
const previous=git('show',baseline+':main.gd');
function body(text,name){const start=text.indexOf('func '+name+'(');assert(start>=0);const next=text.indexOf('\nfunc ',start+1);return text.slice(start,next<0?text.length:next).trimEnd();}
for(const name of ['enemy_visual_size','enemy_source_cell','enemy_sprite_frame','enemy_draw_geometry','melee_reach','attack_profile','prepare_enemy_frame_bounds','enemy_frame_bounds'])assert.equal(body(source,name),body(previous,name),'Unapproved geometry/combat rule change: '+name);
const dir=__dirname;
for(const name of ['facing-headless','facing-normal','geometry','combat','menus','self-test','normal-smoke','headless-smoke','negative-no_update','negative-no_mirror','negative-leaked_transform']){
  const result=JSON.parse(fs.readFileSync(path.join(dir,name+'-result.json'),'utf8'));
  assert(result.passed && !result.diagnostics && result.error===null,'Failed process '+name);
  assert.equal(result.exit_code,name.startsWith('negative-')?1:0);
  const log=fs.readFileSync(path.join(dir,name+'.log'),'utf8');
  assert(!/SCRIPT ERROR:|ERROR:|WARNING:/.test(log),'Diagnostic in final '+name);
}
const normal=JSON.parse(fs.readFileSync(path.join(dir,'facing-normal-metrics.json'),'utf8'));
const headless=JSON.parse(fs.readFileSync(path.join(dir,'facing-headless-metrics.json'),'utf8'));
assert(normal.checks===102&&normal.failures===0&&headless.checks===65&&headless.failures===0);
assert(normal.raster_metrics.length===12&&normal.raster_metrics.every(row=>row.mirror_error<0.012&&row.unmirrored_error>0.01));
assert(fs.readFileSync(path.join(dir,'facing-normal.log'),'utf8').includes('sprite_changes=87911 outside=0'));
const geometry=JSON.parse(fs.readFileSync(path.join(dir,'regressions/geometry-metrics.json'),'utf8'));
assert(geometry.checks===46&&geometry.failures===0&&geometry.startup_cells===22&&geometry.gameplay_added_scans===0);
assert(fs.readFileSync(path.join(dir,'combat.log'),'utf8').includes('B05_RUNTIME_PASS: 0 failures'));
assert.equal((fs.readFileSync(path.join(dir,'combat.log'),'utf8').match(/^RUNTIME PASS/gm)||[]).length,9);
assert(fs.readFileSync(path.join(dir,'menus.log'),'utf8').includes('LOCAL_CONTROLS_PASS: 33/33'));
for(const name of ['overview-left.png','overview-right.png'])assert(fs.existsSync(path.join(dir,name)));
git('-c','core.whitespace=-blank-at-eof','diff','--check',baseline,'--');
console.log('FACING_RECORDS_PASS: '+links+' links, ADD contract, per-plan approval/review gate, exact B-05 completed history, scope and unchanged combat/geometry functions.');
console.log('FACING_RESULTS_PASS: 65/65 headless, 102/102 rendered, 3 rejected faults, geometry 46/46, combat 9/9, menus 33/33, self-tests and two smoke runs.');
console.log('YAML structural checks only; no full parser/dependency installed. Native Godot log final blank lines retained.');
