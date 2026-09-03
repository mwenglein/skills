# mwenglein-skills

## 0.5.0

### Minor Changes

- [`cae918d`](https://github.com/mwenglein/skills/commit/cae918d230789d329149dcd732cc4eb37b604f16) Thanks [@mwenglein](https://github.com/mwenglein)! - Content & marketing skills: five additions for standalone repos that produce
  marketing content — `brainstorm` (divergent idea development, the widening
  counterpart to `clarify`), `scout` (open-internet research with cited
  notes), `greenlight` (pre-publication review: claims vs. what shipped, voice,
  channels, CTA), `publish` (per-channel publication walkthrough, closes the
  issue on publication), and `marketing-handover` (opens the Announce brief in
  the marketing repo when a dev issue reaches ready-to-communicate).

## 0.4.0

### Minor Changes

- [#1](https://github.com/mwenglein/skills/pull/1) [`20b4118`](https://github.com/mwenglein/skills/commit/20b41186cd5c11dc8d96ba4e9983f7b14e1eefa4) Thanks [@mwenglein](https://github.com/mwenglein)! - Standalone mode and first-run setup.

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

## 0.3.0

### Minor Changes

- `/configure` now branches on repository owner type and carries the
  field-tested token guidance for personal-account repos (verified 2026-08):
  fine-grained PATs cannot reach user-owned Projects v2 boards (the
  fine-grained repo-"Projects" entry is a legacy decoy), classic
  `read:project` alone hits a silent visibility trap (board readable, item
  content — even issue numbers — invisible for private repos), and the viable
  setups form a four-rung ladder (single classic token → two-token split with
  board-writes-off and nudge comments → machine account → move to an org).
  Full reference in the skill's TOKENS.md. New `scripts/board-doctor.sh`: a
  read-only per-token capability probe ("N items, M linked to issue numbers")
  prescribed as the post-setup and post-token-change verification.

## 0.2.0

### Minor Changes

- New web skill `ask-mike` — the business-side equivalent of ask-matt: a
  router that tells a business user where they are in the ping-pong, whether
  it's their move, and which skill to run, with standalone routes for bug
  reports, status questions, and plain-language translations of developer
  comments.
