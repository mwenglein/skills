# skills

**Agent skills that integrate business users into agentic development.**

[mattpocock/skills](https://github.com/mattpocock/skills) gives engineering
teams a disciplined agentic workflow — grilling, specs, tickets, TDD,
review. This package adds the missing half: the **business users** who know
what should be built, working in the same pipeline from a plain chat
product, no IDE, no git.

The two packages are **complementary, not competing**: install both, side by
side, in the same repo. Nothing here replaces or wraps an upstream skill —
the collision-checked flat namespace guarantees a name always means exactly
one thing.

## The ping-pong process

Business and developers alternate. Each stage has one owner; the board makes
every handoff visible.

```
BOARD STAGE              BUSINESS                          DEVELOPERS
═══════════════          ════════════════════════          ═══════════════════════════

Clarification      ┌───────────────────────────┐
                   │  clarify                  │
                   │  grill USER requirements  │
                   └─────────────┬─────────────┘
                                 ▼
Design                                              ┌───────────────────────────┐
                                                    │  grill-with-docs          │
                                                    │  grill TECHNICAL design   │
                                                    │  → to-spec publishes it   │
                                                    └─────────────┬─────────────┘
                                 ┌────────────────────────────────┘
Double-check       ┌─────────────▼─────────────┐
                   │  double-check             │    misunderstandings?
                   │  design played back in    │──────► bounce to Design
                   │  business language        │
                   └─────────────┬─────────────┘  confirmed
                                 └────────────────────────────────┐
Agent-ready                                         ┌─────────────▼─────────────┐
& implementation                                    │  to-tickets → implement   │
                                                    │  (+ tdd, code-review)     │
                                                    └─────────────┬─────────────┘
                                 ┌────────────────────────────────┘
Review             ┌─────────────▼─────────────┐
                   │  walkthrough  (BOTH, together)          │
                   │  hands-on acceptance of each PR         │
                   └─────────────┬───────────────────────────┘
                                 ▼
Documentation      ┌───────────────────────────┐
                   │  document                 │
                   └─────────────┬─────────────┘
Communication      ┌─────────────▼─────────────┐
                   │  communicate              │
                   └─────────────┬─────────────┘
                                 ▼
Release                  ship → close the issue
```

While agents implement one feature, business is clarifying the next and
documenting the last — the lanes run in parallel, the stages are where they
touch.

## What's inside

**IDE skills** (`skills/collaboration/`) — installed next to
mattpocock/skills via the skills CLI:

| Skill | Owner | What it does |
| --- | --- | --- |
| `clarify` | business (dev-facilitated) | User-requirements grilling: personas, journeys, outcomes — never architecture |
| `walkthrough` | both | Hands-on acceptance walkthrough of implemented tickets, one PR at a time, per-walker stamps |
| `configure` | developers | One-time setup wizard: maps the canonical stages to your board, writes the two config files |
| `onboard-business` | developers | Builds the business team's web pack from your config and walks through provisioning |

**Web skills** (`skills-web/`) — templates, built into self-contained
uploads for the business team's chat product (currently Claude.ai Agent
Skills):

| Skill | Stage | What it does |
| --- | --- | --- |
| `ask-mike` | any | The business-side `ask-matt`: routes a business user to the right skill and explains whose move it is at each stage |
| `clarify` | Clarification | Same grilling, adapted to the GitHub connector; creates/annotates the issue |
| `double-check` | Double-check | Plays the technical design back in business language; hunts misunderstandings before implementation |
| `document` | Documentation | User docs drafted from what actually shipped, posted to the issue |
| `communicate` | Communication | Release notes, announcements, marketing on top of the approved docs |

## Install

Already running mattpocock/skills:

```bash
npx skills add mwenglein/skills
```

Fresh repository, everything at once:

```bash
npx skills add mattpocock/skills mwenglein/skills
```

Then, in your repo, run the `/configure` skill (maps your board, writes
`docs/agents/collaboration.md` + `skills-web.config.json`) and
`/onboard-business` (builds and provisions the business team's web pack).

For the web-pack build tooling in CI, pin this repo as a submodule:

```bash
git submodule add https://github.com/mwenglein/skills vendor/skills
vendor/skills/scripts/build-web-skills.sh -c skills-web.config.json -o dist/web-skills
```

## Design principles

- **One config surface.** Repo-specific facts live in exactly two files
  (`docs/agents/collaboration.md` for runtime, `skills-web.config.json` for
  build time). Skills speak canonical stage names; nothing leaks.
- **Flat namespace, zero collisions.** CI compares every skill name against
  the pinned upstream submodule (`vendor/mattpocock`); bumping the pin is
  how we learn upstream claimed a name.
- **The board is the source of truth.** Skills read state labels (derived
  mirrors) and tell humans which card to drag; they never fight the board.
- **What shipped wins.** Documentation and communication are grounded in
  merged PR descriptions, not plans.

## Updating

- This package: `npx skills update` (CLI installs) or bump the submodule pin.
- Upstream inside this repo: `git submodule update --remote vendor/mattpocock`,
  then CI's collision check validates the new pin.
- Versioning via [changesets](https://github.com/changesets/changesets);
  tagged releases on `main`.

## License

MIT — as is [mattpocock/skills](https://github.com/mattpocock/skills), which
this package pins as a submodule for validation and never redistributes.
