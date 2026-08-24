---
name: double-check
description: Play the chosen design back to the business user in plain language and verify it maps to the original intent. Use for {{PRODUCT_NAME}} issues awaiting a double-check.
---

Verify that the chosen design actually delivers what the business user meant. {{DESIGN_ACTOR}} turned the clarified requirements into a published spec or outline; your job is to **explain it back in business language** and hunt for misunderstandings before anything gets built or written. You are the last checkpoint before production starts.

If the GitHub connector cannot reach `{{REPO}}` (not connected, access denied, repository not found), stop and run the **setup** skill — don't improvise around a broken connection.

## Finding the queue

List open issues on `{{REPO}}` with the label `{{LABEL_DOUBLE_CHECK}}` through the GitHub connector. That label is a mirror of the **{{COL_DOUBLE_CHECK}}** board column — reading it is fine, editing it is not.

If the user names a specific issue, work that one; otherwise show the queue and let them pick.

## Gathering both sides

For the chosen issue, through the connector:

1. The **original intent**: the `## Clarified requirements` comment (from the clarify session) and the issue body.
2. The **chosen design**: the spec or outline {{DESIGN_ACTOR}} published — on this issue or a linked spec issue (follow `Refs #n` links). Read the whole thing, including implementation decisions and out-of-scope sections.
3. Where the spec references product areas, check `{{ARCHITECTURE_DOCS}}/` so your explanation reflects how the product actually works today.

## The double-check dialogue

Explain the design **entirely in business language** — no code terms, no file names, no internal jargon. Structure it as:

1. **What we understood you want** — restate the requirement in one paragraph.
2. **What will actually be built** — walk the user journey through the design: what the user will see, click, and get, step by step.
3. **What will NOT be built** — the out-of-scope list, translated; this is where most misunderstandings hide.
4. **Trade-offs made** — anything the design does differently from what was literally asked, and why.

Then ask directly, one at a time:

- Does step 2 match what you had in mind when you asked for this?
- Is anything in step 3 something you assumed would be included?
- Would you accept the feature exactly as described?

Dig into every hesitation — a "mostly" is a misunderstanding not yet found.

## Recording the outcome

Post the outcome as an issue comment under a `## Double-check` heading:

- **Confirmed** — the explanation as delivered, the user's confirmation, and any small notes. Remind the user to drag the card from **{{COL_DOUBLE_CHECK}}** to **{{COL_AGENT_READY}}** on the [board]({{BOARD_URL}}) — {{AGENT_READY_ACTOR}} takes over from here.
- **Misunderstandings found** — list each one: what the design says, what the user actually meant. Remind the user to drag the card back to **{{COL_DESIGN}}** so the design gets revised; the issue will return here for another pass.

Never edit the spec yourself, and never soften a mismatch to avoid the bounce-back — a wrong feature costs far more than another design round.
