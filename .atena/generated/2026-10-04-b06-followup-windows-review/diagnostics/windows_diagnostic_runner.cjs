// Review-only runner. Does not overwrite the published suite's Windows results.
const fs = require('node:fs');
const path = require('node:path');
const {spawnSync, execFileSync} = require('node:child_process');
const project = process.cwd();
const out = path.join(project, 'windows-runtime-early-isolation');
const baseline = path.join(project, '.atena/generated/2026-10-04-b06-validation/baseline/main_7e477ba.gd');
fs.mkdirSync(out, {recursive:true});
fs.mkdirSync(path.dirname(baseline), {recursive:true});
fs.writeFileSync(baseline, execFileSync('git', ['show','7e477ba799ce5b4bf9cb6e9dde44e83c97db0bbc:main.gd'], {encoding:'utf8'}));
const result = spawnSync('D:/Godot/godot.exe', ['--path',project,'--rendering-method','gl_compatibility','--resolution','1280x720','--script','res://.atena/generated/2026-10-04-b06-validation/windows_runtime_early_isolation.gd','--log-file',path.join(out,'diagnostic.log')], {encoding:'utf8',timeout:240000,windowsHide:true,env:{...process.env,OUT:out}});
const output = (result.stdout || '') + (result.stderr || '');
const passed = result.status === 0 && output.includes('B06_RUNTIME_PASS: 51/51 checks') && !/SCRIPT ERROR|ERROR:|WARNING:|B06RT FAIL/.test(output);
fs.writeFileSync(path.join(out,'diagnostic-result.json'), JSON.stringify({kind:'diagnostic-not-unmodified-acceptance',exit_code:result.status,passed,error:result.error?.message || null,signal:result.signal,os:process.platform,checks:'all 51 inherited unchanged; keyboard isolation starts before skip'}, null, 2)+'\n');
console.log(output);
console.log('WINDOWS_EARLY_ISOLATION_DIAGNOSTIC '+ (passed ? 'PASS' : 'FAIL'));
process.exitCode = passed ? 0 : 1;
