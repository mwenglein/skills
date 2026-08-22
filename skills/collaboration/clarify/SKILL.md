---
name: clarify
description: Grill the user about the user-facing requirements of a feature idea - personas, journeys, desired outcomes, expectations. Use for issues in the clarification stage, before any technical grilling.
---

Interview the user relentlessly until the **user-facing requirements** are fully understood. This is the requirements half of grilling: it runs while an issue sits in the **clarification stage**, typically driven by a business user or product owner. The technical half — architecture, data models, technology choices — happens later, in the **design stage**, via `grill-me` or `grill-with-docs`. Do not cross into it here.

The repo's collaboration conventions (stage names, board, how to move issues) should have been provided to you — see `docs/agents/collaboration.md`. If they are missing, tell the user to run `/configure` first.

## What to grill about

Every question stays on the user's side of the product:

- **Problem & motivation** — what hurts today, for whom, how often, how badly
- **Actors & personas** — who touches this feature, and how their needs differ
- **User journey** — where the feature lives in their day; what happens immediately before and after; entry points and exits
- **Desired outcome** — what "this worked" looks like to the user, in their words; what they would show a colleague
- **Expectations & acceptance** — behaviour on the happy path, on empty/first-run states, on failure; what would make the user consider it broken
- **Scope & priority** — the smallest version that is genuinely useful; what is explicitly out; what can wait
- **Value** — why now, what it unblocks, how success would be noticed

Out of scope here (park them for the design-stage grilling, don't ask the user): how to build it, data models, APIs, performance budgets, technology choices.

## How to grill

Map the requirements as a **design tree**: every decision branches into the decisions that hang off it.

Work the tree in **rounds**. The **frontier** is every decision whose prerequisites are already settled: the questions you can ask _now_ without guessing at answers you haven't heard yet. Ask the whole frontier in one round: number each question and give your recommended answer. Then wait for the user's answers before the next round.

Each question should be formatted like so:

```
❓ **Q1** - **<question title>**: <question body, might be multiple paragraphs, including multiple choices>

➡️ <your recommended answer>
```

Each round the user answers reshapes the tree: settled decisions push the frontier outward and unblock questions that depended on them. Recompute the frontier and ask the next round. A question whose answer depends on another question still open in this round belongs to a _later_ round, not this one.

Finding _facts_ is your job, never the user's. When a frontier question needs a fact about current product behaviour, check the repo's architecture docs, existing issues, or the running product before asking. Only put _decisions_ to the user.

## Finishing

The session is done when the frontier is empty: every requirement branch visited, nothing left silently assumed. Then:

1. Summarize the clarified requirements (problem, actors, journey, expectations, scope, out-of-scope) and get the user's confirmation.
2. Capture the summary on the issue — post it as a comment under a `## Clarified requirements` heading (or update the issue body if the user prefers). If there is no issue yet, create one with the summary as the body.
3. Hand off to the **design stage** per the repo's conventions — the developers grill the technical design there, and the business user gets the result played back by `double-check` afterwards.
