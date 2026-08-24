# Collaboration conventions

<!-- Written by /configure (mwenglein/skills). Edit freely — this file, plus
     skills-web.config.json, is the ONLY place repo-specific process facts
     live. The collaboration skills read this at runtime and never hardcode
     stage names, board URLs, or repo slugs. -->

## Mode

- Collaboration mode: <!-- full (business + developers; mattpocock/skills
     installed alongside) | standalone (document repo — business decides,
     the agent produces the deliverables; no developer pack installed) -->

## The board

- Project: <!-- board URL -->
- The board's Status field is the source of truth for workflow states.
- Issues move by: <!-- "dragging cards" and/or the exact helper command,
     e.g. `bun run scripts/triage-status.ts set <n> <slug>` -->

## Board automation tokens

<!-- Filled by /configure from its TOKENS.md guidance. -->

- Repo owner type: <!-- organization | personal account -->
- Strategy: <!-- org fine-grained PAT | ladder rung (a)/(b)/(c) with the
     consequences accepted, e.g. "(b) two-token split: automation never
     writes the board; promotions arrive as nudge comments; built-in
     project workflows handle auto-add/status/archive" -->
- Tokens: <!-- name → where stored (CI secret / 1Password), scopes -->
- Doctor (re-run after ANY token change):
  `PROJECT_OWNER=… PROJECT_NUMBER=… REPO=… BOARD_TOKEN=… <package-path>/scripts/board-doctor.sh`

## Canonical stage mapping

<!-- Owner and Skill for design and agent-ready depend on the mode —
     /configure fills them: full = developers running grill-with-docs →
     to-spec and to-tickets → implement; standalone = outline and draft
     from this package. All nine stages exist in both modes. -->

| Canonical stage | Board column | Derived label | Owner | Skill |
| --------------- | ------------ | ------------- | ----- | ----- |
| triage          | <!-- --> | <!-- --> | maintainer | <!-- full: triage · standalone: by hand --> |
| clarification   | <!-- --> | <!-- --> | business   | clarify |
| design          | <!-- --> | <!-- --> | <!-- -->   | <!-- full: grill-with-docs → to-spec · standalone: outline --> |
| double-check    | <!-- --> | <!-- --> | business   | double-check |
| agent-ready     | <!-- --> | <!-- --> | <!-- -->   | <!-- full: to-tickets → implement · standalone: draft --> |
| review          | <!-- --> | <!-- --> | both       | walkthrough |
| documentation   | <!-- --> | <!-- --> | business   | document |
| communication   | <!-- --> | <!-- --> | business   | communicate |
| release         | <!-- --> | <!-- --> | human      | (close on release) |

Stages marked "not used" are skipped in this repo; skills for them should
tell the user the stage is not configured.

## The ping-pong

<!-- /configure keeps the variant matching the mode and deletes the other. -->

<!-- FULL MODE -->
Business and developers alternate; each stage has one owner:

1. **clarify** (business) — user requirements grilled and captured on the issue
2. **grill-with-docs → to-spec** (developers) — technical design grilled and published
3. **double-check** (business) — the design played back in business language; misunderstandings bounce it to design
4. **to-tickets → implement** (developers + agents) — sliced and built
5. **walkthrough** (both) — hands-on acceptance of each PR
6. **document** (business) — user docs from what actually shipped
7. **communicate** (business) — release notes, announcements, marketing

<!-- STANDALONE MODE -->
Business decides, the agent produces; each stage has one owner:

1. **clarify** (business) — the deliverable's requirements grilled and captured on the issue
2. **outline** (business + agent) — audience, structure, sources, and position grilled; the outline published on the issue
3. **double-check** (business) — the outline played back in plain language; misunderstandings bounce it to design
4. **draft** (agent) — the document written on a branch, opened as a PR (`Refs #n`)
5. **walkthrough** (both) — guided read-through acceptance of each PR
6. **document** (business) — the shipped change captured for its audience
7. **communicate** (business) — announcements and follow-through from the approved text

## Web skill pack

The business team's web skills (ask-mike, clarify, double-check, document,
communicate) are built from this repo's
`skills-web.config.json` by <!-- package path, e.g. vendor/skills -->
`/scripts/build-web-skills.sh`. Rebuild and re-upload after any config or
package update (`/onboard-business` walks through it).
