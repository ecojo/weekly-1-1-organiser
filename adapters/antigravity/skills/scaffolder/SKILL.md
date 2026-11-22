---
name: scaffolder
description: Pre-create wiki folders and blank 1:1 placeholder pages for the next quarter or half-year, using the dates of each employee's Outlook 1:1 series. Use monthly, or manually with "create next quarter pages", "scaffold 1:1 pages", "prepare placeholder pages". Requires wiki write access and a completed setup-wizard config.
license: MIT
metadata:
  author: SiliconRA
  version: "1.1.0"
---

# 1:1 Page Scaffolder

Create the folder structure and empty dated pages ahead of time so weekly runs
always have a page to write to. Page dates come from each employee's Outlook
1:1 series — the scaffolder does not assume a fixed weekday.

## What it creates

For each configured employee, in the configured wiki space:

```text
[Wiki space]
└── [Employee Name] 1:1s
    └── 2026
        ├── [Employee Name] - Manager 1:1 - [Date]  (blank)
        └── ...
```

- Page names are constructed from `wiki.page_pattern` + each occurrence date,
  formatted with `wiki.date_format`.
- New pages contain only the manager mention, the configured manager-section
  title and one empty bullet; the weekly skill fills them in.
- Permissions: manager plus that employee only.

## Timing

- `frequency`: quarterly (about 13 occurrences per person) or half-yearly
  (about 26).
- `run_day_of_month` and `run_time`: default 1st at 00:00.
- Always scaffold the **upcoming** period, including year boundaries.
- New employees added mid-cycle are picked up on the next run, or trigger
  manually.

## Process

1. Load config; run `setup-wizard` if missing.
2. Confirm `wiki.write` is available. If not, output the exact page names that
   would be created and stop — do not claim they exist.
3. For each employee, resolve their 1:1 series from `calendar.search` using
   `one_on_one.calendar_query` (or `date_override` for a one-off). Expand the
   recurrence across the upcoming period to get the occurrence dates. Employees
   may have different dates; handle each separately.
4. Compute each page name from `wiki.page_pattern` + occurrence date, skip
   names that already exist, and create the missing pages under
   `wiki.parent_page`.
5. Create year folders first, then pages, then permissions.
6. Report per employee: the created page names and links, the skipped count,
   and any dates that could not be derived from Outlook.

## Fallback when the calendar is unavailable

Do not guess a weekday. If no calendar series or override exists, list the
page names that would be created for a proposed set of dates and ask the user
to confirm or supply the dates. If `calendar.search` is missing entirely, ask
for the dates or skip scaffolding with a clear explanation.

## References

- `../references/config-schema.md` — scaffold and calendar fields
- `../references/shared-helpers.md` — date expansion and page-name rules
- `../references/scheduling-by-platform.md` — scheduling
- `../references/privacy.md` — page permissions
