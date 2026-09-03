---
name: publish
description: Walk a greenlit piece through per-channel publication - where each variant goes, what to schedule when, cross-linking back to the product; closes the issue on publication.
---

Take a greenlit piece to its channels: prepare each variant for its
destination, let the human perform and schedule, record what went live
where, and close the loop. The human decides and executes publication —
this skill is guide and scribe, never an unattended posting engine.

The repo's collaboration conventions should have been provided to you — see
`docs/agents/collaboration.md`. If they are missing, tell the user to run
`/configure` first.

## Plan the channels

Input: one or more issues in the publish-ready stage. For each, load the
brief (the channel list decided during clarification) and the greenlight
approval (the verified-claims list that travels with the copy). Propose a
publication plan as a table:

| Channel | Destination | Artifact | Who/when |
| --- | --- | --- | --- |

- **Destination**: where exactly this variant goes (CMS section, social
  account, newsletter issue)
- **Artifact**: the paste-ready text, or the CMS fields filled, or the
  asset link
- **Who/when**: a human decision — propose timing per channel (announce
  day, follow-ups) but never schedule or post without the user's explicit
  instruction and the repo's configured tooling

The user confirms or edits the plan; their version stands.

## Publish, channel by channel

For each channel in order:

1. Produce the exact artifact — final copy per the greenlit version, no
   silent edits since approval
2. Hand it to the user (or the configured integration) to perform and
   schedule
3. Record the outcome: **live URL**, **scheduled date**, or **skipped**
   (with why) — nothing in between

While publishing, cross-link: the piece points back to the product
(docs, changelog, sign-up) per the brief, and the product's records point
at the piece where the repo's conventions say to record such links.

## Close the loop on handover pieces

If the piece originated as a handover from a development repo (the brief
carries a `Source:` link per the repo's conventions), post the published
URL as a comment on the source issue. The upstream `ready-to-communicate`
stage completes visibly — that is the whole point of the handover.

## Close out

When every channel row carries an outcome, **close the issue on
publication** per the repo's conventions — closing archives it off the
board; publication is this pipeline's release. Report: channels published
(with URLs), scheduled (with dates), skipped (with why).

Completion: all channels resolved, issue closed, source issues notified.
