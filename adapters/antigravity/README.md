# Google Antigravity

Antigravity loads skills from `.agents/skills/<name>/SKILL.md` in the workspace
or from `~/.gemini/config/skills/<name>/` globally.

## Install

```sh
cp -R adapters/antigravity/skills/. .agents/skills/
```

The skill folder must sit directly inside `skills/` — Antigravity scans one
level deep. Mention the skill by name to force activation, or let it activate
when the description matches.

## Connectors

Define MCP servers in `.agents/mcp_config.json` (workspace) or the personal
config directory. Map them to the capabilities in
`../../skills/references/connectors-by-platform.md`.

## Scheduling

Antigravity has no skill-level scheduler. Use OS cron/CI with the CLI, or run
the skill from an Antigravity SDK agent on a timer. See
`../../skills/references/scheduling-by-platform.md`.
