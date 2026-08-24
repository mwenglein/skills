---
name: document
description: Draft user documentation for shipped {{PRODUCT_NAME}} features in the documentation queue. Use when the user wants to document verified work.
---

Draft user-facing documentation for features that have shipped and now wait in the **{{COL_DOCUMENTATION}}** column of the board. The announcement/marketing pass is a separate, later stage — that is the **communicate** skill's job, in **{{COL_COMMUNICATION}}**.

If the GitHub connector cannot reach `{{REPO}}` (not connected, access denied, repository not found), stop and run the **setup** skill — don't improvise around a broken connection.

## Finding the queue

List open issues on `{{REPO}}` with the label `{{LABEL_DOCUMENTATION}}` through the GitHub connector. That label is an automatically maintained mirror of the board column — reading it is fine, editing it is not.

If the user names a specific issue, work that one; otherwise show the queue and let them pick.

## Gathering the story

For the chosen issue, through the connector:

1. Read the issue body and comments — the original intent, the `## Clarified requirements`, and the acceptance criteria.
2. Find the pull requests that reference the issue (search PRs for `#<number>`) and read their descriptions — the "Summary" sections describe what actually shipped, which may differ from what was planned. **What shipped wins.**
3. When behaviour details are unclear, check the relevant `{{ARCHITECTURE_DOCS}}/` docs rather than guessing or asking the user.

## Writing

Write **user documentation**: task-oriented, what the feature does and how to use it, written for {{USER_EXAMPLE}}, no internal jargon (no issue numbers, no code terms). Draft in chat and iterate with the user until approved.

## Delivering

Post the approved text as a **comment on the issue** (prefixed with a `## Documentation draft` heading) so it is versioned next to the work and the next stage can pick it up.

Then remind the user:

- Drag the card from **{{COL_DOCUMENTATION}}** to **{{COL_COMMUNICATION}}** on the [board]({{BOARD_URL}}) — the **communicate** skill picks up there for release notes and announcements
- Board moves are deliberate human steps from here on; automation never advances past documentation
