// Scoped B07 acceptance/closure validator. Does not change historical checkpoint validators.
const fs = require('node:fs');
const assert = require('node:assert/strict');
const cp = require('node:child_process');
const path = require('node:path');
const git = (...args) => cp.execFileSync('git', ['-c', 'core.safecrlf=false', ...args], {encoding: 'utf8'}).replace(/\r\n/g, '\n');
const implementation = '4da953cd34469b8024eb2d3831ba7c8ae06cb34a';
const statePath = '.atena/state/plan.yaml';
const old = git('show', implementation + ':' + statePath);
const state = fs.readFileSync(statePath, 'utf8').replace(/\r\n/g, '\n');
const closed = process.argv.includes('--closed');
const status = closed ? 'complete-implementation-merged' : 'implemented-published-human-accepted-awaiting-merge';
const docs = ['.atena/specs/2026-10-05-b07-stonehook-first-encounter.md', '.atena/evidence/2026-10-05-b07-stonehook-first-encounter.md', '.atena/evidence/2026-10-05-b07-stonehook-first-encounter-implementation.md', '.atena/generated/opus-handoff/2026-10-05-b07-stonehook-first-encounter-instruction.md'];
const ids = new Set();
(function walk(p) { for (const e of fs.readdirSync(p, {withFileTypes:true})) { const f = path.join(p,e.name); if (e.isDirectory()) walk(f); else if(e.name.endsWith('.md')) ids.add(e.name.slice(0,-3)); } })('.atena');
let links = 0;
for (const p of [...docs, '.atena/evidence/2026-10-05-b07-windows-review.md']) {
  const s = fs.readFileSync(p,'utf8');
  if (docs.includes(p)) assert(s.startsWith('---\nstatus: ' + status) || s.startsWith('---\r\nstatus: ' + status));
  assert(s.includes('human_acceptance: accepted'));
  for(const m of s.matchAll(/\[\[([^\]]+)\]\]/g)) { assert(ids.has(m[1]),'Unresolved link '+m[1]); links++; }
  assert(!/^(<<<<<<<|=======|>>>>>>>)/m.test(s));
}
assert(state.charCodeAt(0) === old.charCodeAt(0), 'BOM changed');
assert(!/\t/.test(state), 'YAML indentation tabs');
if (!closed) {
  const strip = s => s.replace(/^active_plan:\n[\s\S]*?^plan_cursor:.*$/m,'ACTIVE');
  assert.equal(strip(state),strip(old),'Unrelated state or completed history changed');
  assert(state.includes('plan_cursor: B-07-human-accepted-authorized-pr-and-merge'));
} else {
  assert(state.includes('active_plan: null\nplan_cursor: complete'));
  const oldLast = old.match(/^last_completed_plan:\n([\s\S]*?)\ncompleted_plan_history:/m)[1];
  const oldHistory = old.match(/^completed_plan_history:\n([\s\S]*?)^active_plan:/m)[1];
  const history = state.match(/^completed_plan_history:\n([\s\S]*?)^active_plan:/m)[1];
  assert.equal(history, oldLast.split('\n').map((line,i)=> i===0?'  - '+line.trimStart():line?'  '+line:'').join('\n')+'\n'+oldHistory, 'Prior last plan/history changed');
  assert(state.includes('last_completed_plan:\n  id: "2026-10-05-b07-stonehook-first-encounter"'));
  const merge = state.match(/^  merge_commit: "([a-f0-9]{40})"$/m)?.[1];
  const head = state.match(/^  pull_request_head: "([a-f0-9]{40})"$/m)?.[1];
  assert(merge && head,'Missing merge/head');
  const parents = git('show','-s','--format=%P',merge).trim().split(' ');
  assert.equal(parents[0], 'fcc98b63e1919c54b6df563c8de0c7173a7affcb');
  assert.equal(parents[1], head);
  git('merge-base','--is-ancestor',implementation,merge);
  assert.equal(git('rev-parse',merge+'^{tree}').trim(),git('rev-parse',head+'^{tree}').trim());
  assert.equal(git('rev-parse','origin/codex/b07-stonehook-first-encounter').trim(),head);
}
for (const p of ['add.yaml','vault/canon','vault/drafts','vault/research','specs','evidence','generated','state/plan.yaml']) assert(fs.existsSync('.atena/'+p));
assert.equal(git('diff','--name-only',implementation,'--','main.gd','wagon_inventory_ui.gd','assets','project.godot','main.tscn','.atena/vault').trim(),'','Production or canon changed');
const allowed = new Set([...docs, statePath, '.atena/evidence/2026-10-05-b07-windows-review.md', '.atena/generated/2026-10-05-b07-integration/validate_records.cjs']);
const changed = [...git('diff','--name-only',implementation,'--').trim().split('\n'),...git('ls-files','--others','--exclude-standard').trim().split('\n')].filter(Boolean);
for(const p of changed) assert(allowed.has(p),'Out of scope '+p);
console.log('B07_INTEGRATION_RECORDS_PASS: '+(closed?'closed':'accepted')+', '+links+' resolved links, preserved history and production, scoped records.');
