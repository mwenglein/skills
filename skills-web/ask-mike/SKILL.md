---
name: ask-mike
description: Ask which skill or step fits your situation as a business user in the {{PRODUCT_NAME}} development process. A router over the business-side skills and stages.
disable-model-invocation: true
---

# Ask Mike

You don't remember every skill or stage, so ask. This is the business-user
counterpart of the developers' **ask-matt**: it tells you where you are in
the process, whether it's your move, and which skill to run.

When the user describes their situation, route them using the map below —
and when it helps, look up the actual state of their issue on `{{REPO}}`
through the GitHub connector rather than answering in the abstract.

## The main flow: idea → shipped feature, from your seat

Work ping-pongs between you and the developers. The
[board]({{BOARD_URL}}) shows every issue in its current stage; the column
tells you whose move it is. Yours are these:

1. **You have an idea, or an issue sits in {{COL_CLARIFICATION}}** →
   **`clarify`**. It interviews you about the *user side* only — who it's
   for, where it lives in their day, what "done" looks like — never about
   technology. It ends by writing the clarified requirements onto the issue
   (creating one if needed) and handing the card to **{{COL_DESIGN}}**.

2. **{{COL_DESIGN}}** → *developers' move.* They grill the technical design
   and publish a spec. Nothing for you to run; answer their questions if
   they ping you on the issue.

3. **The issue reaches {{COL_DOUBLE_CHECK}}** → **`double-check`**, your
   most important move. The developers' design gets played back to you in
   plain language: what will be built, what will *not* be built, what
   trade-offs were made. Confirm it and the card moves on; find a
   misunderstanding and it bounces back to design — say so plainly, a wrong
   feature costs far more than another design round.

4. **{{COL_AGENT_READY}} through review** → *developers' and agents' move.*
   One exception involves you: a developer may invite you to a
   **walkthrough** — sitting together, hands on the product, accepting the
   feature check by check. Your observations, in your words, become the
   test record.

5. **{{COL_DOCUMENTATION}}** → **`document`**. Drafts user documentation
   from what actually shipped (not what was planned), iterates with you,
   and posts the approved text on the issue.

6. **{{COL_COMMUNICATION}}** → **`communicate`**. Release notes,
   announcements, marketing copy — grounded strictly in the approved
   documentation.

7. **{{COL_RELEASE}}** → the feature ships; a human closes the issue. Done.

After each of your skills finishes, **you drag the card** to the next
column on the board — that drag is the handoff. The little labels on issues
mirror the columns automatically; never edit those by hand.

## Standalone situations

Off the main flow entirely:

- **"Something is broken" / "I have a request"** — just create an issue on
  `{{REPO}}` describing what you saw or need, in your own words. It lands
  in triage automatically; if it needs your requirements input, it will
  come back to you in {{COL_CLARIFICATION}} and `clarify` takes it from
  there.
- **"What's the status of X?"** — ask here; the issue's board column *is*
  the status, and it can be looked up for you along with the latest
  comments.
- **"The developers wrote something I don't understand"** — ask for a plain
  translation of the comment or spec. If it's a whole design you're
  reviewing, that's `double-check`'s job — run it at its stage instead.
- **"Which of these applies to me?"** — this skill. You're already here.

## Two rules worth keeping

1. **Facts are the agent's job, decisions are yours.** In every skill here,
   you should never be asked to look something up — only to decide.
2. **The board is the source of truth.** When in doubt, open
   [the board]({{BOARD_URL}}) — the column answers "whose move is it?"
   better than any meeting.
