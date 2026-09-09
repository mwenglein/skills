---
name: document
description: Draft user documentation for shipped {{PRODUCT_NAME}} features in the documentation queue. Use when the user wants to document verified work.
---

Draft user-facing documentation for features that have shipped and now wait in the **{{COL_DOCUMENTATION}}** column of the board. The announcement/marketing pass is a separate, later stage — that is the **communicate** skill's job, in **{{COL_COMMUNICATION}}**.

## Which board are we in?

The user may work across several products' boards. Resolve the active one
before doing anything, in this order — never ask while a rung still
answers:

1. **Named in the message** — a board or issue URL, an issue number on a
   known product, or the product's name. A URL always wins: the repository
   it points to *is* the answer.
2. **Already resolved in this conversation** — keep it. If the user
   switches mid-conversation, say so explicitly ("switching to <product> —
   the cards we touch now live there").
3. **The default** — `{{REPO}}`, the {{PRODUCT_NAME}} board. If it's the
   only product they've joined, state it in one line and move on.
4. **Ask** — last resort: search the connector for the repositories they
   have joined (each carries a pinned issue labelled `pipeline-home`),
   present the short names — never raw repository slugs — and let them
   pick.

Whatever the answer, if the connector cannot reach the resolved repository
(not connected, access denied, repository not found), stop and run the
**setup** skill — don't improvise around a broken connection. A product
they haven't joined yet is the **join** skill's job — point them there
rather than guessing at an unjoined board.

## Finding the queue

List open issues on the resolved repository with the label `{{LABEL_DOCUMENTATION}}` through the GitHub connector. That label is an automatically maintained mirror of the board column — reading it is fine, editing it is not.

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
- Suggest the next step without starting it: communication deserves its own sitting, with fresh eyes on the approved text — when ready, say _"communicate issue #n"_ in a fresh session; never roll into it from here
