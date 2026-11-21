# Scheduling by platform

The 1:1 workflow is naturally recurring. Each host has a different mechanism;
use the one below and never assume a scheduler exists.

| Platform | Mechanism | Notes |
|---|---|---|
| Claude (app / Claude Code) | Scheduled tasks / Cowork schedules where available | Runs are tied to the workspace; verify timezone |
| ChatGPT | Tasks / scheduled actions where available | Availability varies by plan; otherwise manual |
| Codex CLI / IDE | No built-in scheduler; use OS cron or CI to invoke the CLI | Keep prompts and config in the repo |
| Antigravity | No skill-level scheduler; use OS cron or CI with the CLI | Skills can be loaded via SDK `skills_paths` |
| Amazon Quick | **Routines** | Cloud-based; runs even when the desktop app is closed. Best fit for "every Wednesday" |

## Recommended cadence

- `employee-update` / connected skill: before each person's 1:1, e.g. the
  morning of their configured day.
- `manager-updates`: shortly before the manager's first 1:1 of the day, or
  once for the whole team.
- `scaffolder`: monthly on `scaffold.run_day_of_month`.

## Amazon Quick specifics

1. Create a custom agent with the skill attached and only the required
   connections.
2. Create a Routine that invokes that agent on the chosen schedule.
3. Store deliverables in Agent Files and, if enabled, surface them on the
   Agent briefing page.
4. Test with a "Run now" before relying on the schedule.

## General rules

- Always store the timezone explicitly in config.
- Confirm created schedules with the user and list them.
- If scheduling is unavailable, document the manual trigger phrase instead
  of claiming automation.
- Re-run setup after changing meeting times, because some hosts require
  deleting and recreating schedules.
