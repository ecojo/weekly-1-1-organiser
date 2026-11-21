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
`🎯` (aligned) and `⏳` (low priority).

## What the golden output checks

- `DEMO-101` (old but open) stays in Blockers — no time filter there.
- `DEMO-112` (Done but older than 7 days) is excluded.
- `DEMO-103` (In Progress) appears only in Blockers, not Pre-research.
- `DEMO-101` and `DEMO-120` get the alignment marker from the email.
- `DEMO-121` gets the low-priority marker.
- Completed rows use the `✅ Done` marker regardless of Done/Resolved.
- The manager section below `----` is unchanged, including the empty bullet.
