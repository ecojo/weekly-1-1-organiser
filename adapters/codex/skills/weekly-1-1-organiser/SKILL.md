---
name: weekly-1-1-organiser
description: Prepare a weekly 1:1 update from issue-tracker tickets, manager feedback email, wiki notes and chat context, then write it to the dated 1:1 page. Use when asked to "prep my 1:1", "prepare weekly 1:1", "generate my 1:1 update", "pull my updates for 1:1", or before any recurring manager/employee one-to-one. Reads connected tools or falls back to pasted data. Part of SiliconRA Weekly 1:1 Organiser.
license: MIT
compatibility: Needs a host that supports Agent Skills. External systems are reached only through host-provided connectors; if a connector is unavailable, ask the user to paste the data instead.
metadata:
  author: SiliconRA
  version: "1.0.0"
  product: "SiliconRA Weekly 1:1 Organiser"
---

# Weekly 1:1 Organiser — Connected

Generate a structured, review-ready 1:1 update from the user's configured data
sources and write it to the correct dated 1:1 page.

This is the **connected** variant. If no connectors are available, use the
`weekly-1-1-organiser-manual` skill instead, which works entirely from pasted
text.

## Before you start

1. **Load configuration.** Look for a saved team config (see
   `../references/config-schema.md`). If none exists, run the `setup-wizard`
   skill or ask the user for the required values. Never invent identifiers.
2. **Check capabilities.** Determine which of these capabilities the host
   actually provides: `issues.search`, `mail.search`, `chat.search`,
   `wiki.find`, `wiki.read`, `wiki.write`.
   See `../references/connectors-by-platform.md` for how each maps to a
   platform's tools. If a capability is missing, ask the user to paste that
   input rather than failing or fabricating data.
3. **Resolve the subject.** The config identifies whose 1:1 this is
   (`employee_name`, `manager_name`, issue boards/queries, wiki space, page
   pattern, feedback-email pattern). If the request is ambiguous, ask.

## Data collection

Collect all four sources before drafting:

### 1. Issues (issue tracker)

Run the configured query for `{{ASSIGNEE}}` across `{{ISSUE_QUERY_OR_BOARDS}}`.
Pull real summaries and statuses. The query itself must have **no time filter**,
so long-running blockers remain visible; apply the 7-day rule client-side when
bucketing (below).

### 2. Manager feedback email

Find the latest message from `{{MANAGER_EMAIL}}` matching
`{{FEEDBACK_PATTERN}}` within `{{LOOKBACK_DAYS}}`. If none exists in that
window, use the most recent one and mark the date "(latest available)".

Extract:
- feedback and priorities;
- explicit "next steps" — used for alignment markers;
- action items and anything flagged for discussion.

### 3. Chat context

Read the configured channels from the last `{{LOOKBACK_DAYS}}` days. Pick 4–6
decision-bearing human bullets; skip pure bot noise unless it is urgent and
affects the person's open work. If nothing material, say so explicitly.

### 4. Wiki page

Find the **dated child page** for this 1:1, not the parent index:

1. Compute the date string using `{{DATE_FORMAT}}`.
2. Look up `{{WIKI_SPACE}}` and title `{{PAGE_PATTERN}}` with that date.
3. If exactly one match, use it. If none, use the most recent matching page,
   and add a note that the dated page was missing.
4. Read the existing page and capture everything below the `---` divider
   (the manager's section). Preserve it **exactly**, including empty bullets.
   Never overwrite the parent index page.

## Bucketing rules (critical)

Build a four-column table: `Ticket | Summary | Status | Notes`.

| Section | Include | Time filter |
|---|---|---|
| Issues / Blockers | Open states: Blocked, At Risk, In Progress, In Review | **None** — blockers stay visible |
| Completed This Week | Done / Resolved / Closed | `updated >= today - {{LOOKBACK_DAYS}}` |
| Pre-research / In Progress | To Do, Pre-research, Low Priority | `updated >= today - {{LOOKBACK_DAYS}}`; exclude anything already in Blockers |

- Sort Blockers by urgency; Completed by update date, newest first.
- Keep the whole table around 10–15 rows. If it exceeds 18, the date filter
  has been applied too loosely — re-check `updated`.
- If Completed is empty, write one row: "No completions in the past
  {{LOOKBACK_DAYS}} days."

## Markers

- **Alignment marker** `{{ALIGNMENT_MARKER}}` — prefix the Ticket cell when the
  ticket maps to a "next step" in the feedback email. Infer alignment when the
  email names a work item that clearly corresponds to a ticket. Use the marker
  configured for the platform; a Unicode emoji is safer than a wiki shortcode
  because shortcodes often do not render through APIs.
- **Low-priority marker** `{{LOW_PRIORITY_MARKER}}` — add for Low priority
  tickets.
- Keep all other statuses as plain text.

## Output

Draft the page using `../references/output-template.md`. Do not add sections
that are not in the template. The manager section below the divider must be
byte-for-byte what was read from the existing page.

## Writing back

Write the new content to the dated child page only. Preserve page permissions
(manager + employee). Report the page link and a short summary to the user so
they can review and edit before the meeting.

## Validation

Before finishing, run the checklist in `../references/validation.md`. Fix any
failure before reporting success.

## References

- `../references/config-schema.md` — configuration fields and storage
- `../references/connectors-by-platform.md` — tool capability mapping
- `../references/scheduling-by-platform.md` — recurring-run options
- `../references/output-template.md` — exact page format
- `../references/validation.md` — pre-flight checklist
- `../references/shared-helpers.md` — rules used across the skill set
- `../references/privacy.md` — data handling and permissions
