from pathlib import Path
import json
import os
import re
import subprocess

ROOT = Path(__file__).resolve().parents[3]
OUT = Path(__file__).resolve().parent
receipt = json.loads((OUT / "changes.json").read_text(encoding="utf-8"))
before = OUT / "before"
issues = []

def check(condition, label):
    if not condition:
        issues.append(label)

str_pattern = r'"(?:[^"\\\r\n]|\\.)*"'
for filename in ["main.gd", "wagon_inventory_ui.gd"]:
    old = (before / filename).read_text(encoding="utf-8-sig")
    new = (ROOT / filename).read_text(encoding="utf-8-sig")
    check(re.sub(str_pattern, '""', old) == re.sub(str_pattern, '""', new), filename + ": unchanged code outside strings")
    strings = re.findall(str_pattern, new)
    check(not any(re.search(r"\b(?:Lolth|LOLTH|Shar|SHAR)\b", s) for s in strings), filename + ": old display names removed")
    for path in re.findall(r'"res://([^"\r\n]+)"', new):
        check((ROOT / path).exists(), "resource: " + path)
    for preserved in ["Eol", "drow", "drows", "THALESTRIEL", "AELIRA", "VAELUN", "NIMARA", "THAVIEL", "ILYREN", "ORISYA", "SORETH", "LURAEN"]:
        check(old.count(preserved) == new.count(preserved), filename + ": preserved " + preserved)

panels_path = Path(".atena/generated/2026-10-05-b09-opening-art-production/panel-text.en.json")
old_panels = json.loads((before / panels_path).read_text(encoding="utf-8-sig"))
panels = json.loads((ROOT / panels_path).read_text(encoding="utf-8-sig"))
check(len(panels["panels"]) == 20, "20 panels")
check([p["id"] for p in panels["panels"]] == [p["id"] for p in old_panels["panels"]], "same panel sequence")
check(not re.search(r"\b(?:Lolth|Shar)\b", json.dumps(panels), re.I), "no old panel names")
for old, new in zip(old_panels["panels"], panels["panels"]):
    for preserved in ["Eol", "drow", "Thalestriel", "Golden City", "Dream Plane"]:
        check(json.dumps(old).count(preserved) == json.dumps(new).count(preserved), old["id"] + ": preserved " + preserved)
check("Xiar's kiss" in (ROOT / "main.gd").read_text(encoding="utf-8"), "current runtime wand")

links = 0
index = {p.stem for p in (ROOT / ".atena").rglob("*") if p.is_file()}
for entry in receipt["files"]:
    file = ROOT / entry["path"]
    if file.suffix != ".md":
        continue
    text = file.read_text(encoding="utf-8-sig")
    if text.startswith("---"):
        header = text.split("---", 2)[1]
        check("naming_revision: 2026-10-05-nolf-xiar-naming" in header, "dated naming metadata: " + str(file))
    for link in re.findall(r"\[\[([^]|#]+)(?:[^]]*)\]\]", text):
        links += 1
        check(link in index, "wiki link: " + link)
for path in ["add.yaml", "vault/canon", "vault/drafts", "vault/research", "specs", "evidence", "generated", "state/plan.yaml"]:
    check((ROOT / ".atena" / path).exists(), "ADD contract: " + path)

old_state = (before / ".atena/state/plan.yaml").read_text(encoding="utf-8-sig")
current_state = (ROOT / ".atena/state/plan.yaml").read_text(encoding="utf-8-sig")
def active_block(text):
    return text.split("\nactive_plan:\n", 1)[1].split("\nplan_cursor:", 1)[0]
check("  naming_revision: 2026-10-05-nolf-xiar-naming" in active_block(current_state), "active naming amendment")
without_amendment = re.sub(r"^  naming_revision[^\n]*\n?", "", active_block(current_state), flags=re.M)
strip_blanks = lambda text: "\n".join(line for line in text.splitlines() if line.strip())
check(strip_blanks(without_amendment) == strip_blanks(active_block(old_state)), "preserved active production fields")
cursor = lambda text: re.search(r"^plan_cursor: (.+)$", text, re.M).group(1)

env = os.environ.copy()
for key, subdir in [("APPDATA", "roaming"), ("LOCALAPPDATA", "local")]:
    path = OUT / "godot-profile" / subdir
    path.mkdir(parents=True, exist_ok=True)
    env[key] = str(path)
engine_results = []
previous_results = json.loads((OUT / "validation.json").read_text(encoding="utf-8"))["engine"] if (OUT / "validation.json").exists() else []
(OUT / "menus").mkdir(exist_ok=True)
for label, args in [
    ("import", ["--headless", "--path", str(ROOT), "--editor", "--import", "--quit"]),
    ("self-test", ["--headless", "--path", str(ROOT), "--", "--self-test"]),
    ("menus", ["--path", str(ROOT), "--rendering-method", "gl_compatibility", "--script", "res://.atena/generated/2026-10-05-nolf-xiar-naming/menus_regression.gd"]),
]:
    previous = next((r for r in previous_results if r["check"] == label and r["exit_code"] == 0), None)
    if label != "menus" and previous:
        engine_results.append(previous)
        continue
    result = subprocess.run([r"D:\Godot\godot.exe", *args], cwd=ROOT, env=env, capture_output=True, timeout=55)
    output = (result.stdout + result.stderr).decode("utf-8", errors="replace")
    (OUT / (label + ".log")).write_text(output, encoding="utf-8")
    diagnostics = [line for line in output.splitlines() if "ERROR:" in line or "FAIL" in line]
    engine_results.append({"check": label, "exit_code": result.returncode, "diagnostics": diagnostics, "pass_markers": [line for line in output.splitlines() if "PASS" in line]})
    check(result.returncode == 0, label + " exit code")
    check(not [d for d in diagnostics if "root certificate store" not in d], label + " project diagnostics")
    if label == "self-test":
        check("SELF_TEST_PASS" in output, "self-test pass marker")
    print(json.dumps(engine_results[-1]), flush=True)

validation = {"issues": issues, "wiki_links_checked": links, "panels": 20, "engine": engine_results, "initial_production_cursor": cursor(old_state), "observed_production_cursor": cursor(current_state), "godot_profile": "workspace-local", "yaml_validation": "scoped textual metadata/state comparison, not a full YAML parser", "static_checks_passed": not issues}
(OUT / "validation.json").write_text(json.dumps(validation, indent=2) + "\n", encoding="utf-8")
print(json.dumps({"issues": issues, "wiki_links": links}), flush=True)
raise SystemExit(1 if issues else 0)
