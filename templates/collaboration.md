# Collaboration conventions

<!-- Written by /configure (mwenglein/skills). Edit freely — this file, plus
     skills-web.config.json, is the ONLY place repo-specific process facts
     live. The collaboration skills read this at runtime and never hardcode
     stage names, board URLs, or repo slugs. -->

## The board

- Project: <!-- board URL -->
- The board's Status field is the source of truth for workflow states.
- Issues move by: <!-- "dragging cards" and/or the exact helper command,
     e.g. `bun run scripts/triage-status.ts set <n> <slug>` -->

## Canonical stage mapping

| Canonical stage | Board column | Derived label | Owner |
| --------------- | ------------ | ------------- | ----- |
| triage          | <!-- --> | <!-- --> | maintainer |
| clarification   | <!-- --> | <!-- --> | business   |
| design          | <!-- --> | <!-- --> | developers |
| double-check    | <!-- --> | <!-- --> | business   |
| agent-ready     | <!-- --> | <!-- --> | developers |
| review          | <!-- --> | <!-- --> | both       |
| documentation   | <!-- --> | <!-- --> | business   |
| communication   | <!-- --> | <!-- --> | business   |
| release         | <!-- --> | <!-- --> | human      |

Stages marked "not used" are skipped in this repo; skills for them should
tell the user the stage is not configured.

## The ping-pong

Business and developers alternate; each stage has one owner:

1. **clarify** (business) — user requirements grilled and captured on the issue
2. **grill-with-docs → to-spec** (developers) — technical design grilled and published
3. **double-check** (business) — the design played back in business language; misunderstandings bounce it to design
4. **to-tickets → implement** (developers + agents) — sliced and built
5. **walkthrough** (both) — hands-on acceptance of each PR
6. **document** (business) — user docs from what actually shipped
7. **communicate** (business) — release notes, announcements, marketing

## Web skill pack

The business team's web skills (ask-mike, clarify, double-check, document,
communicate) are built from this repo's
`skills-web.config.json` by <!-- package path, e.g. vendor/skills -->
`/scripts/build-web-skills.sh`. Rebuild and re-upload after any config or
package update (`/onboard-business` walks through it).
