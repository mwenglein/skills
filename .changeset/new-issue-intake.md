---
"mwenglein-skills": minor
---

New web skill `new-issue` — the intake front door. Slices what a user
brings into right-sized issues via the one-card test (one topic may split
into several issues, a pasted list may merge into one), checks for
duplicates before creating anything, lands everything in triage with no
labels or board moves, and closes by suggesting — never auto-starting — a
`clarify` session per issue, handing the user the exact one-line prompt to
use when ready. `ask-mike` routes "something is broken / I have a request /
here's a list" to it; `onboard-business` counts seven web skills and opens
its pilot with it.

The suggest-don't-start pattern is now the pack-wide closeout convention,
written for business users who memorize nothing: `clarify`,
`double-check` (both outcomes), `document`, and `setup` each end by naming
the user's next move and the exact one-line prompt to say when ready —
never rolling into the next session themselves. Codified as `ask-mike`'s
third rule.
