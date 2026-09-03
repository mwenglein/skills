---
name: brainstorm
description: Widen the view - develop raw ideas into candidate marketing pieces through divergent rounds (angles, audiences, formats, series). Use before clarify, when the goal is options rather than decisions.
---

Develop raw material into candidate marketing pieces by **widening** — the
opposite motion to `clarify`, which narrows a chosen piece by getting
concrete. This skill produces options, not decisions: it runs before a
brief exists, and its output is a set of triage-ready candidates the user
can pick from.

The repo's collaboration conventions (stage names, board, how to move
issues) should have been provided to you — see `docs/agents/collaboration.md`.
If they are missing, tell the user to run `/configure` first.

## Gather the raw material

Start from whatever the user brings — a stray idea, a hunch, "we should do
more marketing" — and ground it in the repo's reality before diverging:

- **What shipped** (the best raw material): recent merged work, changelog
  entries, docs updates — per the repo's conventions for finding them
- **What users ask about**: support threads, community questions, sales
  objections the user can name
- **The calendar**: seasonal hooks, upcoming releases the user knows about,
  industry events
- **What competitors are saying**: only what the user volunteers or a
  `/scout` run already collected — this skill generates, it does not browse

## Diverge in rounds

Run expansion like a grilling session run in reverse: instead of a frontier
of questions, each round spreads a branch into candidates. Number the
candidates and keep judgment out of the rounds entirely — quantity first,
filtering only at the end.

Round by round, spread along these axes:

- **Angles** — problem/solution, how-to, story/anecdote, data/numbers,
  contrarian take, behind-the-scenes, comparison
- **Audiences** — who hears this differently? (end users, buyers, the
  already-convinced, the skeptical)
- **Formats** — blog post, social thread, short video, newsletter blurb,
  changelog highlight, webinar, case study
- **Series potential** — which candidates are really one piece of a running
  series? Series compound; one-offs don't.

Say explicitly when a round is done and what the next round spreads along.
Two to four rounds are usually enough; more only when the user is enjoying
it.

## Converge — but let the user decide

When the rounds are exhausted, cluster the candidates (same angle, same
audience, same series), then score each cluster lightly on three axes:
**effort** to produce, **impact** if it lands, **timeliness** (why now).
Present the table and your recommendation — the user picks the survivors;
you never silently drop candidates they liked.

## Landing the survivors

Per the repo's conventions: for each survivor, create (or annotate) an
issue in the triage stage with a one-paragraph seed — the idea, the
audience hunch, the format hunch, why now. The board move to triage is the
maintainer's; list which issues you created and stop there.

Completion: survivors captured as triage-stage issues, user confirmed the
shortlist. Hand off to `clarify` for whichever piece the user wants to
narrow first.
