---
name: scaffolder
description: Pre-create wiki folders and blank 1:1 placeholder pages for the next quarter or half-year. Use monthly, or manually with "create next quarter pages", "scaffold 1:1 pages", "prepare placeholder pages". Requires a wiki write connector and a completed setup-wizard config.
license: MIT
metadata:
  author: SiliconRA
  version: "1.0.0"
---

# 1:1 Page Scaffolder

Create the folder structure and empty dated pages ahead of time so weekly runs
always have a page to write to.

## What it creates

For each configured employee, in the configured wiki space:

```
[Wiki space]
└── [Employee Name] 1:1s
    └── 2026
        ├── [Employee Name] - Manager 1:1 - [Date]  (blank)
        └── ...
```

- Names use the configured `date_format` and `page_pattern`.
- Pages are blank, ready for the weekly skill to populate.
- Permissions: manager plus that employee only.

## Timing

- `frequency`: quarterly (13 pages per person) or half-yearly (26 pages).
- `run_day_of_month` and `run_time`: default 1st at 00:00.
- Always scaffold the **upcoming** period, including year boundaries.
- New employees added mid-cycle are picked up on the next run, or trigger
  manually.

## Process

1. Load config; run `setup-wizard` if missing.
2. Confirm `wiki.write` is available. If not, output the list of pages that
   would be created and stop — do not claim they exist.
3. Compute the period, derive weekly dates using the configured 1:1 day, and
   skip dates that already have a page.
4. Create year folders, then pages, then permissions.
5. Report created/skipped counts per employee.

## References

- `../references/config-schema.md` — scaffold fields
- `../references/scheduling-by-platform.md` — scheduling
- `../references/privacy.md` — page permissions
