# Configuration schema

All skills read the same config. Store it in the host's preferred location
(workspace config file, secret store or in-conversation profile). **Never
commit a filled-in config to a public repository.**

Meeting dates are resolved from Outlook events, not from a fixed weekday. The
config identifies which event belongs to which person; manager runs may involve
several different dates.

## Fields

| Field | Meaning | Default |
|---|---|---|
| `team.name` | Display name for the team | — (ask) |
| `team.timezone` | IANA timezone for scheduling | — (ask) |
| `manager.name` | Manager's full name | — (ask) |
| `manager.email` | Manager's email address | — (ask) |
| `employees` | Map of email → employee settings | — (ask) |
| `employees[].name` | Employee's full name | — (ask) |
| `employees[].issue_query` | JQL/query or board list for this person | all assigned issues |
| `employees[].feedback.pattern` | Subject pattern for feedback email | `{Name} 1:1 Weekly Feedback` |
| `employees[].feedback.folder` | Optional shared mail folder | — |
| `employees[].one_on_one.calendar_query` | Outlook event title/attendee query for this person's 1:1 | `calendar.event_pattern` + employee name |
| `employees[].one_on_one.date_override` | Explicit `YYYY-MM-DD` fallback when no event is found | — |
| `calendar.scope` | Whose calendar to search: `manager`, `employee` or `both` | `manager` |
| `calendar.event_pattern` | Generic 1:1 event title fragment | `1:1` |
| `calendar.lookback_days` | Days before today to search for an in-progress meeting | `7` |
| `calendar.lookahead_days` | Days after today to search for the next meeting | `14` |
| `wiki.space` | Wiki space key | — (ask) |
| `wiki.page_pattern` | Title template with `{date}` and `{name}` | `{name} - Manager 1:1 - {date}` |
| `wiki.parent_page` | Parent/index page for new dated child pages (never overwritten) | — |
| `wiki.date_format` | Date format for page titles | `DD MMM YYYY` |
| `settings.lookback_days` | Window for Completed / Pre-research / chat | `7` |
| `settings.alignment_marker` | Marker for feedback-aligned tickets | `🟧` |
| `settings.low_priority_marker` | Marker for Low priority tickets | `⏳` |
| `settings.manager_section_title` | Heading inserted under `@manager` when the page has none | `Points for Alignment` |
| `settings.max_rows` | Soft warning threshold for table size | `18` |
| `settings.target_rows` | Typical table size | `10–15` |
| `scaffold.frequency` | `quarterly` or `half_yearly` | `quarterly` |
| `scaffold.run_day_of_month` | Day of month for scaffold run | `1` |
| `scaffold.run_time` | Local time for scaffold run | `00:00` |
| `schedule.mode` | `employee`, `manager` or `manual` | `manual` |
| `connectors_required` | Capability names in use | derived from skills used |

## How meeting dates are resolved

1. Use `date_override` if present (labelled as a manual override).
2. Otherwise search the configured Outlook calendar scope with
   `one_on_one.calendar_query` over the lookback/lookahead window.
3. Prefer events attended by both the employee and manager, then exact title
   matches, then the occurrence closest to today (upcoming first).
4. Ask the user if the match is ambiguous; in an unattended Routine, take the
   closest upcoming event and note the ambiguity.
5. Do not fall back to a weekday. A date guessed from the last wiki page is a
   labelled hint only.

## Page name construction

For every run, render `wiki.page_pattern` with `{name}` = the employee's name
and `{date}` = the resolved meeting date formatted with `wiki.date_format`.
That exact string is the page the skill reads, creates when missing, and
reports. See `shared-helpers.md`.

## Placeholder values for public examples

Use these in docs, fixtures and tests:

- names: `Alex Example`, `Morgan Example`, `Sam Example`
- emails: `alex.example@example.com`, `morgan.example@example.com`
- issue keys: `DEMO-101`
- wiki space: `DEMO`
- chat channels: `#demo-general`, `#demo-dev`

## Example (neutral)

```json
{
  "team": { "name": "Example Team", "timezone": "Europe/London" },
  "manager": {
    "name": "Morgan Example",
    "email": "morgan.example@example.com"
  },
  "calendar": {
    "scope": "manager",
    "event_pattern": "1:1",
    "lookback_days": 7,
    "lookahead_days": 14
  },
  "employees": {
    "alex.example@example.com": {
      "name": "Alex Example",
      "issue_query": "assignee = currentUser() ORDER BY updated DESC",
      "feedback": { "pattern": "Alex 1:1 Weekly Feedback" },
      "one_on_one": {
        "calendar_query": "Alex Example 1:1",
        "date_override": null
      }
    },
    "sam.example@example.com": {
      "name": "Sam Example",
      "issue_query": "assignee = currentUser() ORDER BY updated DESC",
      "feedback": { "pattern": "Sam 1:1 Weekly Feedback" },
      "one_on_one": {
        "calendar_query": "Sam Example 1:1",
        "date_override": null
      }
    }
  },
  "wiki": {
    "space": "DEMO",
    "parent_page": "Example Team 1:1s",
    "page_pattern": "{name} - Manager 1:1 - {date}",
    "date_format": "DD MMM YYYY"
  },
  "settings": {
    "lookback_days": 7,
    "alignment_marker": "🟧",
    "low_priority_marker": "⏳",
    "manager_section_title": "Points for Alignment",
    "target_rows": "10–15",
    "max_rows": 18
  },
  "scaffold": {
    "frequency": "quarterly",
    "run_day_of_month": 1,
    "run_time": "00:00"
  },
  "schedule": { "mode": "manual" }
}
```

## Migration from older configs

Old configs used top-level `manager_mode`, `confluence`, a literal
`created_schedules` array, and fixed `one_on_one.day` / `one_on_one.time`.
Map them as follows:

| Old | New |
|---|---|
| `manager_mode.manager_name` | `manager.name` |
| `manager_mode.manager_email` | `manager.email` |
| `confluence.space_key` | `wiki.space` |
| `confluence.date_format` | `wiki.date_format` |
| `employees.<email>.jira_boards` | `employees.<email>.issue_query` |
| `employees.<email>.one_on_one.day` | Outlook discovery → `one_on_one.calendar_query`; if unavailable, `date_override` |
| `employees.<email>.one_on_one.time` | read from the Outlook event; no config field |
| old target-emoji alignment marker | `settings.alignment_marker: "🟧"` |
| `schedule.created_schedules` | `schedule.mode` + host scheduler config |
