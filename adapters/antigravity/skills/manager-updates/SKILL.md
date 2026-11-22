---
name: manager-updates
description: Pull weekly 1:1 updates for all direct reports using each person's Outlook meeting date, create or update their dated wiki page, and produce one short summary for the manager. Use when a manager asks for "team 1:1 updates", "pull all my reports' updates", "manager review" or "prepare for my 1:1s". Requires the saved team config from setup-wizard.
license: MIT
metadata:
  author: SiliconRA
  version: "1.1.0"
---

# Manager Updates

Generate 1:1 prep for every configured direct report in one run. Each report's
meeting date is resolved independently from the Outlook calendar — 1:1s are
often on different days.

## Process

1. Load the saved config. If missing, run `setup-wizard` first.
2. For each entry in `employees`, resolve **that person's** meeting date using
   `calendar.search` (or their `one_on_one.date_override`). Do not assume a
   shared weekday and do not reuse the previous person's date. See
   `../references/shared-helpers.md`.
3. For each person, run the same collection and bucketing logic as
   `weekly-1-1-organiser`, using their own issue query, feedback pattern and
   wiki page pattern.
4. Construct each page name from `wiki.page_pattern` + that person's meeting
   date. Create the page with `wiki.write` if it does not exist, or update the
   existing dated child page. Copy the manager's section below the divider
   (`----` or `---`) verbatim — including its exact title, custom wording and
   empty bullets — and restrict visibility to that employee and the manager.
   Never overwrite or regenerate that section.
5. Produce a manager summary containing, per person:
   - the constructed page name and link;
   - the meeting date and its source (calendar event or override);
   - three to five bullets (accomplishments, blockers, discussion topics);
   - anything that needs escalation.

## Failure handling

- If one person's calendar lookup fails, try their `date_override`; if neither
  works, ask for that date and continue with the others. Do not guess a date.
- If one person's data source fails, continue with the others and report the
  failure per person. Do not abort the whole run.
- If `wiki.write` is unavailable, return drafts with the exact page names that
  would be created, and say clearly that nothing was written.
- If no feedback email is found, use the most recent one with "(latest
  available)" and note it in the summary.

## Scheduling

A single daily Routine before the working day is usually simplest: it resolves
today's 1:1s and prepares only those people. Alternatively, create one Routine
per employee. See `../references/scheduling-by-platform.md`.

## Validation

Apply `../references/validation.md` to every generated page.

## References

- `../references/output-template.md` — page format
- `../references/validation.md` — checklist
- `../references/config-schema.md` — config fields
- `../references/connectors-by-platform.md` — tool mapping
- `../references/shared-helpers.md` — date and page helpers
- `../references/privacy.md` — permissions
