---
"mwenglein-skills": minor
---

Standalone mode and first-run setup.

- **Standalone mode**: the full nine-stage pipeline now runs without
  mattpocock/skills — for document repos where business decides and the
  agent produces. New IDE skills `outline` (design stage: audience,
  structure, sources, position) and `draft` (agent-ready stage: the
  document written on a branch, opened as a PR). `walkthrough` generalizes
  to guided read-throughs of document PRs. Mode lives only in `/configure`
  and the files it writes; adding developers later is a `/configure`
  re-run.
- **`setup` web skill**: first-run preflight for business users — self-
  tests GitHub access through the connector and fixes it step by step,
  from no GitHub account at all (signup → connector → repo invitation).
  The other web skills stop and route to `setup` instead of improvising
  around a broken connection.
- New web-pack config keys: `SETUP_CONTACT`, `DESIGN_ACTOR`,
  `AGENT_READY_ACTOR` — the web skills no longer hardcode "the
  developers" for the middle stages.
