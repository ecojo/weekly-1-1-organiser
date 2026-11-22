# Amazon Quick test checklist

Use this to validate the skill in Quick desktop before submitting to the
central AI team. Record a pass/fail and any screenshot or output for each row.

## Before you start

- Import `SKILL.md` from this folder as a skill, and `manual/SKILL.md` as a
  second skill.
- Copy the synthetic inputs from `examples/fixture/` into a working folder.
- For connected tests, use a **test Confluence space** and a test Outlook
  calendar with events for `Alex Example` on **25 Nov 2026** and
  `Sam Example` on **27 Nov 2026**.
- Never test against real employee 1:1 pages.

## A. Manual variant (no connectors)

| # | Action | Expected result | Pass? |
|---|---|---|---|
| A1 | Start the manual skill and paste `issues.md`, `feedback-email.md`, `chat.md` and `previous-page.md`. Give meeting date 25 Nov 2026. | Asks for all required inputs, including the meeting date; does not assume a weekday. | |
| A2 | Compare the generated draft with `examples/fixture/expected-output.md`. | Matches: three section header rows, `DEMO-101` in Blockers despite its old date, `DEMO-112` excluded, `DEMO-103` not duplicated, `🟧` on DEMO-101/120, `⏳` on DEMO-121. | |
| A3 | Check the manager section. | "Points for Alignment" and both bullets are unchanged below `----`. | |
| A4 | Check the reported page name. | `Alex Example - Manager 1:1 - 25 Nov 2026`, with a clear note that no page was created. | |
| A5 | Run the four cases in `examples/fixture/manager-section-cases.md`. | Custom headings, three-hyphen dividers and missing sections handled exactly as specified; no manager text is overwritten. | |

## B. Connected variant (employee mode)

| # | Action | Expected result | Pass? |
|---|---|---|---|
| B1 | Connect Jira, Outlook mail, Outlook calendar and Confluence; run for Alex Example. | Meeting date resolves to the Outlook event (25 Nov 2026), not a fixed day. | |
| B2 | Check the constructed page name in the response. | `Alex Example - Manager 1:1 - 25 Nov 2026` plus the page link and the event title/date source. | |
| B3 | Delete that page in the test space and re-run. | The skill creates it under `wiki.parent_page` and then populates it; parent index untouched. | |
| B4 | Compare page content with the golden output. | Same as A2; manager title preserved. | |
| B5 | Check page permissions. | Only the manager and Alex can view it. | |
| B6 | Revoke only the calendar connection and re-run. | Asks for a date or uses `date_override`; does not invent a weekday. | |
| B7 | Put a custom heading such as "Points for Alignment — Q1 priorities" in the manager section and re-run. | Heading and notes are unchanged; no second heading is added. | |

## C. Manager mode

| # | Action | Expected result | Pass? |
|---|---|---|---|
| C1 | Run manager mode for Alex and Sam in one go. | Two different dates used: 25 Nov and 27 Nov 2026. Neither person's date is reused. | |
| C2 | Check both page names and summaries. | `Alex Example - Manager 1:1 - 25 Nov 2026` and `Sam Example - Manager 1:1 - 27 Nov 2026`, each with its own link and short summary. | |
| C3 | Simulate a failure for Sam's board. | Alex still completes; Sam's failure reported per person. | |

## D. Routine

| # | Action | Expected result | Pass? |
|---|---|---|---|
| D1 | Create a daily 08:00 Routine on a test calendar with 1:1s on two different days, then use **Run now**. | Only that day's 1:1(s) are prepared; dates come from Outlook. | |
| D2 | Check Agent Files / briefing page. | Page name and link visible; no credentials in output. | |

## Submission pack

Attach to the central AI team submission:

- `QUICK_SETUP.md`, this checklist and the completed results table;
- `../../SECURITY.md` and the root README data-flow description;
- `../../config.example.json` (neutral placeholders only);
- the fixture input files and `expected-output.md`;
- one redacted screenshot of a generated page and its constructed name.
