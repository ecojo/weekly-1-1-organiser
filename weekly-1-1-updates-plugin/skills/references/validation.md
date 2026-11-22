# Validation checklist

Run before writing, and again after writing if the host exposes a read-back.

## Meeting date and page

- [ ] The meeting date came from the employee's Outlook 1:1 event, or a
      `date_override` was used and labelled. No fixed weekday was assumed.
- [ ] In manager mode, every employee's date was resolved separately.
- [ ] The page name was constructed from `wiki.page_pattern` + that date in
      `wiki.date_format`.
- [ ] A missing page was created with `wiki.write` under `wiki.parent_page`;
      the parent index was never overwritten.
- [ ] The final report includes the constructed page name, its link (if
      available), the meeting date and its source.

## Content

- [ ] Wrote to the **dated child page**, not the parent index page.
- [ ] Table has all three section header rows.
- [ ] Issues / Blockers: open statuses only, **no** time filter.
- [ ] Completed: only tickets updated within the lookback window.
- [ ] Pre-research / In Progress: within the window, and no duplicates from Blockers.
- [ ] Total rows are in the configured target range; flag if above `max_rows`.
- [ ] Status markers used correctly (Done, Low priority).
- [ ] Alignment marker appears only on tickets mapped to manager "next steps".
- [ ] Data-source line includes the feedback email date, with
      "(latest available)" if older than the lookback window.
- [ ] Alignment heading includes manager name and email date.
- [ ] Chat section has 4–6 bullets or the explicit "no material activity" line.
- [ ] Manager section was copied **verbatim** from after the @mention to the
      end of the page: existing title (custom wording included), notes, empty
      bullets and the original divider (`---` or `----`) are unchanged.
- [ ] No manager title was replaced, regenerated or duplicated. A configured
      title was written only for a new page or a completely empty section.
- [ ] Ticket links use the configured issue base URL.

## Safety

- [ ] No real names, account IDs or internal URLs from examples leaked into output.
- [ ] Page permissions are manager + employee only.
- [ ] No credentials or tokens appear in the page or in any report.
- [ ] If `wiki.write` was unavailable, the response says clearly that nothing
      was written and lists the page names that would have been created.
