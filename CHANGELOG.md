# Changelog

All notable changes to SiliconRA Weekly 1:1 Organiser are documented here.

## [1.1.0] - 2026-11-22

### Added

- Outlook calendar resolution for the 1:1 meeting date, with per-employee
  event matching and an explicit `date_override` fallback.
- Calendar-driven scaffolding: page dates come from each 1:1 series rather
  than a fixed weekday.
- Automatic creation of a missing dated Confluence page under the configured
  parent page, using a page name constructed from `wiki.page_pattern` and the
  meeting date.
- Configurable manager-section title (`settings.manager_section_title`,
  default "Points for Alignment"), inserted when the existing page has none.
- Validation checks for calendar-derived dates, page creation and page-name
  reporting.

### Changed

- Alignment marker is now the orange square `🟧` instead of the target emoji.
- Scheduling guidance prefers a daily calendar-driven run instead of a fixed
  weekday routine.
- Removed all legacy product-name references from documentation.

## [1.0.0] - 2026-11-21

### Added

- MIT licence under SiliconRA.
- Portable package layout with one canonical set of skills in `skills/`.
- Two variants: connected (`weekly-1-1-organiser`) and offline/manual
  (`weekly-1-1-organiser-manual`), sharing `skills/references/`.
- Platform reference docs for connectors and scheduling.
- Amazon Quick adapter, setup guide and custom-agent instructions.
- Adapters for Claude, ChatGPT/Codex and Antigravity.
- `scripts/sync.sh`, `scripts/pack.sh` and `scripts/validate.sh`.
- Synthetic fixture and golden output for regression testing.

### Changed

- Generalised all examples: no real names, account IDs, board keys, spaces or
  internal URLs remain in the portable package.
- `shared-utils` converted from a synthetic "skill" into reference guidance so
  agents do not attempt to call non-existent functions.

### Deprecated

- The `.skill` zip and RTF files in the original workspace (May 2026) are
  superseded by this repository.
