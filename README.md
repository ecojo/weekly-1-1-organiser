# SiliconRA Weekly 1:1 Organiser

A portable, config-driven Agent Skill that turns a week's issue-tracker work,
manager feedback, chat context and previous meeting notes into a structured
1:1 update — and writes it to the correct dated page in your wiki.

The target date is read from the Outlook 1:1 meeting event, so there is no fixed
weekday routine. A manager run resolves each employee's date independently. The
Confluence page name is built from the configured pattern and that date, and
the connected skill creates the page when it is missing.

## Why it exists

Most assistants can summarise your week. This skill produces a **specific
artefact**: a 1:1 page with feedback alignment markers, three-section ticket
bucketing, a 7-day filter where it matters, and the manager's notes preserved
below the divider. It works in any host that supports the open Agent Skills
format.

## Two variants

| Variant | Skill name | Inputs | Output |
|---|---|---|---|
| **Connected** | `weekly-1-1-organiser` | Jira/Confluence/email/Outlook calendar/chat connectors | Creates or updates the dated wiki page |
| **Manual** | `weekly-1-1-organiser-manual` | Text you paste into the chat | Markdown draft + page name to copy anywhere |

Both share the same rules, template and validation checklist in
[`skills/references/`](skills/references/).

Supporting skills: `setup-wizard`, `manager-updates`, `scaffolder`.
`shared-utils` is reference guidance rather than a triggerable skill.

## Install

| Platform | How | Details |
|---|---|---|
| **Amazon Quick** | Import `adapters/amazon-quick/` as a folder or zip, then attach to a custom agent and Routine | [Quick setup](adapters/amazon-quick/QUICK_SETUP.md) |
| **Claude** | `/plugin marketplace add ecojo/weekly-1-1-organiser` or drag the `.plugin` file into Cowork | [Setup guide](PLUGIN_SETUP_GUIDE.md) |
| **ChatGPT** | Upload the skill zip in **Plugins → Skills → Create**; `@`-mention to invoke | [ChatGPT/Codex notes](adapters/chatgpt/README.md) |
| **Codex CLI / IDE** | `npx skills add ecojo/weekly-1-1-organiser` or copy into `.agents/skills/` | [Codex notes](adapters/codex/README.md) |
| **Antigravity** | Copy into `.agents/skills/` or `~/.gemini/config/skills/` | [Antigravity notes](adapters/antigravity/README.md) |

Skill names are unprefixed (`weekly-1-1-organiser`,
`weekly-1-1-organiser-manual`, `setup-wizard`, `manager-updates`, `scaffolder`).
Remove any older `bf-`-prefixed copies before installing.

Preview what would be installed with:

```sh
npx skills add ecojo/weekly-1-1-organiser --list
```

## Quick start

1. Run **setup-wizard**: it finds your 1:1 events in Outlook, confirms which
   event belongs to each employee, and saves the config.
2. Ask "Prep my 1:1" (employee) or "Pull all my reports' updates" (manager).
   The skill uses the date of the relevant Outlook meeting.
3. The page is created or updated under the configured parent page, and its
   name and link are reported back. Review before the meeting.
4. For a no-connector demo, use the manual variant and paste the sample data
   from [`examples/fixture/`](examples/fixture/).

Configuration is supplied by the user at setup time. Start from
[`config.example.json`](config.example.json) — it contains only neutral
placeholders. See [`skills/references/config-schema.md`](skills/references/config-schema.md)
for every field.

## Required capabilities

`issues.search`, `mail.search`, `calendar.search`, `wiki.find`, `wiki.read`,
`wiki.write`. Optional: `chat.search`. Without a calendar connector, set
`one_on_one.date_override` or supply the meeting date explicitly; the skill
never guesses a weekday.

If a capability is unavailable, the skill asks for pasted data or switches to
the manual variant. It never invents content. See
[`skills/references/connectors-by-platform.md`](skills/references/connectors-by-platform.md).

## Repository layout

```text
skills/                     canonical skills + shared references
adapters/                   generated per-platform bundles
  amazon-quick/             importable skill, agent instructions, setup guide
  chatgpt/  codex/  antigravity/
weekly-1-1-updates-plugin/  Claude plugin (generated from skills/)
examples/fixture/           synthetic input + golden output
scripts/                    sync, pack and validate helpers
```

## Development

```sh
./scripts/validate.sh      # frontmatter and structure checks
./scripts/sync.sh          # regenerate adapters and plugin from skills/
./scripts/pack.sh          # build distributable zips in dist/
```

## Privacy

1:1 pages contain personnel information. Restrict each page to the manager
and the named employee, keep real config out of public repos, and review the
[security policy](SECURITY.md) before deploying to a team.

## Licence

MIT — Copyright (c) 2026 SiliconRA. See [LICENSE](LICENSE).
