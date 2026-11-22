# Output template

Use this exact structure for the generated 1:1 page. Replace `{{...}}`
placeholders with values from config, the resolved Outlook meeting date and
collected data. The page name itself is reported separately, outside the page.

```markdown
@{{EMPLOYEE_NAME}}

**Data source:** {{ISSUE_SYSTEM}} ({{N}} tickets), {{MANAGER_NAME}}'s feedback ({{EMAIL_DATE}}), {{CHAT_SOURCE}}, {{WIKI_SOURCE}}

## 1-1 Update

{{ALIGNMENT_MARKER}} Alignment with next steps From {{MANAGER_NAME}} — {{EMAIL_DATE}}

| Ticket | Summary | Status | Notes |
|--------|---------|--------|-------|
| | **Issues / Blockers** | | |
| {{ALIGNMENT_MARKER_IF_ALIGNED}} [{{ISSUE_KEY}}]({{ISSUE_URL}}) | {{SUMMARY}} | {{STATUS}} | {{NOTES}} |
| | **Completed This Week** | | |
| [{{ISSUE_KEY}}]({{ISSUE_URL}}) | {{SUMMARY}} | ✅ Done | {{NOTES}} |
| | **Pre-research / In Progress** | | |
| [{{ISSUE_KEY}}]({{ISSUE_URL}}) | {{SUMMARY}} | {{LOW_PRIORITY_MARKER_IF_LOW}} | {{NOTES}} |

## Slack / General notes

**Last {{LOOKBACK_DAYS}} days:**
- {{CHAT_BULLET}}
- {{CHAT_BULLET}}
- {{CHAT_BULLET}}

----

@{{MANAGER_NAME}}

{{MANAGER_SECTION_TITLE}}

{{MANAGER_SECTION_PRESERVED_EXACTLY}}
```

## Rules

- Three section header rows are mandatory, even if a section has no entries.
- Use the configured markers. Prefer Unicode emoji (`🟧`, `⏳`, `✅`) over
  wiki-specific shortcodes, which often fail to render through APIs.
- For a new page the divider is four hyphens on its own line: `----`. If the
  existing page uses three (`---`), copy that exact line — never normalise it.
- `{{MANAGER_SECTION_TITLE}}` is `settings.manager_section_title` (default
  "Points for Alignment"). It is written **only** for a new page or a
  completely empty manager section.
- An existing title under the @mention is copied verbatim, even if it says
  something different (for example "Points for Alignment — Q1 priorities").
  Never replace it, add a second title, or reorder the notes.
- `{{MANAGER_SECTION_PRESERVED_EXACTLY}}` is the raw substring from after the
  `@{{MANAGER_NAME}}` mention to the end of the page, copied byte-for-byte —
  including the existing title, custom wording and empty bullets.
- If there are no completions in the window, replace that section's rows with
  a single row: `| | No completions in the past {{LOOKBACK_DAYS}} days. | | |`.
- If no chat material exists, use one line: "No material chat activity in the
  past {{LOOKBACK_DAYS}} days."
- Do not add other sections, signatures or commentary to the page.

## Empty-manager-section case

For a newly created page with no notes below the divider, write:

```markdown
----

@{{MANAGER_NAME}}

{{MANAGER_SECTION_TITLE}}

*
```

## Reporting the page

Outside the fenced page content, report:

- **Page name:** the constructed `wiki.page_pattern` string with the meeting
  date (for example `Alex Example - Manager 1:1 - 25 Nov 2026`).
- **Page link:** the URL returned by the wiki connector, if available.
- **Meeting date:** the resolved date and its source (Outlook event title or
  manual override).
