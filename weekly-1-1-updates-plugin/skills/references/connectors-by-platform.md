# Connector capability map

The skills never name a vendor tool directly. They ask for one of these
**capabilities** and this file maps it to each host.

| Capability | What it must do | Needed for |
|---|---|---|
| `issues.search` | Query issue tracker by assignee/board and return key, summary, status, priority, updated date | Connected |
| `mail.search` | Find messages by sender and subject pattern, returning date and body | Connected |
| `chat.search` | Read messages from configured channels within a date window | Optional |
| `calendar.search` | Find Outlook 1:1 events with title, date/time, attendees and recurrence | Connected (or use `date_override`) |
| `wiki.find` | Find pages by space and title | Connected |
| `wiki.read` | Read page content | Connected |
| `wiki.write` | Create or update a page and set permissions | Connected |

Calendar results drive both the meeting date and the page name. Without
`calendar.search`, the connected skill requires a configured `date_override`
or an explicitly supplied date; it never invents a weekday.

## Platform mapping

### Claude (app / Claude Code)

- Connect **Atlassian** (Jira + Confluence), **Microsoft 365** (Outlook mail and
  calendar), and optionally **Slack** or **Teams**.
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

- Use **Connections** in Quick for Jira, Confluence, Outlook/Exchange (mail and
  calendar) and Slack/Teams. Local MCP servers are supported as local
  connectors.
- Import the skill via `Customize > Skills > Create > From file` (a `.md` or
  `.zip`) or `From folder`.
- Attach the skill to a **custom agent**; give that agent only the connections
  it needs. See `adapters/amazon-quick/QUICK_SETUP.md`.
- A skill is limited to 6 MB on Quick desktop — this package is well under.

## Fallback rules (all platforms)

1. If a capability is missing, do **not** guess data or silently skip it.
2. Ask the user to paste the equivalent text, or switch to
   `weekly-1-1-organiser-manual`.
3. For a missing calendar, use `date_override` or ask for the meeting date.
4. If `wiki.write` is missing, return a Markdown draft with the exact page
   names that would be created, and say explicitly that nothing was written.
5. If a connector partially fails (for example, only one person's board),
   continue with the rest and report the failure.
6. Never ask the user to paste credentials. Connectors handle authentication.
