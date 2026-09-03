---
name: scout
description: Research one or more marketing ideas on the open internet - competitor pages, keyword and trend data, video transcripts, community threads, prior art. Use when a brief needs evidence; posts a distilled research note on the issue.
---

Research one or more ideas on the open internet and distill the findings
into evidence a marketing brief can stand on. This is the marketing side of
research: demand signals, competitor moves, and the existing content
landscape — grounded enough that audience and message decisions stop being
guesses.

The repo's collaboration conventions should have been provided to you — see
`docs/agents/collaboration.md`. If they are missing, tell the user to run
`/configure` first.

## Scope the mission

Input: one or more issue numbers, or a topic the user names. For each
target, read the issue (or ask) to learn what decision the research serves —
"which audience?", "is there demand?", "what angle is unclaimed?" — and
state the mission back in one sentence before searching. Research without a
question produces notes, not evidence.

## Sources, in order of trust

1. **Primary**: competitor websites, documentation, pricing pages,
   changelogs, launch posts — what they claim, how they position, what they
   charge, what they omit
2. **Demand signals**: search trends and keyword data (use whatever tools
   the repo's config provides; fall back to autocomplete and "people also
   ask" patterns), community threads (Reddit, Hacker News, Discord,
   forums), review sites, customer questions the user can point at
3. **The content landscape**: existing articles and videos on the topic —
   watch videos where possible (transcripts when available), note their
   angle, depth, and published date. Gaps in the landscape are
   opportunities.

## Method

- **Engine**: use the `web-browse` skill's Tavily tools when available —
  `tavily_search` for demand signals, `tavily_extract` for primary-source
  pages (competitor pricing, changelogs, docs), `tavily_map`/`tavily_crawl`
  only with a stated page budget. Fall back to built-in search/fetch when
  Tavily is not connected.
- Plan the queries before running them; say what you are searching and why
- **Cite every claim**: URL plus access date. No URL, no claim.
- Separate **facts** (what a source says) from **interpretation** (what you
  think it means) — label them distinctly in the notes
- Record negative results and contradictions between sources explicitly —
  "nobody covers X" is a finding, and conflicting sources are a flag to
  raise, not smooth over
- Use the available web search/fetch tooling; when a page needs interaction,
  say so and ask before driving a browser

## The research note

Post findings as an issue comment under `## Research notes`:

- **TL;DR** — three lines that answer the mission
- **Key findings** — each with its citation
- **Competitor snapshots** — who says what, positioned how
- **Demand signals** — keywords/trends/questions observed, with rough
  magnitude and direction
- **Content gaps** — what the landscape does not cover (the opportunity)
- **Risks** — claims to avoid, crowded angles, stale data

Completion: the note is posted and the user confirms the direction it
suggests. It feeds three consumers downstream: `clarify` (audience and
message decisions), `outline` (structure and keywords), and `greenlight`
(the claims-accuracy baseline the copy will be checked against).
