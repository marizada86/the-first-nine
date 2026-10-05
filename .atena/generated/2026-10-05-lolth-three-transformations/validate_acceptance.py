from pathlib import Path
import json
import re

root = Path(__file__).resolve().parents[3]
generated = Path(__file__).resolve().parent
state = (root / '.atena/state/plan.yaml').read_text(encoding='utf-8-sig')
current = state.split('last_completed_plan:', 1)[1].split('completed_plan_history:', 1)[0]
assert 'id: "2026-10-05-lolth-three-transformations"' in current
assert 'status: complete-human-accepted' in current
assert 'human_acceptance: accepted' in current
assert state.count('active_plan: null') == 1
assert 'plan_cursor: complete' in state
assert '2026-10-05-b07-stonehook-first-encounter' in state
assert 'PCR-001-b09-opening-cave-care' in state
assert 'DEV-001' in state
for entry in ['add.yaml', 'vault/canon', 'vault/drafts', 'vault/research',
              'specs', 'evidence', 'generated', 'state/plan.yaml']:
    assert (root / '.atena' / entry).exists(), entry
documents = [
    root / '.atena/specs/2026-10-05-lolth-three-transformations.md',
    root / '.atena/evidence/2026-10-05-lolth-three-transformations-production.md',
    root / '.atena/vault/canon/2026-10-05-lolth-three-transformation-visual-stages.md',
]
existing = {path.stem for path in (root / '.atena').rglob('*.md')}
links = 0
for document in documents:
    content = document.read_text(encoding='utf-8-sig')
    assert 'human_acceptance: accepted' in content
    for link in re.findall(r'\[\[([^\]]+)\]\]', content):
        target = link.split('|')[0].split('#')[0]
        assert Path(target).stem in existing, (document, link)
        links += 1
receipt = json.loads((generated / 'human-acceptance.json').read_text())
result = json.loads((generated / 'results.json').read_text())
assert result['human_acceptance'] == receipt
for mark in ['3', '5', '7']:
    assert result['stages'][mark]['human_acceptance'] == 'accepted'
    assert result['stages'][mark]['status'] == 'accepted-human-reviewed'
print(f'PASS: explicit owner acceptance, three stages, ADD contract, {links} links and preserved plan history.')
