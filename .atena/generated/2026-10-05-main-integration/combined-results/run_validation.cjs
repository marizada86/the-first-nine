// B-08 validation runner. Records Godot's actual process exit code and diagnostics per case.
// GODOT: engine path (default D:/Godot/godot.exe). B08_PROJECT: project copy to run (default cwd).
// XVFB=1 wraps rendered cases in xvfb-run on Linux. No fixed-FPS option is used.
// Run it in a scratch copy of the checkout; then copy logs, results and captures back.
const {spawnSync, execFileSync} = require('node:child_process');
const fs = require('node:fs');
const path = require('node:path');
const RES = 'res://.atena/generated/2026-10-05-b08-validation';
const REL = '.atena/generated/2026-10-05-b08-validation';
const B07_RES = 'res://.atena/generated/2026-10-05-b07-validation';
const B06_RES = 'res://.atena/generated/2026-10-04-b06-validation';
const B06_REL = '.atena/generated/2026-10-04-b06-validation';
// Git checkout used only to read the historical baseline (the scratch copy may have no .git).
const gitCwd = process.env.B08_GIT_CWD || __dirname;
const godot = process.env.GODOT || 'D:/Godot/godot.exe';
const project = path.resolve(process.env.B08_PROJECT || process.cwd());
const out = path.join(project, REL);
const render = ['--rendering-method', 'gl_compatibility', '--resolution', '1280x720'];
// Each faulty test-only subclass must be rejected by its own named assertion.
const faults = {
  wrong_artwork: 'harrier_geometry_crop',
  unreachable_flight: 'harrier_reachable_in_live_flight',
  late_bounds: 'harrier_bounds_ready_before_first_frame',
  retargeting: 'harrier_windup_locks_target',
  repeated_damage: 'harrier_single_hit_per_dive',
  boundary_escape: 'harrier_stays_in_bounds',
  shared_defeat_state: 'independent_defeat_and_reward',
  duplicate_reward: 'independent_defeat_and_reward',
  incomplete_rollback: 'save_combo_neither',
  incomplete_f4_restore: 'f4_restores_both_exactly',
  duplicate_spawn: 'harrier_activation_at_2600',
};
const cases = {
  'b08-headless': {args: ['--headless', '--script', RES + '/validate_b08_headless.gd'], marker: 'B08_PASS: 34/34 checks'},
  'b08-runtime': {args: [...render, '--script', RES + '/validate_b08_runtime.gd'], render: true, marker: 'B08_RUNTIME_PASS:'},
  'self-test': {args: ['--headless', '--', '--self-test'], marker: 'SELF_TEST_PASS:', also: ['SELF_TEST_B06_PASS:', 'SELF_TEST_B07_PASS:', 'SELF_TEST_B08_PASS:']},
  // Unchanged B-07 suites. Their fixture reaches the expedition with the B-08 Harrier already
  // resolved, exactly as B-06 suites resolved the crawler, so they keep their B-07 meaning.
  'b07-headless': {args: ['--headless', '--script', B07_RES + '/validate_b07_headless.gd'], marker: 'B07_PASS: 24/24 checks'},
  'b07-runtime': {args: [...render, '--script', B07_RES + '/validate_b07_runtime.gd'], render: true, out: 'regressions/b07-runtime', marker: 'B07_RUNTIME_PASS: 28/28 checks'},
  // Unchanged B-06 route suites, with both foothill encounters resolved by the shared fixture.
  'b06-headless': {args: ['--headless', '--script', B06_RES + '/validate_b06_headless.gd'], marker: 'B06_PASS:'},
  'b06-runtime': {args: [...render, '--script', B06_RES + '/validate_b06_runtime.gd'], render: true, out: 'regressions/b06-runtime', marker: 'B06_RUNTIME_PASS:', baseline: true},
  // Historical combat and menu suites through the unchanged B-06 isolation wrappers.
  'combat': {args: [...render, '--script', B06_RES + '/combat_regression.gd'], render: true, out: 'regressions/combat', marker: 'B05_RUNTIME_PASS: 0 failures', also: ['COMBAT_ISOLATION PASS'], count: ['RUNTIME PASS ', 9]},
  'combat-noise': {args: [...render, '--script', B06_RES + '/combat_regression.gd'], render: true, out: 'regressions/combat-noise', env: {B06_COMBAT_NOISE: '1'}, marker: 'B05_RUNTIME_PASS: 0 failures', also: ['COMBAT_ISOLATION PASS'], count: ['RUNTIME PASS ', 9]},
  'menus': {args: [...render, '--script', B06_RES + '/menus_regression.gd'], render: true, out: 'regressions/menus', marker: 'LOCAL_CONTROLS_PASS: 33/33', also: ['MENU_ISOLATION PASS']},
  // Historical geometry and facing oracles through B-08 output-only wrappers.
  'geometry': {args: [...render, '--script', RES + '/geometry_regression.gd'], render: true, out: 'regressions/geometry'},
  'facing-headless': {args: ['--headless', '--script', RES + '/facing_regression.gd']},
  'facing-normal': {args: [...render, '--script', RES + '/facing_regression.gd'], render: true, out: 'regressions/facing'},
  'normal-smoke': {args: [...render, '--quit-after', '600'], render: true},
  'headless-smoke': {args: ['--headless', '--quit-after', '600']},
};
// Fault controls are headless and write no captures, so they can never replace evidence images.
for (const [fault, assertion] of Object.entries(faults)) cases['negative-' + fault] = {args: cases['b08-headless'].args, env: {B08_FAULT: fault}, negative: 'B08 FAIL ' + assertion};
// Diagnostics from the host audio/display stack, not from the project, are recorded but tolerated.
// Each diagnostic is classified together with its following source line.
const environmentOnly = [/ALSA|PulseAudio|audio drivers? failed|drivers\/alsa|drivers\/pulseaudio|audio_driver/i, /V-?Sync/i, /XDG_RUNTIME_DIR/i];
// The pre-B-06 build is written into the run copy only for the B-06 cave-view parity check.
const baseline = path.join(project, B06_REL, 'baseline', 'main_7e477ba.gd');
const godotVersion = (() => { try { return execFileSync(godot, ['--version'], {encoding: 'utf8'}).trim(); } catch (error) { return 'unknown: ' + error.message; } })();
const platform = {os: process.platform, arch: process.arch, godot: godotVersion, display: process.env.XVFB === '1' ? 'xvfb' : 'native'};
let failed = false;
const names = process.argv.slice(2).flatMap(name => name === 'all' ? Object.keys(cases) : [name]);
for (const name of names) {
  const spec = cases[name];
  if (!spec) throw new Error('Unknown case: ' + name);
  const caseOut = path.join(out, spec.out || '');
  fs.mkdirSync(caseOut, {recursive: true});
  if (spec.baseline) {
    fs.mkdirSync(path.dirname(baseline), {recursive: true});
    fs.writeFileSync(baseline, execFileSync('git', ['show', '7e477ba799ce5b4bf9cb6e9dde44e83c97db0bbc:main.gd'], {cwd: gitCwd, encoding: 'utf8'}));
  }
  const args = ['--path', project, '--log-file', path.join(out, name + '.log'), ...spec.args];
  const command = spec.render && process.env.XVFB === '1' ? 'xvfb-run' : godot;
  const commandArgs = command === 'xvfb-run' ? ['-a', '-s', '-screen 0 1280x720x24', godot, ...args] : args;
  const started = Date.now();
  const result = spawnSync(command, commandArgs, {encoding: 'utf8', timeout: 300000, windowsHide: true, env: {...process.env, OUT: caseOut, ...(spec.env || {})}});
  if (spec.baseline) fs.rmSync(path.dirname(baseline), {recursive: true, force: true});
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
  const detections = spec.negative ? lines.filter(line => line.startsWith('B08 FAIL ')) : [];
  const failMarkers = /SCRIPT ERROR|_FAIL|RUNTIME FAIL|LOCAL FAIL|GEOMETRY FAIL|FACING FAIL|B06 FAIL|B06RT FAIL|B08 FAIL|B08RT FAIL|B07 FAIL|B07RT FAIL/;
  // A negative control passes only on a genuine rejection: exit 1, its own named assertion,
  // and no script/parse/import errors (a crash is not a rejection).
  const passed = spec.negative
    ? result.status === 1 && lines.some(line => line === spec.negative || line.startsWith(spec.negative + ' ')) && projectDiagnostics.length === 0 && !/SCRIPT ERROR|Parse Error/.test(output)
    : result.status === 0 && projectDiagnostics.length === 0 && !failMarkers.test(output) && (!spec.marker || output.includes(spec.marker)) && (spec.also || []).every(marker => output.includes(marker)) && (!spec.count || lines.filter(line => line.startsWith(spec.count[0])).length === spec.count[1]);
  const device = (output.match(/Using Device[^\n]*/) || [null])[0];
  const record = {name, platform: {...platform, device}, exit_code: result.status, signal: result.signal, passed, seconds: (Date.now() - started) / 1000, expected_rejection: spec.negative || null, project_diagnostics: projectDiagnostics, environment_diagnostics: diagnosticLines.filter(line => !projectDiagnostics.includes(line)), detections, error: result.error?.message || null};
  fs.writeFileSync(path.join(out, name + '-result.json'), JSON.stringify(record, null, 2) + '\n');
  console.log(output.trimEnd());
  console.log('GODOT_PROCESS ' + (passed ? 'PASS' : 'FAIL') + ' ' + name + ': exit=' + result.status);
  failed ||= !passed;
}
process.exitCode = failed ? 1 : 0;
