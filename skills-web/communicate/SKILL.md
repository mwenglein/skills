---
name: communicate
description: Draft release notes, announcements, and marketing copy for documented {{PRODUCT_NAME}} features in the communication queue. Use when the user wants to announce or promote shipped work.
---

Draft the outward-facing communication for features that are already documented and now wait in the **{{COL_COMMUNICATION}}** column of the board — the last stop before **{{COL_RELEASE}}**.

If the GitHub connector cannot reach `{{REPO}}` (not connected, access denied, repository not found), stop and run the **setup** skill — don't improvise around a broken connection.

## Finding the queue

List open issues on `{{REPO}}` with the label `{{LABEL_COMMUNICATION}}` through the GitHub connector. That label is an automatically maintained mirror of the board column — reading it is fine, editing it is not.

If the user names a specific issue, work that one; otherwise show the queue and let them pick.

## Gathering the story

For the chosen issue, through the connector:

1. Read the issue's `## Documentation draft` comment — the approved documentation from the **document** pass is the factual baseline. If it is missing, say so and suggest running **document** first rather than improvising.
2. Read the issue body and the referencing PR descriptions for anything the docs pass left out.

## Writing

Ask the user which formats they need (or produce the set they ask for):

- **Release note** — 2–4 sentences per feature: what changed, why it matters, where to find it
- **Announcement** — short post for clients or internal channels (Slack, newsletter), benefit-first
- **Marketing copy** — grounded strictly in what actually shipped; never promise behaviour not covered by the documentation draft

Draft in chat and iterate with the user until approved.

## Delivering

Post the approved text as a **comment on the issue** (prefixed with a `## Communication draft` heading) so it is versioned next to the work.

Then remind the user:

- Drag the card from **{{COL_COMMUNICATION}}** to **{{COL_RELEASE}}** on the [board]({{BOARD_URL}})
- Closing the issue happens at the production release, by a human, from the release column
