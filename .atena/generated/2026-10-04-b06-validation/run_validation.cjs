// B-06 validation runner. Records Godot's actual process exit code and diagnostics per case.
// GODOT: engine path (default D:/Godot/godot.exe). B06_PROJECT: project copy to run (default cwd).
// XVFB=1 wraps rendered cases in xvfb-run on Linux. No fixed-FPS option is used.
const {spawnSync, execFileSync} = require('node:child_process');
const fs = require('node:fs');
const path = require('node:path');
const RES = 'res://.atena/generated/2026-10-04-b06-validation';
const REL = '.atena/generated/2026-10-04-b06-validation';
const godot = process.env.GODOT || 'D:/Godot/godot.exe';
const project = path.resolve(process.env.B06_PROJECT || process.cwd());
const out = path.join(project, REL);
const render = ['--rendering-method', 'gl_compatibility', '--resolution', '1280x720'];
const logicFaults = ['bypass_departure', 'border_respawn', 'remote_wagon', 'paused_offscreen', 'lost_route_restore', 'lost_f4_fields', 'progression_unlock', 'new_run_keeps_route'];
const renderFaults = ['leaked_camera_transform', 'unshifted_reflection', 'no_foreground_readability'];
const cases = {
  'b06-headless': {args: ['--headless', '--script', RES + '/validate_b06_headless.gd'], marker: 'B06_PASS:'},
  'b06-runtime': {args: [...render, '--script', RES + '/validate_b06_runtime.gd'], render: true, marker: 'B06_RUNTIME_PASS:'},
  'self-test': {args: ['--headless', '--', '--self-test'], marker: 'SELF_TEST_PASS:', also: 'SELF_TEST_B06_PASS:'},
  // The historical 9-check combat suite, run through the controller-isolation wrapper.
  'combat': {args: [...render, '--script', RES + '/combat_regression.gd'], render: true, out: 'regressions/combat', marker: 'B05_RUNTIME_PASS: 0 failures', also: 'COMBAT_ISOLATION PASS', count: ['RUNTIME PASS ', 9]},
  // Same suite with a synthetic 0.21 trigger every frame: isolation must neutralize it.
  'combat-noise': {args: [...render, '--script', RES + '/combat_regression.gd'], render: true, out: 'regressions/combat-noise', env: {B06_COMBAT_NOISE: '1'}, marker: 'B05_RUNTIME_PASS: 0 failures', also: 'COMBAT_ISOLATION PASS', count: ['RUNTIME PASS ', 9]},
  'menus': {args: [...render, '--script', RES + '/menus_regression.gd'], render: true, out: 'regressions/menus', marker: 'LOCAL_CONTROLS_PASS: 33/33', also: 'MENU_ISOLATION PASS'},
  'geometry': {args: [...render, '--script', RES + '/geometry_regression.gd'], render: true},
  'facing-headless': {args: ['--headless', '--script', RES + '/facing_regression.gd']},
  'facing-normal': {args: [...render, '--script', RES + '/facing_regression.gd'], render: true},
  'normal-smoke': {args: [...render, '--quit-after', '600'], render: true},
  'headless-smoke': {args: ['--headless', '--quit-after', '600']},
};
for (const fault of logicFaults) cases['negative-' + fault] = {args: cases['b06-headless'].args, env: {B06_FAULT: fault}, negative: 'B06 FAIL '};
for (const fault of renderFaults) cases['render-negative-' + fault] = {args: cases['b06-runtime'].args, render: true, env: {B06_RENDER_FAULT: fault}, negative: 'B06RT FAIL '};
// Isolation control: the published ordering applies isolation after a dash is already queued.
// Combat isolation controls, both under the same synthetic trigger noise.
cases['combat-negative-missing_isolation'] = {args: cases['combat'].args, render: true, out: 'regressions/combat-faults', env: {B06_COMBAT_ISOLATION_FAULT: 'missing'}, negative: 'RUNTIME FAIL '};
cases['combat-negative-late_isolation'] = {args: cases['combat'].args, render: true, out: 'regressions/combat-faults', env: {B06_COMBAT_ISOLATION_FAULT: 'late'}, negative: 'COMBAT_ISOLATION FAIL'};
cases['isolation-negative-late_isolation'] = {args: cases['b06-runtime'].args, render: true, env: {B06_ISOLATION_FAULT: 'late_isolation'}, negative: 'B06RT FAIL '};
// Diagnostics from the host audio/display stack, not from the project, are recorded but tolerated.
// Each diagnostic is classified together with its following "at:" source line.
const environmentOnly = [/ALSA|PulseAudio|audio drivers? failed|drivers\/alsa|drivers\/pulseaudio|audio_driver/i, /V-?Sync/i, /XDG_RUNTIME_DIR/i];
// The pre-B-06 build is written into the run copy only for the cave-view parity check.
const baseline = path.join(out, 'baseline', 'main_7e477ba.gd');
fs.mkdirSync(path.dirname(baseline), {recursive: true});
fs.writeFileSync(baseline, execFileSync('git', ['show', '7e477ba799ce5b4bf9cb6e9dde44e83c97db0bbc:main.gd'], {cwd: __dirname, encoding: 'utf8'}));
// Results are tagged with their platform so reruns elsewhere stay separate and comparable.
const godotVersion = (() => { try { return execFileSync(godot, ['--version'], {encoding: 'utf8'}).trim(); } catch (error) { return 'unknown: ' + error.message; } })();
const platform = {os: process.platform, arch: process.arch, godot: godotVersion, display: process.env.XVFB === '1' ? 'xvfb' : 'native'};
let failed = false;
const names = process.argv.slice(2).flatMap(name => name === 'all' ? Object.keys(cases) : [name]);
for (const name of names) {
  const spec = cases[name];
  if (!spec) throw new Error('Unknown case: ' + name);
  const caseOut = path.join(out, spec.out || '');
  fs.mkdirSync(caseOut, {recursive: true});
  const args = ['--path', project, '--log-file', path.join(out, name + '.log'), ...spec.args];
  const command = spec.render && process.env.XVFB === '1' ? 'xvfb-run' : godot;
  const commandArgs = command === 'xvfb-run' ? ['-a', '-s', '-screen 0 1280x720x24', godot, ...args] : args;
  const started = Date.now();
  const result = spawnSync(command, commandArgs, {encoding: 'utf8', timeout: 240000, windowsHide: true, env: {...process.env, OUT: caseOut, ...(spec.env || {})}});
  const output = (result.stdout || '') + (result.stderr || '');
  const lines = output.split(/\r?\n/);
  const diagnosticLines = [];
  const projectDiagnostics = [];
  lines.forEach((line, index) => {
    if (!/SCRIPT ERROR|ERROR:|WARNING:/.test(line)) return;
    const context = line + ' ' + (lines[index + 1] || '');
    diagnosticLines.push(context.trim());
    if (!environmentOnly.some(pattern => pattern.test(context))) projectDiagnostics.push(context.trim());
  });
  const detections = spec.negative ? output.split(/\r?\n/).filter(line => line.startsWith(spec.negative)) : [];
  const failMarkers = /SCRIPT ERROR|_FAIL|RUNTIME FAIL|LOCAL FAIL|GEOMETRY FAIL|FACING FAIL|B06 FAIL|B06RT FAIL/;
  const passed = spec.negative
    ? result.status === 1 && detections.length > 0 && projectDiagnostics.length === 0
    : result.status === 0 && projectDiagnostics.length === 0 && !failMarkers.test(output) && (!spec.marker || output.includes(spec.marker)) && (!spec.also || output.includes(spec.also)) && (!spec.count || lines.filter(line => line.startsWith(spec.count[0])).length === spec.count[1]);
  const device = (output.match(/Using Device[^\n]*/) || [null])[0];
  const record = {name, platform: {...platform, device}, exit_code: result.status, signal: result.signal, passed, seconds: (Date.now() - started) / 1000, project_diagnostics: projectDiagnostics, environment_diagnostics: diagnosticLines.filter(line => !projectDiagnostics.includes(line)), detections, error: result.error?.message || null};
  fs.writeFileSync(path.join(out, name + '-result.json'), JSON.stringify(record, null, 2) + '\n');
  console.log(output.trimEnd());
  console.log('GODOT_PROCESS ' + (passed ? 'PASS' : 'FAIL') + ' ' + name + ': exit=' + result.status);
  failed ||= !passed;
}
fs.rmSync(path.join(out, 'baseline'), {recursive: true, force: true});
process.exitCode = failed ? 1 : 0;
