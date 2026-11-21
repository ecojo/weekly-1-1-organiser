# Connector capability map

The skills never name a vendor tool directly. They ask for one of these
**capabilities** and this file maps it to each host.

| Capability | What it must do |
|---|---|
| `issues.search` | Query issue tracker by assignee/board and return key, summary, status, priority, updated date |
| `mail.search` | Find messages by sender and subject pattern, returning date and body |
| `chat.search` | Read messages from configured channels within a date window |
| `wiki.find` | Find pages by space and title |
| `wiki.read` | Read page content |
| `wiki.write` | Create or update a page and set permissions |
| `calendar.search` | Find recurring "1:1" events (optional, used by setup wizard) |

## Platform mapping

### Claude (app / Claude Code)

- Connect **Atlassian** (Jira + Confluence), **Microsoft 365** (Outlook), and
  optionally **Slack** or **Teams**.
- In Claude Code these appear as MCP tools; in the Claude app as connectors.
- `wiki.write` requires a Confluence account with write permission on the
  target space.

### ChatGPT / Codex

- Use **apps/connectors** for Jira, Confluence, Outlook and chat. In Codex,
  MCP servers can be configured in `~/.codex/config.toml` or via a plugin.
- Standalone skills work in ChatGPT desktop and Codex CLI/IDE. Skills bundled
  in a plugin also reach ChatGPT web/mobile.
- Invoke with `@weekly-1-1-organiser` in ChatGPT or
  `$weekly-1-1-organiser` in Codex.
- If a connector is unavailable, switch to the manual variant.

### Google Antigravity

- Define MCP servers in `.agents/mcp_config.json` (workspace) or the personal
  config directory.
- Skills load from `.agents/skills/<name>/SKILL.md` or
  `~/.gemini/config/skills/<name>/SKILL.md`.
- Mention the skill by name to force activation.

### Amazon Quick

- Use **Connections** in Quick for Jira, Confluence, Outlook/Exchange and
  Slack/Teams. Local MCP servers are supported as local connectors.
- Import the skill via `Customize > Skills > Create > From file` (a `.md` or
  `.zip`) or `From folder`.
- Attach the skill to a **custom agent**; give that agent only the connections
  it needs. See `adapters/amazon-quick/QUICK_SETUP.md`.
- A skill is limited to 6 MB on Quick desktop — this package is well under.

## Fallback rules (all platforms)

1. If a capability is missing, do **not** guess data or silently skip it.
2. Ask the user to paste the equivalent text, or switch to
   `weekly-1-1-organiser-manual`.
3. If `wiki.write` is missing, return a Markdown draft and say explicitly
   that nothing was written.
4. If a connector partially fails (for example, only one person's board),
   continue with the rest and report the failure.
5. Never ask the user to paste credentials. Connectors handle authentication.
