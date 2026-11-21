# Configuration schema

All skills read the same config. Store it in the host's preferred location
(workspace config file, secret store or in-conversation profile). **Never
commit a filled-in config to a public repository.**

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
| `employees[].one_on_one.day` | Weekday of the meeting | — (ask) |
| `employees[].one_on_one.time` | Local time of the meeting | — (ask) |
| `wiki.space` | Wiki space key | — (ask) |
| `wiki.page_pattern` | Title template with `{date}` and `{name}` | `{name} - Manager 1:1 - {date}` |
| `wiki.parent_page` | Index page title (never written to) | — |
| `wiki.date_format` | Date format for page titles | `DD MMM YYYY` |
| `settings.lookback_days` | Window for Completed / Pre-research / chat | `7` |
| `settings.alignment_marker` | Marker for feedback-aligned tickets | `🎯` |
| `settings.low_priority_marker` | Marker for Low priority tickets | `⏳` |
| `settings.max_rows` | Soft warning threshold for table size | `18` |
| `settings.target_rows` | Typical table size | `10–15` |
| `scaffold.frequency` | `quarterly` or `half_yearly` | `quarterly` |
| `scaffold.run_day_of_month` | Day of month for scaffold run | `1` |
| `scaffold.run_time` | Local time for scaffold run | `00:00` |
| `schedule.mode` | `employee`, `manager` or `manual` | `manual` |
| `connectors_required` | Capability names in use | derived from skills used |

## Placeholder values for public examples

Use these in docs, fixtures and tests:

- names: `Alex Example`, `Morgan Example`
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
  "employees": {
    "alex.example@example.com": {
      "name": "Alex Example",
      "issue_query": "assignee = currentUser() ORDER BY updated DESC",
      "feedback": { "pattern": "Alex 1:1 Weekly Feedback" },
      "one_on_one": { "day": "Wednesday", "time": "09:00" }
    }
  },
  "wiki": {
    "space": "DEMO",
    "page_pattern": "{name} - Manager 1:1 - {date}",
    "date_format": "DD MMM YYYY"
  },
  "settings": {
    "lookback_days": 7,
    "alignment_marker": "🎯",
    "low_priority_marker": "⏳",
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

Old configs used top-level `manager_mode`, `confluence` and a literal
`created_schedules` array. Map them as follows:

| Old | New |
|---|---|
| `manager_mode.manager_name` | `manager.name` |
| `manager_mode.manager_email` | `manager.email` |
| `confluence.space_key` | `wiki.space` |
| `confluence.date_format` | `wiki.date_format` |
| `employees.<email>.jira_boards` | `employees.<email>.issue_query` |
| `schedule.created_schedules` | `schedule.mode` + host scheduler config |
