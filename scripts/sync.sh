#!/usr/bin/env bash
# Regenerate platform adapters and the Claude plugin from the canonical skills/.
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

CANON="$ROOT/skills"
SKILLS=(weekly-1-1-organiser weekly-1-1-organiser-manual setup-wizard manager-updates scaffolder)

# Remove obsolete skill folders from earlier package layouts.
rm -rf "$CANON/employee-update" "$CANON/shared-utils"
rm -f "$ROOT/.DS_Store" "$ROOT/weekly-1-1-updates-plugin/.DS_Store"

copy_skill_set() {
  local dest="$1"
  rm -rf "$dest"
  mkdir -p "$dest"
  for skill in "${SKILLS[@]}"; do
    mkdir -p "$dest/$skill"
    cp "$CANON/$skill/SKILL.md" "$dest/$skill/SKILL.md"
  done
  cp -R "$CANON/references" "$dest/references"
}

# Claude plugin
copy_skill_set "$ROOT/weekly-1-1-updates-plugin/skills"

# Generic Agent Skills adapters (Codex, Antigravity, ChatGPT source tree)
for platform in chatgpt codex antigravity; do
  copy_skill_set "$ROOT/adapters/$platform/skills"
done

# Amazon Quick: a single importable folder with SKILL.md at its root.
QUICK="$ROOT/adapters/amazon-quick"
rm -rf "$QUICK/references" "$QUICK/manual"
mkdir -p "$QUICK/manual"
sed 's|\.\./references/|references/|g' \
  "$CANON/weekly-1-1-organiser/SKILL.md" > "$QUICK/SKILL.md"
sed 's|\.\./references/|../references/|g' \
  "$CANON/weekly-1-1-organiser-manual/SKILL.md" > "$QUICK/manual/SKILL.md"
cp -R "$CANON/references" "$QUICK/references"

echo "Synced plugin and adapters from skills/."
