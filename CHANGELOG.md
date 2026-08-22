# mwenglein-skills

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
