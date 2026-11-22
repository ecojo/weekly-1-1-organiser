#!/usr/bin/env bash
# Structural and portability checks for the portable package.
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

fail=0
check() { printf '  %-4s %s\n' "$1" "$2"; [ "$1" = "OK" ] || fail=1; }

echo "Frontmatter checks"
for skill in weekly-1-1-organiser weekly-1-1-organiser-manual setup-wizard manager-updates scaffolder; do
  file="skills/$skill/SKILL.md"
  if [ ! -f "$file" ]; then check FAIL "missing $file"; continue; fi
  name=$(sed -n 's/^name: *//p' "$file" | head -1)
  desc=$(sed -n 's/^description: *//p' "$file" | head -1)
  [ "$name" = "$skill" ] && check OK "$file name matches folder" || check FAIL "$file name is '$name'"
  [ -n "$desc" ] && check OK "$file has description" || check FAIL "$file has no description"
  if [ -n "$desc" ] && [ "${#desc}" -gt 1024 ]; then
    check FAIL "$file description is ${#desc} chars (>1024)"
  fi
done

echo "Reference checks"
for ref in config-schema connectors-by-platform scheduling-by-platform output-template validation privacy shared-helpers; do
  [ -f "skills/references/$ref.md" ] && check OK "references/$ref.md" || check FAIL "references/$ref.md"
done

echo "JSON checks"
for json in config.example.json weekly-1-1-updates-plugin/.claude-plugin/plugin.json; do
  if python3 -m json.tool "$json" >/dev/null 2>&1; then check OK "$json"; else check FAIL "$json"; fi
done

echo "Config contract checks"
if python3 - <<'PY'
import json, sys
with open('config.example.json', encoding='utf-8') as f:
    config = json.load(f)
employees = config.get('employees', {}).values()
ok = (
    config.get('calendar', {}).get('scope') == 'manager'
    and config.get('settings', {}).get('alignment_marker') == '\U0001f7e7'
    and config.get('settings', {}).get('manager_section_title') == 'Points for Alignment'
    and all('calendar_query' in person.get('one_on_one', {}) for person in employees)
    and all('day' not in person.get('one_on_one', {}) for person in employees)
    and 'calendar.search' in config.get('connectors_required', [])
    and '{date}' in config.get('wiki', {}).get('page_pattern', '')
)
sys.exit(0 if ok else 1)
PY
then
  check OK "calendar dates, marker, heading and page pattern configured"
else
  check FAIL "config contract mismatch"
fi

echo "Portability checks (no personal identifiers in portable files)"
if grep -rInE 'David Hoffmann|Marc Garcia|gdcgroup|BonusFinder|logo_align|BCR-' \
    --include='*.md' --include='*.json' --include='*.sh' \
    --exclude=validate.sh --exclude-dir=.git --exclude-dir=dist . 2>/dev/null; then
  check FAIL "personal identifiers found"
else
  check OK "no personal identifiers found"
fi

echo "Product-name checks"
if grep -rInE 'Octopus|octopus' \
    --include='*.md' --include='*.json' --include='*.sh' \
    --exclude=validate.sh --exclude-dir=.git --exclude-dir=dist . 2>/dev/null; then
  check FAIL "legacy product name found"
else
  check OK "no legacy product names"
fi

echo "Marker checks"
if grep -rInF '🎯' \
    --include='*.md' --include='*.json' --include='*.sh' \
    --exclude=validate.sh --exclude-dir=.git --exclude-dir=dist . 2>/dev/null; then
  check FAIL "deprecated alignment marker found"
else
  check OK "orange square marker only"
fi

echo
if [ "$fail" -eq 0 ]; then echo "Validation passed."; else echo "Validation FAILED."; exit 1; fi
