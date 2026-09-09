---
name: ask-mike
description: Ask which skill or step fits your situation as a business user in the {{PRODUCT_NAME}} development process. A router over the business-side skills and stages.
disable-model-invocation: true
---

# Ask Mike

You don't remember every skill or stage, so ask. This is the business
side's router (engineering's equivalent, where that pack is installed, is
**ask-matt**): it tells you where you are in the process, whether it's
your move, and which skill to run.

When the user describes their situation, route them using the map below —
and when it helps, look up the actual state of their issue on the resolved
repository through the GitHub connector rather than answering in the
abstract.

## Which board are we in?

The user may work across several products' boards. Resolve the active one
before routing, in this order — never ask while a rung still answers:

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
rather than guessing at an unjoined board. Everything below ("the board",
the columns) refers to the resolved product's board.

## The main flow: idea → shipped feature, from your seat

Work ping-pongs between you and {{AGENT_READY_ACTOR}}. The
[board]({{BOARD_URL}}) shows every issue in its current stage; the column
tells you whose move it is. Yours are these:

1. **You have an idea, or an issue sits in {{COL_CLARIFICATION}}** →
   **`clarify`**. It interviews you about the *user side* only — who it's
   for, where it lives in their day, what "done" looks like — never about
   technology. It ends by writing the clarified requirements onto the issue
   (creating one if needed) and handing the card to **{{COL_DESIGN}}**.

2. **{{COL_DESIGN}}** → *{{DESIGN_ACTOR}}'s move.* The approach gets
   worked out and published on the issue as a spec or outline. Nothing for
   you to run; answer questions if you're pinged on the issue.

3. **The issue reaches {{COL_DOUBLE_CHECK}}** → **`double-check`**, your
   most important move. The design gets played back to you in
   plain language: what will be built, what will *not* be built, what
   trade-offs were made. Confirm it and the card moves on; find a
   misunderstanding and it bounces back to design — say so plainly, a wrong
   feature costs far more than another design round.

4. **{{COL_AGENT_READY}} through review** → *{{AGENT_READY_ACTOR}}'s
   move.* One exception involves you: you may be invited to a
   **walkthrough** — sitting together, hands on the result, accepting it
   check by check. Your observations, in your words, become the test
   record.

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

- **"Am I set up?" / first time here / GitHub errors** — run **setup**. It
  self-tests your GitHub access and fixes the connection step by step,
  even if you don't have a GitHub account yet.
- **"I also work on <another product>" / "add another board"** — run
  **join**. It connects another repository that runs the same pipeline and
  records your preferences there; after that, name the product or paste a
  link and every skill follows you there.
- **"Something is broken" / "I have a request" / "here's a list of
  things"** — run **new-issue**. It slices what you bring into
  right-sized issues (one topic may split into several, a list may merge
  into one), checks for duplicates, and lands everything in triage. When
  an issue needs your requirements input, it comes back to you in
  {{COL_CLARIFICATION}} and `clarify` takes it from there.
- **"What's the status of X?"** — ask here; the issue's board column *is*
  the status, and it can be looked up for you along with the latest
  comments.
- **"Someone wrote something I don't understand"** — ask for a plain
  translation of the comment, spec, or outline. If it's a whole design
  you're reviewing, that's `double-check`'s job — run it at its stage
  instead.
- **"Which of these applies to me?"** — this skill. You're already here.

## Three rules worth keeping

1. **Facts are the agent's job, decisions are yours.** In every skill here,
   you should never be asked to look something up — only to decide.
2. **The board is the source of truth.** When in doubt, open
   [the board]({{BOARD_URL}}) — the column answers "whose move is it?"
   better than any meeting.
3. **You never need to memorize anything.** Every skill ends by telling
   you your next move and the exact words to say when you're ready — one
   line, one issue, a fresh session. If you've lost the thread anyway,
   that's what this skill is for.
