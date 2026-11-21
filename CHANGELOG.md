# Changelog

All notable changes to SiliconRA Weekly 1:1 Organiser are documented here.

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

- Renamed the package and primary skill to `weekly-1-1-organiser`; the previous
  Octopus name remains as a product alias in documentation.
- Generalised all examples: no real names, account IDs, board keys, spaces or
  internal URLs remain in the portable package.
- `shared-utils` converted from a synthetic "skill" into reference guidance so
  agents do not attempt to call non-existent functions.

### Deprecated

- The `.skill` zip and RTF files in the original workspace (May 2026) are
  superseded by this repository.
