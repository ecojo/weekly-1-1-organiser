# Shared rules

This file is **reference guidance**, not an executable library. Do not attempt
to call these as functions — they describe the steps the agent should perform
using available connectors.

## Issue collection

- `resolve_issue_query(employee)` — use `employees[].issue_query` from config;
  if absent, use "all issues assigned to this person".
- `apply_lookback(issue, days)` — keep blockers regardless of date; require
  `updated >= now - days` for Completed and Pre-research.
- `bucket(issue)` — assign exactly one section: Blockers > Completed >
  Pre-research. Never duplicate.
- `detect_alignment(issue, feedback)` — match explicit ticket keys first, then
  infer from named work items that clearly map to a ticket.

## Meeting dates and page names

- `resolve_meeting_date(employee, config)` — run per employee:
  1. `date_override` wins, labelled "manual date override".
  2. Call `calendar.search` with `one_on_one.calendar_query` (or
     `calendar.event_pattern` + employee name) in `calendar.scope`, from
     `today - calendar.lookback_days` to `today + calendar.lookahead_days`.
  3. Rank: attendees include employee + manager → exact title → closest
     occurrence to today (upcoming first). Ask if still ambiguous; an
     unattended run takes the closest upcoming event and notes it.
  4. No event and no override → ask for the date. Never use a fixed weekday.
- `format_date(date, format)` — use `wiki.date_format`.
- `build_page_name(employee, meeting_date, config)` — render
  `wiki.page_pattern` with `{name}` = employee name and `{date}` =
  `format_date(meeting_date)`. This is the exact page name to find, create and
  report.
- `expand_series(employee, period)` — expand the Outlook recurrence across the
  scaffold period to get occurrence dates; never derive them from a weekday.
- `next_period(frequency)` — upcoming quarter or half-year, including year
  boundaries.

## Wiki operations

- `find_or_create_page(config, page_name)` — call `wiki.find` in
  `wiki.space`. One match → use it. None → create it with `wiki.write` as a
  child of `wiki.parent_page`, with manager + employee permissions and a stub
  manager section. Several → prefer the one under `wiki.parent_page`, else ask.
- `extract_manager_section(page)` — take everything below the `----` divider
  and after the `@manager` mention. Preserve whitespace and empty bullets.
- `apply_manager_title(existing_section, config)` — keep an existing title
  line (for example "Points for Alignment") exactly; if absent, insert
  `settings.manager_section_title` before the preserved notes.
- `write_page(page, content)` — update the dated page only; verify permissions
  after writing where the connector supports it.
- `report_page(page_name, link, meeting_date, source)` — include these in the
  reply outside the page content. The page name is constructed by the skill,
  not supplied by the user.

## Email

- `find_feedback(pattern_or_folder, employee)` — newest within the lookback
  window; fall back to most recent with "(latest available)".
- `extract_next_steps(email)` — quotes, bullet lists and action items under
  headings such as "Next steps", "Priorities" or "Focus".

## Errors

| Situation | Behaviour |
|---|---|
| Calendar capability missing | Use `date_override` or ask for the date |
| Meeting event ambiguous | Ask, or take closest upcoming and note it in a Routine |
| No feedback found | Use latest available and label it |
| Wiki page missing | Create it with `wiki.write` from the constructed name |
| No wiki write capability | Return draft + exact page names; say nothing was written |
| One employee fails | Continue with others; report per person |
| Write denied | Return a draft and say nothing was written |
