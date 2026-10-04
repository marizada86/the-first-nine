// Godot-owned local evidence; no packaged capture adapter or GPU profiling.
const {spawnSync} = require('node:child_process');
const fs = require('node:fs');
const path = require('node:path');
const out = __dirname;
fs.mkdirSync(path.join(out, 'regressions'), {recursive:true});
const facingScript = 'res://.atena/generated/2026-10-04-enemy-facing-validation/validate_facing.gd';
const cases = {
  'facing-headless': ['--headless', '--script', facingScript],
  'facing-normal': ['--rendering-method', 'gl_compatibility', '--script', facingScript],
  'geometry': ['--rendering-method','gl_compatibility','--script','res://.atena/generated/2026-10-04-enemy-facing-validation/geometry_regression.gd'],
  'combat': ['--rendering-method','gl_compatibility','--script','res://.atena/generated/2026-10-04-b05-combat-validation/validate_b05_combat.gd'],
  'menus': ['--rendering-method','gl_compatibility','--script','res://.atena/generated/2026-10-04-b05-local-controls-validation/validate_controls_and_menus.gd'],
  'self-test': ['--headless','--','--self-test'],
  'normal-smoke': ['--rendering-method','gl_compatibility','--resolution','1280x720','--quit-after','600'],
  'headless-smoke': ['--headless','--quit-after','600'],
};
let failed = false;
for (const name of process.argv.slice(2)) {
  const negative = name.startsWith('negative-');
  const fault = negative ? name.slice(9) : '';
  if (!negative && !cases[name]) throw new Error('Unknown case: ' + name);
  if (negative && !['no_update','no_mirror','leaked_transform'].includes(fault)) throw new Error('Unknown fault: ' + fault);
  const args = negative ? cases['facing-normal'] : cases[name];
  const result = spawnSync('D:/Godot/godot.exe', ['--path',process.cwd(),'--log-file',path.join(out,name+'.log'),...args],{
    encoding:'utf8',timeout:60000,windowsHide:true,
    env:{...process.env, OUT:path.join(out,'regressions'), FACING_FAULT:fault}
  });
  const output=(result.stdout||'')+(result.stderr||'');
  const diagnostics = /SCRIPT ERROR:|ERROR:|WARNING:/.test(output);
  const detections=output.split(/\r?\n/).filter(line=>line.startsWith('FACING FAIL'));
  const passed=negative ? result.status===1 && detections.length>0 && output.includes('FACING_FAIL:') && !diagnostics : result.status===0 && !diagnostics && !/FACING FAIL|GEOMETRY FAIL|LOCAL FAIL|RUNTIME FAIL/.test(output);
  fs.writeFileSync(path.join(out,name+'-result.json'),JSON.stringify({name,exit_code:result.status,passed,diagnostics,detections,error:result.error?.message||null},null,2)+'\n');
  console.log(output);
  console.log('GODOT_PROCESS '+(passed?'PASS':'FAIL')+' '+name+': exit='+result.status);
  failed ||= !passed;
}
process.exitCode=failed?1:0;
