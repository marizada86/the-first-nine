// Collect Godot's actual process exit code (not a GUI-shell wrapper status).
const {spawnSync} = require('node:child_process');
const fs = require('node:fs');
const path = require('node:path');
const cases = {
  geometry: ['--rendering-method', 'gl_compatibility', '--script', 'res://.atena/generated/2026-10-04-b05-geometry-validation/validate_enemy_geometry.gd'],
  combat: ['--rendering-method', 'gl_compatibility', '--script', 'res://.atena/generated/2026-10-04-b05-combat-validation/validate_b05_combat.gd'],
  runtime: ['--rendering-method', 'gl_compatibility', '--script', 'res://.atena/generated/2026-10-04-b05-local-controls-validation/validate_controls_and_menus.gd'],
  'self-test': ['--headless', '--', '--self-test'],
  'normal-smoke': ['--rendering-method', 'gl_compatibility', '--resolution', '1280x720', '--quit-after', '600'],
  'headless-smoke': ['--headless', '--quit-after', '600'],
};
let failed = false;
for (const name of process.argv.slice(2)) {
  if (!cases[name]) throw new Error(`Unknown validation: ${name}`);
  const log = path.join(__dirname, name === 'geometry' ? 'geometry-render.log' : `${name}.log`);
  const result = spawnSync('D:/Godot/godot.exe', ['--path', process.cwd(), '--log-file', log, ...cases[name]], {
    encoding: 'utf8', timeout: 60000, env: {...process.env, OUT: __dirname},
  });
  const output = (result.stdout || '') + (result.stderr || '');
  process.stdout.write(output);
  const passed = result.status === 0 && !/SCRIPT ERROR:|ERROR:|WARNING:|RUNTIME FAIL|LOCAL FAIL|GEOMETRY FAIL/.test(output);
  fs.writeFileSync(path.join(__dirname, `${name}-result.json`), JSON.stringify({name, exit_code: result.status, passed, error: result.error?.message || null}, null, 2) + '\n');
  console.log(`GODOT_PROCESS ${passed ? 'PASS' : 'FAIL'} ${name}: exit=${result.status}`);
  failed ||= !passed;
}
process.exitCode = failed ? 1 : 0;
