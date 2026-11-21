# ChatGPT

Standalone skills are available in the ChatGPT desktop app. Skills bundled in
a plugin also work in ChatGPT on the web and mobile.

## Install

1. Build the archive with `./scripts/pack.sh`.
2. In ChatGPT, open **Plugins → Skills → Create → Upload** and select
   `dist/weekly-1-1-organiser-chatgpt.zip`.
3. Enable the skill. Invoke it with `@weekly-1-1-organiser`, or let ChatGPT
   select it when your request matches the description.

For workspace distribution, share the skill from the Skills page if your plan
allows it. For connectors, bundle the skill in a plugin together with the
required apps.

## Notes

- ChatGPT skills follow the open Agent Skills format, so the canonical files
  need no conversion — only the folder location differs.
- If a connector is unavailable, ask for pasted data or use the manual variant.
- Scheduling depends on plan availability. If no scheduler exists, use a
  manual trigger before each 1:1.

See `../../skills/references/connectors-by-platform.md` and
`../../skills/references/scheduling-by-platform.md`.
