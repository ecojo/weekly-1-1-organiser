# Security Policy

## Reporting a vulnerability

If you find a security issue in SiliconRA Weekly 1:1 Organiser, please open a
private security advisory on this repository or contact the maintainer through
GitHub. Please do not post exploit details in a public issue.

## Security model

This package contains **instructions only** (Markdown). It ships no executable
scripts, no network calls of its own, and no embedded credentials. It reads and
writes external systems only through connectors that the host platform exposes
and that you explicitly authorise.

Data handling:

- Configuration (team members, emails, board keys, space keys) is supplied by
  the user at setup time and stored by the host platform. Do not commit real
  configuration to a public repository.
- The connected variant reads Jira/Confluence/email/chat data through your
  connectors. It never exfiltrates data to a third party.
- The manual variant processes only text that you paste into the conversation.
- Generated 1:1 pages should remain restricted to the manager and employee.
  Enforce this with page permissions in your wiki, not by relying on the skill
  alone.

## Review before installing

Treat skills like code. Read `SKILL.md` and the `references/` files before
installing, and pin to a release tag when deploying to a team.
