// Review-only diagnostic, with separate output. Does not overwrite official combat results.
const fs = require('node:fs');
const path = require('node:path');
const {spawnSync} = require('node:child_process');
const project = process.cwd();
const out = path.join(project,'.atena/generated/2026-10-04-b06-validation/diagnostic-combat-filter');
fs.mkdirSync(out,{recursive:true});
const result = spawnSync('D:/Godot/godot.exe',['--path',project,'--rendering-method','gl_compatibility','--resolution','1280x720','--script','res://.atena/generated/2026-10-04-b06-validation/combat_motion_isolation_probe.gd','--log-file',path.join(out,'diagnostic.log')],{encoding:'utf8',windowsHide:true,timeout:240000,env:{...process.env,OUT:out}});
const output = (result.stdout||'')+(result.stderr||'');
const checks = (output.match(/^RUNTIME PASS /gm)||[]).length;
const passed = result.status===0 && checks===9 && !/RUNTIME FAIL|SCRIPT ERROR|ERROR:|WARNING:/.test(output);
fs.writeFileSync(path.join(out,'diagnostic-result.json'),JSON.stringify({kind:'review-diagnostic-not-official-acceptance',exit_code:result.status,passed,checks,error:result.error?.message||null,signal:result.signal,os:process.platform},null,2)+'\n');
console.log(output);
console.log('COMBAT_ISOLATION_DIAGNOSTIC '+(passed?'PASS':'FAIL'));
process.exitCode=passed?0:1;
