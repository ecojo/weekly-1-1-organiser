---
name: setup-wizard
description: Configure SiliconRA Weekly 1:1 Organiser for a team — collect team members, issue queries, feedback-email patterns, Outlook 1:1 meeting matches, wiki space and permissions, then save a reusable config and optionally create the wiki folder structure. Use first, before connected, manager or scaffolder skills. Trigger with "set up weekly 1:1", "configure 1:1 organiser", "setup wizard".
license: MIT
metadata:
  author: SiliconRA
  version: "1.1.0"
---

# Setup Wizard

Collect the configuration once, validate it, and save it so all other skills
can reuse it. No fixed meeting weekday is required: dates come from Outlook.

## What you will configure

1. **Team basics** — team name, manager name and email, timezone, calendar
   scope, and the optional model identifier (`runtime.llm`) if known.
2. **Team members** — name, email, issue boards/queries and the Outlook 1:1
   event that identifies their meeting.
3. **Feedback email** — subject pattern and/or shared folder.
4. **Wiki** — space key, page-title pattern, date format, parent folder, and
   manager-section title (default "Points for Alignment").
5. **Schedule** — whether to run automatically and by which platform mechanism.
6. **Scaffolding** — quarterly or half-yearly placeholder pages, dated from the
   calendar series rather than a hard-coded weekday.
7. **Permissions** — manager plus the individual employee only.

## Flow

1. **Check connectors.** For each capability you intend to use
   (`issues.search`, `mail.search`, `chat.search`, `calendar.search`,
   `wiki.find`, `wiki.read`, `wiki.write`), check whether the host provides
   it. See `../references/connectors-by-platform.md`. Record missing
   capabilities and tell the user which skills will need pasted data instead.
2. **Ask the questions** in `../references/config-schema.md`, in order. Do not
   guess values. Accept "use defaults" where a default exists. Record
   `runtime.llm` only if the user knows it; it is informational and does not
   change any behaviour.
3. **Discover meeting dates from Outlook.** Search the configured calendar
   scope for 1:1 events, then show the user a table of event title, employee,
   date/time and recurrence. Confirm which event belongs to which employee and
   store it as `one_on_one.calendar_query`. Where there is no calendar event,
   ask for an explicit `one_on_one.date_override` instead of a weekday.
   Different employees may have different dates — never collapse them into a
   single routine day.
4. **Show the full config** and ask for confirmation before making changes.
5. **Create wiki infrastructure** only if requested and the `wiki.write`
   capability exists: parent folder, employee subfolders, year folders, and
   placeholder pages derived from the confirmed calendar series.
6. **Save the config** in the location the host provides (a config file in the
   workspace, a secret store, or an in-conversation profile). Never commit
   real config to a public repo.
7. **Report** what was created, what was skipped, and which skills are ready.
   List the discovered meeting dates so the user can verify them.

## Updating

Re-run this skill at any time to change the config. Always show a diff of old
versus new values before saving, warn that scheduled runs may need to be
re-created, and re-check Outlook when meeting times change.

## Scheduling

Automatic runs depend on the host. See `../references/scheduling-by-platform.md`
for the correct mechanism per platform. Prefer a daily routine that checks the
calendar for that day's 1:1s; fall back to manual triggers where no scheduler
exists.

## References

- `../references/config-schema.md` — fields, defaults and config example
- `../references/connectors-by-platform.md` — capability mapping
- `../references/shared-helpers.md` — meeting-date and page-name helpers
- `../references/scheduling-by-platform.md` — scheduling options
- `../references/privacy.md` — permissions and data handling
