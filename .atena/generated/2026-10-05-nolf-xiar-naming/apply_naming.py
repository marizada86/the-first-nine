from pathlib import Path
import hashlib
import json
import re

ROOT = Path(__file__).resolve().parents[3]
OUT = Path(__file__).resolve().parent
DECISION = "2026-10-05-nolf-xiar-naming"
changes = []

def rename(text):
    # Replace complete item phrases before character names, including their article.
    pairs = [
        ("THE KISS OF SHAR", "XIAR'S KISS"),
        ("The Kiss of Shar", "Xiar's kiss"),
        ("the Kiss of Shar", "Xiar's kiss"),
        ("Kiss of Shar", "Xiar's kiss"),
        ("O Beijo de Shar", "Xiar's kiss"),
        ("Beijo de Shar", "Xiar's kiss"),
        ("Lolth", "Nolf"), ("LOLTH", "NOLF"),
        ("Shar", "Xiar"), ("SHAR", "XIAR"),
    ]
    for old, new in pairs:
        text = re.sub(r"(?<!\w)" + re.escape(old) + r"(?!\w)", lambda _: new, text)
    return text

def write_changed(path, transform):
    before = path.read_bytes()
    text = before.decode("utf-8-sig")
    after_text = transform(text)
    prefix = b"\xef\xbb\xbf" if before.startswith(b"\xef\xbb\xbf") else b""
    after = prefix + after_text.encode("utf-8")
    if after == before:
        return
    rel = path.relative_to(ROOT)
    backup = OUT / "before" / rel
    backup.parent.mkdir(parents=True, exist_ok=True)
    if backup.exists():
        raise RuntimeError(f"Existing backup: {rel}")
    backup.write_bytes(before)
    if path.read_bytes() != before:
        raise RuntimeError(f"Concurrent edit detected: {rel}")
    path.write_bytes(after)
    changes.append({"path": rel.as_posix(), "before_sha256": hashlib.sha256(before).hexdigest(), "after_sha256": hashlib.sha256(after).hexdigest()})

def gd_text(text):
    # Only strings with the capitalized display names change. Lowercase resource
    # paths, state keys, variables, function names and save keys stay compatible.
    return re.sub(r'"(?:[^"\\\r\n]|\\.)*"', lambda m: rename(m.group()), text)

for file in ["main.gd", "wagon_inventory_ui.gd"]:
    write_changed(ROOT / file, gd_text)
write_changed(ROOT / "README.md", rename)

def markdown_current(text):
    nl = "\r\n" if "\r\n" in text else "\n"
    parts = text.split("---", 2)
    if len(parts) != 3 or parts[0].strip():
        raise RuntimeError("Expected front matter")
    # Original approval source and dates are retained verbatim.
    header = parts[1].rstrip() + nl + f"naming_revision: {DECISION}" + nl
    protected = re.split(r"(\[\[.*?\]\]|`[^`]*`|\]\([^)]*\))", parts[2])
    for i in range(0, len(protected), 2):
        protected[i] = rename(protected[i])
    body = "".join(protected)
    heading_end = body.find(nl, body.find("# "))
    note = nl + nl + "Naming amended on 2026-10-05 by the owner's explicit instruction: Nolf, Xiar and Xiar's kiss. Historical record IDs and asset paths retain their original names." + nl
    body = body[:heading_end] + note + body[heading_end:]
    return "---" + header + "---" + body

canon = [
    "2026-10-02-thalestriel-exodus-game-intent.md",
    "2026-10-03-hq-narrative-revision.md",
    "2026-10-03-b00-opening-ending-and-production-resolution.md",
    "2026-10-05-opening-cave-care-and-continuous-journey.md",
]
for file in canon:
    write_changed(ROOT / ".atena/vault/canon" / file, markdown_current)
for file in ["2026-10-05-b09-opening-art-production.md", "2026-10-05-b09-opening-cave-care-and-continuous-journey.md"]:
    write_changed(ROOT / ".atena/specs" / file, markdown_current)

production = ROOT / ".atena/generated/2026-10-05-b09-opening-art-production"
# JSON keys, IDs, paths and historical receipts are preserved. Only the current
# captions, scene descriptions and future-generation prompts are amended.
for path in [production / "panel-text.en.json", *sorted(production.glob("art-*.manifest.json"))]:
    def json_text(text):
        data = json.loads(text)
        def walk(value):
            if isinstance(value, dict):
                return {k: walk(v) for k, v in value.items()}
            if isinstance(value, list):
                return [walk(v) for v in value]
            if isinstance(value, str):
                return rename(value)
            return value
        updated = walk(data)
        nl = "\r\n" if "\r\n" in text else "\n"
        return json.dumps(updated, indent=2, ensure_ascii=False).replace("\n", nl) + nl
    write_changed(path, json_text)

# Read operational state immediately before the targeted amendment. The writer
# refuses a concurrent edit instead of overwriting production progress.
def state_amend(text):
    start = text.index("\nactive_plan:")
    end = text.index("\nplan_cursor:", start)
    block = text[start:end]
    if 'id: "2026-10-05-b09-opening-art-production"' not in block:
        raise RuntimeError("Active plan changed; reconcile before attaching naming amendment")
    nl = "\r\n" if "\r\n" in text else "\n"
    addition = (f"  naming_revision: {DECISION}" + nl
        + "  naming_revision_classification: PLAN_CHANGE_REQUEST" + nl
        + "  naming_revision_approved: true" + nl
        + "  naming_revision_approval_mode: per-plan" + nl
        + "  naming_revision_authority: Owner explicitly instructed Nolf, Xiar and Xiar's kiss, retaining all other names." + nl)
    return text[:end] + nl + addition.rstrip("\r\n") + text[end:]
write_changed(ROOT / ".atena/state/plan.yaml", state_amend)

(OUT / "changes.json").write_text(json.dumps({"decision": DECISION, "files": changes}, indent=2) + "\n", encoding="utf-8")
print(json.dumps({"changed_files": len(changes), "receipt": str(OUT / "changes.json")}, ensure_ascii=False))
