const fs = require('fs');
const path = require('path');
const crypto = require('crypto');
const assert = require('assert/strict');
const root = path.resolve(__dirname);
const project = path.resolve(root, '../../..');
const parse = name => JSON.parse(fs.readFileSync(path.join(root, name), 'utf8'));
const hash = name => crypto.createHash('sha256').update(fs.readFileSync(name)).digest('hex');
function png(name) {
  const data = fs.readFileSync(name);
  assert.equal(data.subarray(0, 8).toString('hex'), '89504e470d0a1a0a');
  return [data.readUInt32BE(16), data.readUInt32BE(20)];
}
const results = parse('results.json');
const ending = parse('ending-technical-v1.json');
const manifest = parse('art-003-project-spider-form-v3.manifest.json');
assert.equal(results.attempts.length, 33);
assert.equal(new Set(results.attempts.map(a => a.id)).size, 20);
const attempts = results.attempts.map(a => {
  assert.ok(a.attempt >= 1 && a.attempt <= 3);
  const candidate = path.resolve(project, a.target);
  const providerSource = path.resolve(a.source);
  assert.equal(hash(candidate), hash(providerSource), a.target + ' must preserve the provider output');
  return {id: a.id, attempt: a.attempt, path: a.target, dimensions: png(candidate), sha256: hash(candidate), status: a.status};
});
assert.equal(new Set(attempts.map(a => `${a.id}:${a.attempt}`)).size, attempts.length);
assert.equal(ending.items.length, 5);
assert.equal(manifest.assets.length, 5);
assert.equal(ending.runtime_admitted, false);
const seen = new Set();
for (const item of ending.items) {
  assert.deepEqual(png(path.resolve(project, item.source)), item.raw_dimensions);
  assert.equal(hash(path.resolve(project, item.source)), item.raw_sha256);
  assert.deepEqual(png(item.master), [1920, 1080]);
  assert.deepEqual(png(item.review), [1280, 720]);
  assert.equal(hash(item.master), item.master_sha256);
  assert.equal(hash(item.review), item.review_sha256);
  assert.equal(item.crop[2] * 9, item.crop[3] * 16);
  assert.equal(item.crop_visual_review, 'passed-local-inspection');
  assert.equal(item.runtime_admitted, false);
  seen.add(item.master_sha256);
}
assert.equal(seen.size, 5);
assert.deepEqual(png(ending.contact_sheet), [1320, 1240]);
assert.equal(hash(ending.contact_sheet), ending.contact_sheet_sha256);
const contractPaths = ['.atena/add.yaml', '.atena/vault/canon', '.atena/vault/drafts', '.atena/vault/research', '.atena/specs', '.atena/evidence', '.atena/generated', '.atena/state/plan.yaml'];
for (const p of contractPaths) assert.ok(fs.existsSync(path.join(project, p)), p);
const docs = [
 '.atena/vault/canon/2026-10-05-nolf-final-shadow-spider.md',
 '.atena/specs/2026-10-05-b09-final-shadow-spider-art-revision.md',
 '.atena/evidence/2026-10-05-b09-final-shadow-spider-art-revision.md',
 '.atena/specs/2026-10-05-b09-opening-art-production.md',
 '.atena/evidence/2026-10-05-b09-opening-art-production.md'
];
let links = 0;
const linkDirs = ['.atena/vault/canon', '.atena/vault/drafts', '.atena/vault/research', '.atena/specs', '.atena/evidence', '.atena/generated'];
const linkCatalog = linkDirs.flatMap(dir => fs.readdirSync(path.join(project, dir), {recursive: true}).filter(name => name.endsWith('.md')).map(name => path.basename(name, '.md')));
for (const doc of docs) {
  const content = fs.readFileSync(path.join(project, doc), 'utf8');
  for (const match of content.matchAll(/\[\[([^\]|]+)(?:\|[^\]]+)?\]\]/g)) {
    const name = match[1].split('#')[0];
    assert.ok(linkCatalog.includes(name), 'Unresolved wiki link ' + name);
    links++;
  }
}
process.stdout.write(JSON.stringify({status:'pass',attempts:33,distinctTargets:20,normalizedEndingPanels:5,allOriginalsPreserved:true,distinctMasterHashes:5,contractPathsChecked:contractPaths.length,wikiLinksResolved:links,engineRun:false,runtimeAdmitted:false,attemptTechnicalChecks:attempts}, null, 2));
