# Amazon Quick setup

This bundle contains everything needed to run SiliconRA Weekly 1:1 Organiser
in Amazon Quick desktop.

## 1. Import the skill

1. Open **Customize → Skills**.
2. Choose **Create → From folder** and select this `adapters/amazon-quick`
   directory, or **From file** and select a zipped copy of it.
3. Review the generated `SKILL.md` and references, then save.
4. Open the skill's detail panel and choose **Try it** with the sample data in
   `examples/fixture/` before connecting any real systems.

The importable skill is at the root of this folder (`SKILL.md`). The offline
variant is in `manual/SKILL.md` and can be imported as a second skill.

## 2. Connections

In Quick, add only the connections you need:

| Capability | Quick connection | Required |
|---|---|---|
| `issues.search` | Jira (or other issue-tracker connection) | Yes |
| `wiki.find` / `read` / `write` | Confluence | Yes |
| `mail.search` | Outlook / Exchange | Yes |
| `chat.search` | Slack or Teams | No |
| `calendar.search` | Outlook calendar | No |

Grant the minimum scopes: read issues, read mail, read/write pages in the
configured space. Do not grant organisation-wide write access.

## 3. Custom agent

Create a custom agent (see `quick-agent-instructions.md` for a ready-to-paste
configuration):

- **Name**: Weekly 1:1 Organiser
- **Skills**: attach this skill (and the manual variant if desired)
- **Connections**: only those listed above
- **Spaces**: any space holding your team's meeting notes
- **Instructions**: use the text in `quick-agent-instructions.md`

Keep the agent private while testing, then publish and share it with the
manager and employees who need it.

## 4. Schedule with a Routine

Quick Routines run in the cloud, so they work even when the desktop app is
closed. This is the recommended replacement for the old Claude scheduled task.

1. Create a Routine that invokes the custom agent.
2. Set the cadence to the morning of each 1:1 (e.g. every Wednesday 08:00).
3. Set the timezone explicitly in the prompt or agent instructions.
4. Store output in Agent Files; enable the briefing page if your team uses it.
5. Use **Run now** to test before relying on the schedule.

For the manager view, add a second Routine before the first 1:1 of the day.
For scaffolding, add a monthly Routine on day 1.

## 5. Test and review

- Start with the **manual variant** and the synthetic fixture in
  `examples/fixture/`. Compare the result with `expected-output.md`.
- Then test the connected variant with real connectors on one employee.
- Confirm the generated page is the **dated child page**, not the index.
- Confirm the manager's section below the divider is unchanged.
- Confirm permissions are manager + employee only.

Record the results for your central AI team review pack together with
`SECURITY.md`, the data-flow description in the root README, and the neutral
`config.example.json`.

## Limits

- Quick desktop allows skills up to 6 MB; this bundle is far smaller.
- Skill activation is automatic when the description matches, or you can name
  the skill explicitly in the prompt.
- If a connector is unavailable, Quick cannot invent data — use the manual
  variant and paste the input.

## Troubleshooting

| Symptom | Check |
|---|---|
| Skill not listed | Re-import; ensure `SKILL.md` is at the folder root |
| Connector error | Connection missing or scopes too narrow |
| Wrong page updated | Config `page_pattern`/`wiki.space`; never write to the index page |
| Routine did not run | Timezone, enabled state, and agent publish status |
