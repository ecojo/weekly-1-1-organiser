# Codex CLI / IDE

Codex reads skills from `.agents/skills/` in the working directory and its
parents, and from `$HOME/.agents/skills/` for user-wide availability.

## Install

```sh
# From this repository
npx skills add ecojo/weekly-1-1-organiser --skill weekly-1-1-organiser

# Or copy the generated tree
cp -R adapters/codex/skills/. .agents/skills/
```

Invoke with `$weekly-1-1-organiser` or `/skills`. Codex can also select the
skill automatically when the description matches.

## Connectors

Configure MCP servers for Jira, Confluence, Outlook and chat in
`~/.codex/config.toml` or via a plugin. If a capability is unavailable, use
the manual variant with pasted data.

## Scheduling

Codex has no skill-level scheduler. Use OS cron or CI to run the CLI on a
schedule, keeping config in the repository or a secret store. See
`../../skills/references/scheduling-by-platform.md`.
