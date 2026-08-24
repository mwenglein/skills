---
name: draft
description: Produce the document deliverable from an issue's clarified requirements and confirmed outline - written on a branch, opened as a PR. The agent-ready stage of standalone (document-repo) mode.
---

Write the document an issue has been preparing for. This is the agent-ready
stage of standalone mode — the document-repo counterpart of the developers'
`to-tickets` → `implement`: the thinking is done, the outline is confirmed,
and the deliverable gets produced on a branch and opened as a PR for the
review stage's read-through (`walkthrough`).

The repo's collaboration conventions (stage names, board, how to move
issues) should have been provided to you — see
`docs/agents/collaboration.md`. If they are missing, tell the user to run
`/configure` first.

## Preconditions — refuse to draft blind

The issue must carry, as comments or body:

1. `## Clarified requirements` (from `clarify`)
2. `## Outline` (from `outline`)
3. `## Double-check` recording **confirmation** (from `double-check`)

Any of them missing or the double-check unconfirmed → stop and name the
stage the issue needs to revisit. Drafting from an unconfirmed outline
recreates exactly the misunderstanding the pipeline exists to catch.

## Producing the draft

- **Branch first.** Create a branch for the issue; never draft on the
  default branch.
- **The outline is the spec.** Every section it names gets written; no
  section it doesn't name appears. Structural improvements you discover
  while writing are proposed on the PR, not silently applied.
- **Every claim has a source.** Ground each statement in the sources the
  outline names — quote, cite, or link them per the repo's citation
  conventions. A claim with no source is a question for the PR body, not a
  sentence in the document. Never invent facts, numbers, or quotes.
- **Match the repo.** Location, file naming, front-matter, and house style
  come from the repo's existing documents; when in doubt, copy the
  conventions of the nearest published neighbour.

## Opening the PR

Open a PR from the branch with a body containing:

- a summary of what the document argues and who it is for
- `Refs #<issue>` — never `Closes #<issue>`: the issue outlives the merge
  and travels the rest of the pipeline (review, documentation,
  communication, release)
- a **Read-through guide**: how the sections map to the outline, plus the
  acceptance checks the outline defined — this becomes the checklist
  `walkthrough` walks
- **Open questions**: sourceless claims, judgment calls made while writing,
  anything the outline underdetermined

## Handing off

Report the PR on the issue and hand off to the **review stage** per the
repo's conventions — the business user accepts the document there in a
guided read-through, one PR at a time. Board moves stay human decisions:
say which card looks ready to drag, don't drag it.
