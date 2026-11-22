---
name: weekly-1-1-organiser
description: Prepare a weekly 1:1 update from issue-tracker tickets, manager feedback email, wiki notes and chat context, then write it to the dated 1:1 page named from the Outlook meeting date. Use when asked to "prep my 1:1", "prepare weekly 1:1", "generate my 1:1 update", "pull my updates for 1:1", or before any recurring manager/employee one-to-one. Reads connected tools or falls back to pasted data. Part of SiliconRA Weekly 1:1 Organiser.
license: MIT
compatibility: Needs a host that supports Agent Skills. External systems are reached only through host-provided connectors; if a connector is unavailable, ask the user to paste the data instead.
metadata:
  author: SiliconRA
  version: "1.1.0"
  product: "SiliconRA Weekly 1:1 Organiser"
---

# Weekly 1:1 Organiser — Connected

Generate a structured, review-ready 1:1 update from the user's configured data
sources and write it to the correct dated 1:1 page. The meeting date always
comes from the Outlook 1:1 calendar event for this person — there is no fixed
weekday routine. In manager mode, each employee's date is resolved
independently.

This is the **connected** variant. If no connectors are available, use the
`weekly-1-1-organiser-manual` skill instead, which works entirely from pasted
text.

## Before you start

1. **Load configuration.** Look for a saved team config (see
   `../references/config-schema.md`). If none exists, run the `setup-wizard`
   skill or ask the user for the required values. Never invent identifiers.
2. **Check capabilities.** Determine which of these capabilities the host
   actually provides: `issues.search`, `mail.search`, `chat.search`,
   `calendar.search`, `wiki.find`, `wiki.read`, `wiki.write`.
   See `../references/connectors-by-platform.md` for how each maps to a
   platform's tools. If a capability is missing, ask the user to paste that
   input rather than failing or fabricating data. `calendar.search` is the
   normal source of the meeting date; if it is missing, use a configured
   `date_override` or ask the user for the date.
3. **Resolve the subject.** The config identifies whose 1:1 this is
   (`employee_name`, `manager_name`, issue boards/queries, wiki space, page
   pattern, feedback-email pattern). If the request is ambiguous, ask.

## Data collection

### 0. Meeting date — resolve this first

The target date is derived from the Outlook 1:1 meeting for this employee:

1. If `employees[].one_on_one.date_override` is set, use it and label the run
   "manual date override".
2. Otherwise call `calendar.search` for `one_on_one.calendar_query` (or
   `calendar.event_pattern` plus the employee name) in the configured scope,
   over `[today - calendar.lookback_days, today + calendar.lookahead_days]`.
3. Prefer an event whose attendees include the employee and the manager, then
   an exact title match, then the occurrence closest to today (upcoming first).
4. If several events remain equally likely, ask the user to confirm. In an
   unattended Routine, take the closest upcoming event and note the ambiguity.
5. If no event is found and there is no override, ask for the date. Do **not**
   fall back to a fixed weekday. A date inferred from the most recent wiki page
   is only a hint and must be labelled as such.

Run this step **per employee** in manager mode: 1:1s are frequently on
different days. Never reuse one person's date for another.

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

### 4. Wiki page name and creation

1. Format the resolved meeting date with `{{DATE_FORMAT}}`.
2. Construct the exact page name by rendering `{{PAGE_PATTERN}}` with `{name}` =
   employee name and `{date}` = the formatted meeting date. This constructed
   name is the contract between the skills: the agent creates the page when it
   is missing, so the user does not have to pre-create it manually.
3. Call `wiki.find` for `{{WIKI_SPACE}}` and that exact title:
   - **One match** — read it.
   - **No match** — create it with `wiki.write` as a child of `{{PARENT_PAGE}}`,
     restricted to the manager and this employee. Treat its manager section as
     empty (use the configured manager-section title plus one empty bullet).
   - **Several matches** — prefer the one under `{{PARENT_PAGE}}`; if still
     ambiguous, ask the user.
4. Never write to the parent index page itself.

Read the existing page and capture the raw text below the divider and after
the manager @mention, including the manager-section title. Preserve it
**exactly**, including empty bullets. See "Manager section — never overwrite
it" below.

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
that are not in the template.

### Manager section — never overwrite it

The manager's section is **read-only input**. The previous bug that wiped the
manager's "Points for Alignment" notes must not recur:

1. Find the divider line in the existing page. Accept both `----` and `---`
   (older pages use three hyphens) and copy the exact line you found.
2. Take the raw substring from immediately after the `@{{MANAGER_NAME}}`
   mention to the end of the page. This includes the manager-section title
   (for example "Points for Alignment"), any custom wording, empty bullets and
   all whitespace. Copy it **verbatim**.
3. Never regenerate, summarise, translate, normalise, reorder, deduplicate or
   "improve" any of it. Never substitute the configured title for an existing
   title, even if the wording differs, and never add a second title.
4. Only when the page is brand new, or the manager section is completely
   empty, seed it with `{{MANAGER_SECTION_TITLE}}` and one empty bullet. That
   is the **only** case where this skill writes a title itself.
5. For an **existing** page, if you cannot find a divider or the manager
   @mention, stop and ask the user for the page. Do not guess or rebuild the
   manager section. (Newly created pages use rule 4.)

## Writing back

- Existing page → update it in place.
- Missing page → create it with `wiki.write` using the constructed name, then
  write the draft. Creating the page is part of this skill; it is not a manual
  user step.
- Preserve page permissions (manager + employee).
- **Report outside the page**: the constructed page name and link/URL, the
  resolved meeting date and its source (calendar event title or override), a
  short summary, and any data sources you could not reach.

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
