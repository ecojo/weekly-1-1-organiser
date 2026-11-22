# Synthetic fixture

Use these files to test the skill without real data or connectors. They
contain only invented names, keys and URLs.

| File | Purpose |
|---|---|
| `issues.md` | Issue-tracker export (10 tickets) |
| `feedback-email.md` | Manager feedback email with "next steps" |
| `chat.md` | Raw chat highlights |
| `previous-page.md` | Existing 1:1 page, including the manager section |
| `expected-output.md` | Golden output after applying all rules |

Assumed config: employee `Alex Example`, manager `Morgan Example`,
lookback 7 days from **21 Nov 2026**, date format `DD MMM YYYY`, markers
`🟧` (aligned) and `⏳` (low priority), manager-section title
"Points for Alignment".

The Outlook 1:1 event for Alex is on **25 Nov 2026** and Sam's is on
**27 Nov 2026** (different days, for manager-mode testing). The constructed
Confluence page names are:

```text
Alex Example - Manager 1:1 - 25 Nov 2026
Sam Example - Manager 1:1 - 27 Nov 2026
```

The connected skill creates each page if it does not exist and reports its name
and link outside the generated content. The manual variant reports the same
name without creating the page.

## What the golden output checks

- `DEMO-101` (old but open) stays in Blockers — no time filter there.
- `DEMO-112` (Done but older than 7 days) is excluded.
- `DEMO-103` (In Progress) appears only in Blockers, not Pre-research.
- `DEMO-101` and `DEMO-120` get the alignment marker from the email.
- `DEMO-121` gets the low-priority marker.
- Completed rows use the `✅ Done` marker regardless of Done/Resolved.
- The manager section below `----` is unchanged, including the
  "Points for Alignment" title and the empty bullet.
