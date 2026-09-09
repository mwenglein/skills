---
name: new-issue
description: Turn what's on your mind into right-sized {{PRODUCT_NAME}} issues - one topic may split into several, a pasted list may merge into one. Checks for duplicates first; everything lands in triage.
---

Capture what the user brings — a bug, an idea, a question, or a whole
pasted list of topics — as **right-sized issues** on the resolved
repository. This is
the front door of the pipeline: quick capture, not a grilling. The deep
requirements interview is **clarify**'s job, later, when the card reaches
{{COL_CLARIFICATION}}.

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
rather than guessing at an unjoined board. Everything below says "the
resolved repository" for the repository settled here.

## 1. Listen

Take the user's input in their own words — one topic, a vague cluster, or
a pasted list. Ask at most a question or two, and only what capture needs:
what happened or what they want, who it affects, how much it hurts. No
solutions, no technology, no design — park anything deeper for the
clarification stage.

## 2. Slice — the part that matters

The user's input rarely maps one-to-one onto issues. Before creating
anything, propose a slicing. The test for "one issue" is the **one-card
test**: an issue travels the whole board as a single card — if two things
would always sit in the same column at the same time and be accepted in
one go, they are one issue; if they could move at different speeds, they
are two.

**Split** one topic into several issues when it hides:

- independently valuable pieces — one could ship while another waits
- different kinds of work — a bug fix and a new idea never share a card
- different audiences or product areas — they'll be handled by different
  people at different times
- different urgencies — the urgent part shouldn't be dragged by the rest

**Combine** several topics into one issue when they are:

- fragments of one journey — only useful together, accepted in one demo
- the same request said three ways
- a list of small touch-ups to the same thing, moving as one batch

Present the proposed slicing as a short plan — each candidate issue as a
title plus a one-liner, with what got merged or separated and why — and
let the user confirm or rearrange it. Their cut wins.

## 3. Check for duplicates

For each candidate, search existing open issues on the resolved repository through the
connector (title keywords, the product area, the user's phrasing). On a
match, show it and offer to add the user's observation as a **comment on
the existing issue** instead of filing a twin — a second card for the same
work splits the discussion.

## 4. Create

For each confirmed slice, create the issue:

- **Title**: plain language, the problem or wish — not a solution
- **Body**: what happens today (or is missing), who it affects and how
  badly, what "better" would look like in the user's words, and anything
  pasted worth preserving verbatim
- **No labels, no board moves** — the issue lands in triage automatically,
  and triage decides what happens next
- Related siblings from one slicing reference each other (`Refs #n`) so
  nobody rediscovers the connection later

## 5. Point at clarify — but don't start it

Creation isn't the finish line — an unclarified issue just waits. Close
out by naming the next step, **without taking it**: never roll from here
into a clarify session, and especially not into several.

- Explain the path: a maintainer triages the new issues; the ones that go
  forward appear on the [board]({{BOARD_URL}}) and need their requirements
  input in {{COL_CLARIFICATION}}. Status any time: **ask-mike**.
- Suggest clarify as the natural next step, with honest expectations:
  it's a real interview, so it deserves a bit of set-aside time, **one
  issue per session** — not a batch skim. If several issues were just
  created, suggest which one deserves it first (most urgent or most
  valuable) and why.
- Hand them the exact prompt to use when they're ready, for example:
  _"clarify issue #12"_ — one line, one issue, a fresh session. The rest
  of the issues keep; each gets its own line, its own sitting.
