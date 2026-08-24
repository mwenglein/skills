---
name: clarify
description: Grill the user about the user-facing requirements of a {{PRODUCT_NAME}} feature idea - personas, journeys, outcomes, expectations. Use for new ideas or issues awaiting clarification.
---

Interview the user relentlessly until the **user-facing requirements** are fully understood. This is the requirements half of grilling: it belongs to the **{{COL_CLARIFICATION}}** stage of the board and is owned by business users. The production half — how it will be built or written — happens later, in **{{COL_DESIGN}}**, where {{DESIGN_ACTOR}} runs the design grilling; you will get the design played back for confirmation by the **double-check** skill afterwards. Do not cross into that territory here.

If the GitHub connector cannot reach `{{REPO}}` (not connected, access denied, repository not found), stop and run the **setup** skill — don't improvise around a broken connection.

If the user names an issue number or URL, fetch it through the **GitHub connector** on `{{REPO}}` and read its body and comments first.

## What to grill about

Every question stays on the user's side of the product:

- **Problem & motivation** — what hurts today, for whom, how often, how badly
- **Actors & personas** — who touches this feature (e.g. {{USER_EXAMPLE}}), and how their needs differ
- **User journey** — where the feature lives in their day; what happens immediately before and after; entry points and exits
- **Desired outcome** — what "this worked" looks like to the user, in their words; what they would show a colleague
- **Expectations & acceptance** — behaviour on the happy path, on empty/first-run states, on failure; what would make the user consider it broken
- **Scope & priority** — the smallest version that is genuinely useful; what is explicitly out; what can wait
- **Value** — why now, what it unblocks, how success would be noticed

Out of scope here (note them as open questions for the design stage, don't ask the user): how it will be built or produced — data models, APIs, performance, technology choices, document structure, sourcing.

## How to grill

Map the requirements as a **design tree**: every decision branches into the decisions that hang off it.

Work the tree in **rounds**. The **frontier** is every decision whose prerequisites are already settled: the questions you can ask _now_ without guessing at answers you haven't heard yet. Ask the whole frontier in one round: number each question and give your recommended answer. Then wait for the user's answers before the next round.

Each question should be formatted like so:

```
❓ **Q1** - **<question title>**: <question body, might be multiple paragraphs, including multiple choices>

➡️ <your recommended answer>
```

Each round the user answers reshapes the tree: settled decisions push the frontier outward and unblock questions that depended on them. Recompute the frontier and ask the next round. A question whose answer depends on another question still open in this round belongs to a _later_ round, not this one.

Finding _facts_ is your job, never the user's. When a frontier question needs a fact about current product behaviour, look it up through the GitHub connector before asking: `{{ARCHITECTURE_DOCS}}/` for existing behaviour, `{{ADR_DOCS}}/` for prior decisions, issue search for related or duplicate work. Only put _decisions_ to the user.

## Finishing

The session is done when the frontier is empty: every requirement branch visited, nothing left silently assumed. Then:

1. Summarize the clarified requirements (problem, actors, journey, expectations, scope, out-of-scope, plus any parked design questions) and get the user's confirmation.
2. **Existing issue**: post the summary as an issue comment under a `## Clarified requirements` heading. **No issue yet**: create one on `{{REPO}}` with the summary as the body.
3. Remind the user to drag the card from **{{COL_CLARIFICATION}}** to **{{COL_DESIGN}}** on the [board]({{BOARD_URL}}) — {{DESIGN_ACTOR}} works out the design there, and the **double-check** skill brings the result back to you for confirmation.
