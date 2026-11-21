---
name: setup-wizard
description: Configure SiliconRA Weekly 1:1 Organiser for a team — collect team members, issue boards, feedback-email patterns, wiki space, meeting times and permissions, then save a reusable config and optionally create the wiki folder structure. Use first, before employee, manager or scaffolder skills. Trigger with "set up weekly 1:1", "configure 1:1 organiser", "setup wizard".
license: MIT
metadata:
  author: SiliconRA
  version: "1.0.0"
---

# Setup Wizard

Collect the configuration once, validate it, and save it so all other skills
can reuse it.

## What you will configure

1. **Team basics** — team name, manager name and email, timezone.
2. **Team members** — name, email, issue boards/queries, 1:1 day and time.
3. **Feedback email** — subject pattern and/or shared folder.
4. **Wiki** — space key, page-title pattern, date format, parent folder.
5. **Schedule** — whether to run automatically and by which platform mechanism.
6. **Scaffolding** — quarterly or half-yearly placeholder pages.
7. **Permissions** — manager plus the individual employee only.

## Flow

1. **Check connectors.** For each capability you intend to use
   (`issues.search`, `mail.search`, `chat.search`, `wiki.find`, `wiki.read`,
   `wiki.write`), check whether the host provides it. See
   `../references/connectors-by-platform.md`. Record missing capabilities and
   tell the user which skills will need pasted data instead.
2. **Ask the questions** in `../references/config-schema.md`, in order. Do not
   guess values. Accept "use defaults" where a default exists.
3. **Discover meeting times** if the user wants: search the calendar for
   "1:1" and confirm each match, or accept manual entry. Always confirm.
4. **Show the full config** and ask for confirmation before making changes.
5. **Create wiki infrastructure** only if requested and the `wiki.write`
   capability exists: parent folder, employee subfolders, year folders, and
   placeholder pages for the next period.
6. **Save the config** in the location the host provides (a config file in the
   workspace, a secret store, or an in-conversation profile). Never commit
   real config to a public repo.
7. **Report** what was created, what was skipped, and which skills are ready.

## Updating

Re-run this skill at any time to change the config. Always show a diff of old
versus new values before saving, and warn that scheduled runs may need to be
re-created.

## Scheduling

Automatic runs depend on the host. See `../references/scheduling-by-platform.md`
for the correct mechanism per platform, and fall back to manual triggers where
no scheduler exists.

## References

- `../references/config-schema.md` — fields, defaults and config example
- `../references/connectors-by-platform.md` — capability mapping
- `../references/scheduling-by-platform.md` — scheduling options
- `../references/privacy.md` — permissions and data handling
