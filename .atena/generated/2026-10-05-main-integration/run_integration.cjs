// Fresh combined-build checks. Historical validators and saved results are never overwritten.
const fs = require('node:fs'), path = require('node:path'), cp = require('node:child_process'), crypto=require('node:crypto');
const root = path.resolve(__dirname, '../../..'), scratch = path.join(__dirname, 'scratch');
const godot = 'D:/Godot/godot.exe';
const relative = '.atena/generated/2026-10-05-main-integration';
function copy(file) {
  const target = path.join(scratch, file);
  fs.mkdirSync(path.dirname(target), {recursive:true});
  fs.copyFileSync(path.join(root, file), target);
}
if (process.argv[2] === 'prepare') {
  if (fs.existsSync(scratch)) throw Error('Scratch already exists; preserve it and select another run directory.');
  const files = cp.execFileSync('git', ['ls-files', '-z'], {cwd:root, encoding:'utf8'}).split('\0').filter(Boolean);
  for (const file of files) {
    if (file.startsWith('.atena/')) {
      if (!file.startsWith('.atena/generated/') || !/\.(gd|cjs)$/.test(file)) continue;
      if (/\/local-preparation\//.test(file)) continue;
    }
    copy(file);
  }
  // New files may not yet have entered the merge index.
  for (const file of ['run_integration.cjs']) copy(relative + '/' + file);
  fs.mkdirSync(path.join(scratch, '.atena/generated/2026-10-05-lolth-three-transformations'), {recursive:true});
  console.log('Prepared isolated combined-build copy: ' + scratch);
  process.exit(0);
}
const profiles = {APPDATA:path.join(scratch, 'godot-profile/roaming'), LOCALAPPDATA:path.join(scratch, 'godot-profile/local')};
for (const dir of Object.values(profiles)) fs.mkdirSync(dir,{recursive:true});
const env = {...process.env, ...profiles, GODOT:godot, B08_PROJECT:scratch, B08_GIT_CWD:root};
function engine(name,args,marker) {
  const result = cp.spawnSync(godot,['--path',scratch,...args],{env,encoding:'utf8',timeout:300000,windowsHide:true});
  const output = (result.stdout||'')+(result.stderr||'');
  fs.writeFileSync(path.join(__dirname,name+'.log'),output);
  const errors = output.split(/\r?\n/).filter(line=>/SCRIPT ERROR|ERROR:|FAIL/.test(line) && !/root certificate store/.test(line));
  const receipt = {name,exit_code:result.status,error:result.error?.message||null,passed:result.status===0&&!errors.length&&(!marker||output.includes(marker)),project_diagnostics:errors,markers:output.split(/\r?\n/).filter(line=>/PASS/.test(line))};
  fs.writeFileSync(path.join(__dirname,name+'-result.json'),JSON.stringify(receipt,null,2)+'\n');
  console.log(JSON.stringify(receipt));
  return receipt.passed;
}
if(process.argv[2]==='art') {
  const validator=path.join(root,'.atena/generated/2026-10-05-b09-opening-art-production/validate_package_review.cjs');
  const result=cp.spawnSync(process.execPath,[validator],{cwd:root,encoding:'utf8',timeout:300000,windowsHide:true});
  if(result.status!==0)throw Error(result.stderr||result.stdout);
  const report=JSON.parse(result.stdout);fs.writeFileSync(path.join(__dirname,'art-validation.json'),JSON.stringify(report,null,2)+'\n');
  console.log(JSON.stringify({status:report.status,targets:report.distinct_targets,attempts:report.generation_attempts,controls:report.negative_controls.length}));
} else if(process.argv[2]==='import') process.exitCode=engine('import',['--headless','--editor','--import','--quit'])?0:1;
else if(process.argv[2]==='forms') {
  process.exitCode=engine('forms',['--headless','--script','res://.atena/generated/2026-10-05-lolth-three-transformations/validate_runtime.gd'],'LOLTH_FORMS_PASS: 196/196')?0:1;
  const receipt=path.join(scratch,'.atena/generated/2026-10-05-lolth-three-transformations/runtime-validation.json');
  if(fs.existsSync(receipt))fs.copyFileSync(receipt,path.join(__dirname,'forms-validation.json'));
} else if(process.argv[2]==='b06-current-names') {
  // The pixel oracle predates the approved rename. Normalize only displayed string
  // literals in its generated scratch baseline; all three original pixel assertions remain.
  const old=cp.execFileSync('git',['show','7e477ba799ce5b4bf9cb6e9dde44e83c97db0bbc:main.gd'],{cwd:root,encoding:'utf8'});
  const updated=old.replace(/"(?:[^"\\\r\n]|\\.)*"/g,s=>s.replace(/\bLolth\b/g,'Nolf').replace(/\bLOLTH\b/g,'NOLF').replace(/\bShar\b/g,'Xiar').replace(/\bSHAR\b/g,'XIAR'));
  const baselineFile=path.join(scratch,'.atena/generated/2026-10-04-b06-validation/baseline/main_7e477ba.gd');
  fs.mkdirSync(path.dirname(baselineFile),{recursive:true});fs.writeFileSync(baselineFile,updated);
  const hash=s=>crypto.createHash('sha256').update(s).digest('hex');
  fs.writeFileSync(path.join(__dirname,'baseline-name-normalization.json'),JSON.stringify({source_commit:'7e477ba799ce5b4bf9cb6e9dde44e83c97db0bbc',source_sha256:hash(old),normalized_sha256:hash(updated),scope:'Only approved name replacements inside string literals in a generated scratch baseline',protected_assertions_changed:false,production_changed:false},null,2)+'\n');
  env.OUT=path.join(__dirname,'b06-current-names-captures');fs.mkdirSync(env.OUT,{recursive:true});
  process.exitCode=engine('b06-current-names',['--rendering-method','gl_compatibility','--resolution','1280x720','--script','res://.atena/generated/2026-10-04-b06-validation/validate_b06_runtime.gd'],'B06_RUNTIME_PASS: 53/53')?0:1;
} else if(process.argv[2]==='b08') {
  const runner=path.join(root,'.atena/generated/2026-10-05-b08-validation/run_validation.cjs');
  const result=cp.spawnSync(process.execPath,[runner,...process.argv.slice(3)],{cwd:root,env,encoding:'utf8',timeout:900000,windowsHide:true});
  const output=(result.stdout||'')+(result.stderr||'');
  fs.writeFileSync(path.join(__dirname,'combined-runner.log'),output);
  const source=path.join(scratch,'.atena/generated/2026-10-05-b08-validation');
  fs.cpSync(source,path.join(__dirname,'combined-results'),{recursive:true});
  console.log(output);
  process.exitCode=result.status===0?0:1;
} else throw Error('Use prepare, import, forms, or b08 followed by historical runner case names.');
