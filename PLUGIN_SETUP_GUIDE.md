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

Required: an issue tracker (e.g. Jira) and a wiki (e.g. Confluence) with
write access. Required for feedback: Outlook or another mail connector.
Optional: Slack or Teams, and a calendar connector for meeting-time discovery.

Connect them in your workspace settings before running the wizard. If a
connector is missing, use the manual variant for that input.

## Configure

1. Run **setup-wizard**.
2. Provide team name, timezone, manager name and email.
3. Add each employee: name, email, issue query/boards, feedback-email pattern
   and 1:1 day/time.
4. Provide the wiki space, page-title pattern, date format and parent page.
5. Choose lookback days (default 7), markers, and whether to create the wiki
   folder structure.
6. Review the summary and confirm. The config is saved for all other skills.

Use [`config.example.json`](config.example.json) as a reference. Keep your
filled-in config private.

## Run

- Employee: "Prep my 1:1"
- Manager: "Pull all my reports' updates"
- Scaffolder: "Create next quarter pages"
- No connectors: "Manual 1:1 prep" and paste the data.

## Schedules

If your Claude plan supports scheduled tasks, create one for each 1:1 using
the timezone in the config. Otherwise trigger the skills manually. See
[`skills/references/scheduling-by-platform.md`](skills/references/scheduling-by-platform.md).

## Updating

Re-run **setup-wizard** after changing team members, boards or meeting times.
Schedules may need to be recreated.

## Troubleshooting

- **Connector not found** — connect it in workspace settings, then re-run the wizard.
- **Wiki page not created** — check write permission on the space and that the
  dated child page exists (run the scaffolder).
- **No issues returned** — check the configured query and assignee.
- **No feedback email** — check the subject pattern or folder; the skill will
  fall back to the latest available and label it.
