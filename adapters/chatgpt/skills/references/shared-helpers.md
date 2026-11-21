# Shared rules

This file replaces the old `shared-utils` skill. It is **reference guidance**,
not an executable library. Do not attempt to call these as functions — they
describe the steps the agent should perform using available connectors.

## Issue collection

- `resolve_issue_query(employee)` — use `employees[].issue_query` from config;
  if absent, use "all issues assigned to this person".
- `apply_lookback(issue, days)` — keep blockers regardless of date; require
  `updated >= now - days` for Completed and Pre-research.
- `bucket(issue)` — assign exactly one section: Blockers > Completed >
  Pre-research. Never duplicate.
- `detect_alignment(issue, feedback)` — match explicit ticket keys first, then
  infer from named work items that clearly map to a ticket.

## Wiki operations

- `find_dated_page(space, pattern, date)` — exact title match first; if none,
  fall back to the most recent matching page and note the miss.
- `extract_manager_section(page)` — take everything after the `----` divider;
  preserve whitespace and empty bullets.
- `write_page(page, content)` — update the dated page only; verify permissions
  after writing where the connector supports it.

## Email

- `find_feedback(pattern_or_folder, employee)` — newest within the lookback
  window; fall back to most recent with "(latest available)".
- `extract_next_steps(email)` — quotes, bullet lists and action items under
  headings such as "Next steps", "Priorities" or "Focus".

## Dates

- `format_date(date, format)` — use configured `wiki.date_format`.
- `weekly_dates(start, end, weekday)` — all occurrences of the configured 1:1
  day inside the period.
- `next_period(frequency)` — upcoming quarter or half-year, including year
  boundaries.

## Errors

| Situation | Behaviour |
|---|---|
| Capability missing | Ask user to paste data; do not fabricate |
| No feedback found | Use latest available and label it |
| Wiki page missing | Use most recent match and note it |
| One employee fails | Continue with others; report per person |
| Write denied | Return a draft and say nothing was written |
