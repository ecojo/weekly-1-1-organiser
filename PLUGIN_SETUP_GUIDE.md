# Setup guide (Claude)

This guide covers installing the Claude plugin generated in
`weekly-1-1-updates-plugin/`. For Amazon Quick see
[`adapters/amazon-quick/QUICK_SETUP.md`](adapters/amazon-quick/QUICK_SETUP.md).

## Install

1. Download `weekly-1-1-organiser.plugin` from the latest release, or add this
   repository as a plugin marketplace:

   ```text
   /plugin marketplace add ecojo/weekly-1-1-organiser
   /plugin install weekly-1-1-organiser
   ```

2. In Claude Cowork you can alternatively drag the `.plugin` file into the
   chat and choose **Install**.
3. Confirm the following skills appear: `weekly-1-1-organiser`,
   `weekly-1-1-organiser-manual`, `setup-wizard`, `manager-updates`,
   `scaffolder`.

## Connectors

Required: an issue tracker (e.g. Jira), a wiki (e.g. Confluence) with write
access, and Outlook mail **and calendar**. The calendar event determines the
meeting date and therefore the page name. Optional: Slack or Teams.

If the calendar connector is unavailable, set `one_on_one.date_override` for
each employee or supply the date when running. The skill never assumes a
weekday. If a connector is missing for another input, use the manual variant
for that input.

## Configure

1. Run **setup-wizard**.
2. Provide team name, timezone, manager name and email.
3. Add each employee: name, email, issue query/boards, feedback-email pattern
   and the Outlook 1:1 event that identifies their meeting.
4. Review the discovered event list — title, employee, date/time — and confirm
   the mapping. Managers commonly have 1:1s on different days.
5. Provide the wiki space, page-title pattern, date format, parent page and
   manager-section title (default "Points for Alignment").
6. Review the summary and confirm. The config is saved for all other skills.

Use [`config.example.json`](config.example.json) as a reference. Keep your
filled-in config private.

## Run

- Employee: "Prep my 1:1"
- Manager: "Pull all my reports' updates"
- Scaffolder: "Create next quarter pages"
- No connectors: "Manual 1:1 prep" and paste the data.

The response reports the constructed page name and link. If the page did not
exist, the connected skill created it.

## Schedules

A daily early-morning scheduled task works best: it checks Outlook for that
day's 1:1s and prepares only the matching people. If your Claude plan supports
scheduled tasks, set the timezone from the config; otherwise trigger the
skills manually. See
[`skills/references/scheduling-by-platform.md`](skills/references/scheduling-by-platform.md).

## Updating

Re-run **setup-wizard** after changing team members, boards or meeting times.
Schedules may need to be recreated.

## Troubleshooting

- **Connector not found** — connect it in workspace settings, then re-run the wizard.
- **Wrong meeting date** — check `one_on_one.calendar_query` against the Outlook
  event title/attendees, or set an explicit `date_override`.
- **Wiki page not created** — check write permission on the space and that the
  constructed name matches `wiki.page_pattern`.
- **No issues returned** — check the configured query and assignee.
- **No feedback email** — check the subject pattern or folder; the skill will
  fall back to the latest available and label it.
