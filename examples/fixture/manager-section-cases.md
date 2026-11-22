# Manager-section regression cases

The manager's section is read-only input. These cases guard against the bug
where the manager's "Points for Alignment" notes were overwritten.

## Case 1 — custom heading must survive unchanged

Existing page tail:

```text
----

@Morgan Example

Points for Alignment — Q1 priorities

* Confirm hiring plan with Morgan.
*
```

Required output tail: **identical, byte-for-byte**. Do not replace the heading
with "Points for Alignment" from config, and do not add a second heading.

## Case 2 — older three-hyphen divider

Existing page tail:

```text
---

@Morgan Example

Points for Alignment

* Carry-over item.
```

Required: keep the `---` divider exactly as found; do not normalise it to
`----`.

## Case 3 — new or empty section

Input: a newly created page, or `@Morgan Example` followed only by blank lines.

Required: seed with the configured title and one empty bullet — the only case
where the skill writes the heading itself:

```text
----

@Morgan Example

Points for Alignment

*
```

## Case 4 — missing divider or @mention

Input: a page with no divider or no manager @mention.

Required: stop and ask the user for the existing page. Do not guess, rebuild
or partially reconstruct the manager section.
