---
name: outline
description: Grill the approach for a document deliverable - audience, structure, sources, evidence - and publish the outline on the issue. The design stage of standalone (document-repo) mode, after clarify.
---

Work out **how a document deliverable should be built** and publish the
result. This is the design stage of standalone mode — the document-repo
counterpart of the developers' `grill-with-docs` → `to-spec`: where they
grill architecture and data models, this grills structure, sources, and
argument. It runs on an issue whose requirements `clarify` already
captured; the business user gets the outline played back afterwards by
`double-check`, before `draft` writes a word.

The repo's collaboration conventions (stage names, board, how to move
issues) should have been provided to you — see
`docs/agents/collaboration.md`. If they are missing, tell the user to run
`/configure` first.

## Inputs

Read the issue first: the body and the `## Clarified requirements` comment
are the contract. Parked design questions from the clarify session are your
opening frontier. If there are no clarified requirements, stop and send the
issue back through `clarify` — outlining an unclarified idea just launders
assumptions.

## What to grill about

Everything about how the document will do its job:

- **Audience & register** — who reads this, what they already know, what
  tone lands with them
- **Deliverable form** — memo, strategy paper, decision record, deck
  outline; target length; where it lives in the repo
- **Structure** — the sections and each section's job: what question it
  answers, what the reader can do after it
- **Sources & evidence** — which existing documents, data, or prior
  decisions ground each claim; what needs research before drafting; what is
  genuinely unknown
- **Position** — the recommendation or thesis the document commits to, and
  the strongest counterargument it must survive
- **Constraints** — confidentiality, deadlines, house style, review chain
- **Acceptance** — what the reviewer will check in the read-through; what
  would make the business user reject the draft

## How to grill

Use the same round-based method as `clarify`: map the decisions as a design
tree, ask the full **frontier** each round (numbered questions, each with
your recommended answer), and let the answers push the frontier outward.

Finding _facts_ is your job, never the user's. Before a frontier question
reaches the user, search the repo — prior papers, decision records,
referenced data — and the issue history. Only _decisions_ go to the user;
sources you found go into the outline as evidence.

## Finishing

The session is done when the frontier is empty. Then:

1. Compose the outline: deliverable form and location, section-by-section
   structure with each section's job, the sources grounding each section,
   the committed position, out of scope, and acceptance checks.
2. Get the user's confirmation, then post it on the issue as a comment
   under a `## Outline` heading.
3. Hand off to the **double-check stage** per the repo's conventions — the
   business user gets this outline played back in plain language there, and
   only a confirmed outline moves on to `draft`.
