---
name: manager-updates
description: Pull weekly 1:1 updates for all direct reports and produce one prep page per person plus a short summary for the manager. Use when a manager asks for "team 1:1 updates", "pull all my reports' updates", "manager review" or "prepare for my 1:1s". Requires the saved team config from setup-wizard.
license: MIT
metadata:
  author: SiliconRA
  version: "1.0.0"
---

# Manager Updates

Generate 1:1 prep for every configured direct report in one run.

## Process

1. Load the saved config. If missing, run `setup-wizard` first.
2. For each entry in `direct_reports`, run the same collection and bucketing
   logic as `weekly-1-1-organiser`, using that person's own boards, feedback
   pattern and page pattern.
3. Write each person's update to their **dated child page** in the configured
   wiki space. Preserve the manager's section below the `---` divider exactly.
   Restrict visibility to that employee and the manager.
4. Produce a manager summary containing, per person:
   - page link;
   - three to five bullets (accomplishments, blockers, discussion topics);
   - anything that needs escalation.

## Failure handling

- If one person's data source fails, continue with the others and report the
  failure per person. Do not abort the whole run.
- If `wiki.write` is unavailable, return drafts in the chat instead and say
  clearly that nothing was written.
- If no feedback email is found, use the most recent one with "(latest
  available)" and note it in the summary.

## Scheduling

Typically run on the morning of each 1:1. See
`../references/scheduling-by-platform.md`.

## Validation

Apply `../references/validation.md` to every generated page.

## References

- `../references/output-template.md` — page format
- `../references/validation.md` — checklist
- `../references/config-schema.md` — config fields
- `../references/connectors-by-platform.md` — tool mapping
- `../references/privacy.md` — permissions
