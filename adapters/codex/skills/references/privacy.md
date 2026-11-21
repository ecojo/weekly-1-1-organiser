# Privacy and permissions

- 1:1 pages contain performance feedback and personnel information. Treat them
  as confidential.
- Always create or update the **individual** dated page. Never write to a
  shared index or team page.
- Set wiki permissions so only the manager and the named employee can view
  each page. Do not rely on the skill to enforce this — verify in the wiki.
- Do not include credentials, tokens, or connector secrets in config files,
  chat output or generated pages.
- Configuration files containing real names and emails are private. Keep them
  out of public repositories; add them to `.gitignore` if stored in a
  workspace.
- The manual variant processes only text the user pastes. Do not retain that
  text beyond the conversation unless the user asks.
- When publishing examples or test fixtures, use the neutral placeholder
  values in `config-schema.md`.
- If a data source returns personal data beyond what is needed for the 1:1,
  ignore it and do not repeat it in the output.
