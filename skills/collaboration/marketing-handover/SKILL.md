---
name: marketing-handover
description: Open a content brief in the marketing repo when a development issue reaches ready-to-communicate - Announce issue with source link, what shipped, suggested audience and channels; add it to the marketing board's entry column. Run on demand per issue.
disable-model-invocation: true
---

Bridge the development pipeline and the marketing pipeline: when a
development issue reaches its **ready-to-communicate** stage, open the
marketing side's brief so communication work can start. Run per issue, on
demand — `/marketing-handover <n>` — or in a batch for a release.

The repo's collaboration conventions (which repo is the marketing repo,
which board, which column handovers land in, which labels apply) should
have been provided to you — see `docs/agents/collaboration.md`. If they are
missing, tell the user to run `/configure` first.

## Gather what shipped

For each source issue (per the dev repo's conventions: issue body, merged
PRs, changelog entries — what shipped wins):

- **The feature in one paragraph** — user-visible behavior, not
  implementation
- **Who it matters to** — inferred from the feature type; a hypothesis the
  marketing side will verify, not a decision
- **Suggested channels** — changelog highlight, blog post, social thread,
  newsletter — again a suggestion, driven by feature weight
- **Angle hints** — the demo-able moment, the before/after, the number that
  moved

## Open the brief

In the marketing repo, per its conventions:

- **Title**: `Announce: <feature name>`
- **Body** starts with the source link — `Source: <owner>/<repo>#<n>` —
  then the what-shipped paragraph, suggested audience, suggested channels,
  and angle hints, each under its own heading
- **Label**: the entry-stage label per the conventions (handovers skip the
  triage evaluation — they were queued intentionally upstream)

Then add the issue to the marketing board's entry column with the recorded
project and field IDs from the conventions. Script the move; don't ask the
user to drag it.

## Stay on your side

Never modify the source issue's state, labels, or board membership — the
development board's promotion is the dev side's job. The handover is
additive: one new brief over there, one comment on the source issue here:

> Handover brief opened at <marketing-repo>#<m> — communication work starts
> there.

Completion: brief issue created, added to the board, source issue
commented. Report the pairing(s): source → brief.
