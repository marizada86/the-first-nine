// Validation-only subclasses: no production edits or checkout mutation.
const {spawnSync} = require('node:child_process');
const fs = require('node:fs');
const path = require('node:path');
const faults = ['square_aspect', 'short_reach', 'long_reach', 'legacy_reach', 'missing_prewarm'];
const results = [];
for (const fault of faults) {
  const run = spawnSync('D:/Godot/godot.exe', [
    '--headless', '--path', process.cwd(), '--log-file', path.join(__dirname, `negative-${fault}.log`),
    '--script', 'res://.atena/generated/2026-10-04-b05-geometry-validation/validate_enemy_geometry.gd',
    '--', '--geometry-fault', fault,
  ], {encoding: 'utf8', timeout: 60000});
  const output = (run.stdout || '') + (run.stderr || '');
  const detections = output.split(/\r?\n/).filter(line => line.startsWith('GEOMETRY FAIL'));
  const detected = run.status === 1 && output.includes('GEOMETRY_FAIL:') && detections.length > 0 && !/SCRIPT ERROR:|ERROR:/.test(output);
  results.push({fault, exit_code: run.status, detected, detections});
  console.log(`NEGATIVE ${detected ? 'PASS' : 'FAIL'} ${fault}: exit=${run.status}, targeted failures=${detections.length}`);
  if (!detected) console.log(output);
}
fs.writeFileSync(path.join(__dirname, 'negative-controls.json'), JSON.stringify(results, null, 2) + '\n');
const passed = results.filter(result => result.detected).length;
console.log(`GEOMETRY_NEGATIVES: ${passed}/${results.length} deliberately faulty subclasses rejected`);
process.exitCode = passed === results.length ? 0 : 1;
