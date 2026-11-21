---
name: weekly-1-1-organiser-manual
description: Prepare a weekly 1:1 update entirely from text the user pastes — no connectors or integrations required. Use for "manual 1:1 prep", "offline 1:1 update", "paste my tickets and write my 1:1", or when Jira/Confluence/email/chat tools are unavailable. Produces a Markdown draft to copy into any wiki or document. Part of SiliconRA Weekly 1:1 Organiser.
license: MIT
compatibility: Works in any Agent Skills host, including chat-only surfaces. Requires no external tools.
metadata:
  author: SiliconRA
  version: "1.0.0"
  product: "SiliconRA Weekly 1:1 Organiser"
---

# Weekly 1:1 Organiser — Manual

Generate the same structured 1:1 update as the connected variant, using only
information the user provides in the conversation.

## When to use

- No Jira / Confluence / email / chat connectors are available.
- You are reviewing the skill before granting connector access.
- You want a draft to edit before copying it into a wiki manually.

## Inputs to request

Ask for these up front, in one short numbered list. Accept pasted text,
tables, exported CSV, screenshots described in text, or file uploads. If the
user has a saved config, use it to pre-fill names and skip known questions.

1. **People** — employee name and manager name (or "Generic" placeholders).
2. **Issues** — a list with key, summary, status, priority and last-updated
   date. If dates are missing, say which buckets cannot be filtered reliably.
3. **Feedback** — the manager's latest feedback email or notes, including its
   date and any "next steps".
4. **Chat notes** — 4–6 recent highlights, or the raw channel text to filter.
5. **Previous page** — the existing 1:1 page, especially anything below the
   `---` divider, so the manager's section can be preserved.
6. **Settings** — lookback days (default 7), date format, and markers. If the
   user has no preference, use the defaults in
   `../references/config-schema.md`.

Do not continue until you have at least issues and feedback. If a source is
missing, produce the draft with a clearly labelled placeholder for that
section rather than inventing content.

## Processing

Apply exactly the same rules as the connected variant:

- No time filter on Issues / Blockers; lookback filter on Completed and
  Pre-research / In Progress; no duplicate rows between sections.
- Alignment marker only for tickets that map to the manager's "next steps".
- Low-priority marker for Low priority tickets.
- 10–15 rows typical; flag above 18.
- Preserve everything below the `---` divider byte-for-byte.

See `../references/output-template.md` for the layout and
`../references/validation.md` for the checklist.

## Output

Return a single Markdown fenced block the user can copy:

```
<draft page here>
```

Then, outside the block:

- list any assumptions you made;
- list missing inputs and what they should paste to fill each gap;
- remind them to keep the manager section private.

Do not claim to have written to any external system.

## References

- `../references/output-template.md` — exact page format
- `../references/validation.md` — pre-flight checklist
- `../references/config-schema.md` — defaults and placeholders
- `../references/privacy.md` — data handling
