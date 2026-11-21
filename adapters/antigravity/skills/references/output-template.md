# Output template

Use this exact structure for the generated 1:1 page. Replace `{{...}}`
placeholders with values from config and collected data.

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

{{MANAGER_SECTION_PRESERVED_EXACTLY}}
```

## Rules

- Three section header rows are mandatory, even if a section has no entries.
- Use the configured markers. Prefer Unicode emoji (`🎯`, `⏳`, `✅`) over
  wiki-specific shortcodes, which often fail to render through APIs.
- The divider is four hyphens on its own line: `----`.
- `{{MANAGER_SECTION_PRESERVED_EXACTLY}}` means the text below the divider on
  the existing page, copied byte-for-byte — including empty bullets.
- If there are no completions in the window, replace that section's rows with
  a single row: `| | No completions in the past {{LOOKBACK_DAYS}} days. | | |`.
- If no chat material exists, use one line: "No material chat activity in the
  past {{LOOKBACK_DAYS}} days."
- Do not add other sections, signatures or commentary to the page.

## Empty-manager-section case

If the existing page has no content below the divider, preserve the empty
manager mention and bullet:

```markdown
----

@{{MANAGER_NAME}}

*
```
