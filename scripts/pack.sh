#!/usr/bin/env bash
# Build distributable archives from generated adapters.
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

"$ROOT/scripts/sync.sh" >/dev/null
mkdir -p dist
rm -f dist/*.zip

zip -qr dist/weekly-1-1-organiser-claude-plugin.zip weekly-1-1-updates-plugin -x '*.DS_Store'

# Importable archives: SKILL.md must be at the archive root.
(cd adapters/amazon-quick && zip -qr ../../dist/weekly-1-1-organiser-amazon-quick.zip . -x '*.DS_Store')
(cd adapters/chatgpt/skills && zip -qr ../../../dist/weekly-1-1-organiser-chatgpt.zip . -x '*.DS_Store')
(cd adapters/codex/skills && zip -qr ../../../dist/weekly-1-1-organiser-codex.zip . -x '*.DS_Store')
(cd adapters/antigravity/skills && zip -qr ../../../dist/weekly-1-1-organiser-antigravity.zip . -x '*.DS_Store')

# Claude Cowork / Claude Code drag-and-drop plugin bundle.
rm -f weekly-1-1-updates.plugin
(cd weekly-1-1-updates-plugin && zip -qr ../weekly-1-1-organiser.plugin . -x '*.DS_Store')

echo "Archives written to dist/ and weekly-1-1-organiser.plugin"
