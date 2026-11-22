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
| `mail.search` | Outlook / Exchange mail | Yes |
| `calendar.search` | Outlook calendar | Yes, unless every employee has a `date_override` |
| `chat.search` | Slack or Teams | No |

The Outlook event supplies the meeting date, which in turn determines the
Confluence page name. Grant the minimum scopes: read issues, read mail, read
calendar, read/write pages in the configured space. Do not grant
organisation-wide write access.

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
closed. This is the recommended replacement for the old scheduled task.

1. Create a Routine that invokes the custom agent **every working morning**
   (for example 08:00), with the timezone set explicitly.
2. The agent checks Outlook for that day's 1:1s and prepares only the matching
   people. This handles changing dates and managers whose reports meet on
   different days.
3. If you prefer per-person timing, create one Routine per employee, but still
   resolve the date from the calendar rather than hard-coding a weekday.
4. Store output in Agent Files; enable the briefing page if your team uses it.
5. Use **Run now** to test before relying on the schedule.

For the manager view, use the same daily Routine in manager mode. For
scaffolding, add a monthly Routine on day 1.

## 5. Test and review

Work through [`QUICK_TEST_CHECKLIST.md`](QUICK_TEST_CHECKLIST.md) and record
pass/fail results for the submission pack.

- Start with the **manual variant** and the synthetic fixture in
  `examples/fixture/`. Compare the result with `expected-output.md`.
- Then test the connected variant with real connectors on one employee.
- Confirm the meeting date came from the Outlook event and that the page name
  is `Alex Example - Manager 1:1 - 25 Nov 2026` for the fixture date.
- Confirm a missing page is created, the generated page is the **dated child
  page**, not the index, and its name and link are reported back.
- Confirm the manager's section below the divider is unchanged, including its
  "Points for Alignment" title.
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
| Wrong meeting date | `one_on_one.calendar_query` vs Outlook event title/attendees; or set `date_override` |
| Wrong page name | Config `wiki.page_pattern`, `wiki.date_format` and `wiki.space` |
| Page not created | Confluence write permission and parent page existence |
| Routine did not run | Timezone, enabled state, and agent publish status |
