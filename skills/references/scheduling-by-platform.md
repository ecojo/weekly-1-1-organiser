# Scheduling by platform

The 1:1 workflow is naturally recurring. Each host has a different mechanism;
use the one below and never assume a scheduler exists. Schedules should not be
tied to a fixed weekday: the Outlook event is the source of truth for each
meeting date, and different employees may meet on different days.

| Platform | Mechanism | Notes |
|---|---|---|
| Claude (app / Claude Code) | Scheduled tasks / Cowork schedules where available | Runs are tied to the workspace; verify timezone |
| ChatGPT | Tasks / scheduled actions where available | Availability varies by plan; otherwise manual |
| Codex CLI / IDE | No built-in scheduler; use OS cron or CI to invoke the CLI | Keep prompts and config in the repo |
| Antigravity | No skill-level scheduler; use OS cron or CI with the CLI | Skills can be loaded via SDK `skills_paths` |
| Amazon Quick | **Routines** | Cloud-based; runs even when the desktop app is closed |

## Recommended cadence

- `weekly-1-1-organiser` (connected): a **daily early-morning run** that checks
  Outlook for that day's 1:1s and prepares only the matching people. This
  handles changing dates and per-employee schedules automatically.
- `manager-updates`: the same daily run in manager mode, or one run shortly
  before each person's event if your host supports per-person schedules.
- `scaffolder`: monthly on `scaffold.run_day_of_month`, deriving dates from the
  calendar series.

Avoid creating a "every Wednesday" routine unless the team genuinely has one
shared meeting day. Prefer the daily calendar-driven pattern.

## Amazon Quick specifics

1. Create a custom agent with the skill attached and only the required
   connections, including the Outlook calendar.
2. Create a Routine that invokes that agent each working morning. The agent
   checks the calendar for today's 1:1s and prepares those people.
3. Optionally add one Routine per employee if you prefer fixed per-person
   timing, but still derive the meeting date from Outlook.
4. Store deliverables in Agent Files and, if enabled, surface them on the
   Agent briefing page.
5. Test with a "Run now" before relying on the schedule.

## General rules

- Always store the timezone explicitly in config.
- Resolve the date from the calendar at run time; do not bake a weekday into
  the prompt.
- Confirm created schedules with the user and list them.
- If scheduling is unavailable, document the manual trigger phrase instead
  of claiming automation.
- Re-run setup after changing meeting times, because some hosts require
  deleting and recreating schedules.
