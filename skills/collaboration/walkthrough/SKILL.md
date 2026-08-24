---
name: walkthrough
description: 'Guide a human acceptance walkthrough of implemented tickets, one PR at a time: sequence proposed up front to minimise module jumping, the PR branch checked out and loaded (product running, or document rendered) before each walk, results recorded on GitHub, passing issues stamped per walker.'
disable-model-invocation: true
---

Manual acceptance testing of implemented tickets, run by a human on the
product with the agent as guide and scribe — **one PR at a time**, each
walked on its own branch and closed out in dialogue before the next begins.
Input: one or more issue numbers (`/walkthrough 2226 2236 …`). Given none,
propose the current review-stage issues (list them per the repo's
collaboration conventions, `docs/agents/collaboration.md`) and let the user
confirm the batch.

## 1. Sequence

For each ticket, find its PR (`gh pr list --state all --search "<n> in:body"`
plus the issue's Development links) and note which product area the change
touches (from titles and PR summaries — deep reading comes later, per
ticket). When the batch holds more than one ticket, propose a walking order
that keeps tickets touching the same area adjacent, and say why. The user
confirms or reorders; their order stands.

Completion: a confirmed ordered list of ticket → PR pairs.

## 2. Walk one ticket

Repeat for each ticket in order, finishing its close-out before opening the
next.

### Load the artifact

The walkthrough must exercise the artifact under review — a walkthrough on
the wrong branch tests nothing. `gh pr checkout <pr>`, then per the kind of
artifact:

- **Product code**: restart the product per the repo's dev-environment
  conventions and confirm the running build picks the branch up before
  presenting any check.
- **Documents** (standalone repos): open the changed documents in rendered
  form; the walk is a guided read-through, and checks verify claims and
  structure instead of clicks.

A merged PR is tested on `main` (or the environment it deployed to)
instead.

### Plan

Now gather deeply: `gh issue view <n> --comments` (agent briefs often carry
the acceptance criteria), the PR body (Test plan section is primary
material), and every referenced document — pull anything that reads like
acceptance criteria, a testing checklist, or manual-validation notes. Distil
a focused step-by-step list for this ticket only: each check names the route
to open (or the section to read), the action, and the expected result,
ordered so state built by one check flows into the next. A ticket with no discoverable criteria gets a
proposed list derived from the PR diff, confirmed by the user before testing.

### Walk

Guide the user check by check. Record each verdict as it happens: pass,
fail, or skipped (with why). Capture failure observations verbatim — the
user's words are the bug report. This is a dialogue: questions, side
findings, and judgment calls about the ticket belong here, while the context
is loaded and the code is running.

Completion: every check carries a verdict.

### Close out the ticket

- **PR still open** → submit a review carrying the checks, verdicts, and
  observations: all pass → `gh pr review <pr> --approve --body …`; any
  failure → `gh pr review <pr> --request-changes --body …`. When the walker
  authored the PR, GitHub rejects self-reviews — post the same report with
  `gh pr comment <pr> --body …` instead.
- **PR merged** → the same report as an issue comment:
  `gh issue comment <n> --body …`.
- Failures that outlive the PR (not fixable by amending it) → file follow-up
  issues per the repo's triage conventions (inherit priority/client labels)
  and link them in the report.
- Every check passed → stamp the ticket for the walker:

```bash
LOGIN=$(gh api user --jq .login)
gh label create "walkthrough:$LOGIN" --color 0E8A16 \
  --description "Acceptance walkthrough passed by $LOGIN" 2>/dev/null || true
gh issue edit <n> --add-label "walkthrough:$LOGIN"
```

Stamps are per-person and additive: a release requiring several walkers
simply requires several stamps, and an issue's stamp count is its tally.
Filter one walker's coverage with `gh issue list --label
"walkthrough:<login>"`. The stamp lives on the issue, not the PR, because
issues survive the merge and travel the delivery pipeline.

## 3. Close out the batch

Report: tickets stamped, reviews submitted, follow-ups filed, checks
skipped, and which branch the product was left on. Board status moves stay
human decisions — end by listing which tickets now look eligible for their
next stage.
