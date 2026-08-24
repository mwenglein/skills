---
name: configure
description: Configure this repo for the collaboration skills - map the canonical process stages to the repo's board, and write the web-pack build config. Run once before first use, or when the board changes.
disable-model-invocation: true
---

Scaffold the per-repo configuration that the collaboration skills assume.
All repo-specific facts live in exactly **two files** — nothing is ever
hardcoded in a skill, so remapping the process later means editing these
files, not the skills:

- **`docs/agents/collaboration.md`** — the canonical-stage → board mapping
  plus how issues move; read by the IDE-side skills at runtime
- **`skills-web.config.json`** — the facts baked into the business team's
  web skills at build time (they ship as self-contained uploads and cannot
  read repo docs)

This is a prompt-driven skill, not a deterministic script. Explore, present
what you found, confirm with the user, then write.

## The two modes

The pipeline runs in one of two modes, and **this skill is the only place
modes exist** — every other skill just reads the mapping doc and speaks
stage names, so switching modes later means re-running `/configure`, not
touching any skill:

- **full** — business and developers collaborate; mattpocock/skills is
  installed alongside and owns the technical middle stages.
- **standalone** — a document repo (strategy papers, decision records):
  business decides, the agent produces the deliverables, and no developer
  pack is installed. When developers arrive later, install
  mattpocock/skills and re-run `/configure` — the board columns keep their
  names; the middle stages just change occupants.

## The canonical stages

All nine stages exist in both modes; only the middle two change hands. The
mapping doc translates the canonical names to whatever the repo's board
actually calls them:

| Canonical stage | Full mode (with mattpocock/skills)         | Standalone mode                     |
| --------------- | ------------------------------------------ | ----------------------------------- |
| triage          | maintainer — `triage`                      | maintainer — by hand                |
| clarification   | business — `clarify`                       | business — `clarify`                |
| design          | developers — `grill-with-docs` → `to-spec` | business + agent — `outline`        |
| double-check    | business — `double-check`                  | business — `double-check`           |
| agent-ready     | developers — `to-tickets` → `implement`    | agent — `draft`                     |
| review          | both — `walkthrough`                       | both — `walkthrough` (read-through) |
| documentation   | business — `document`                      | business — `document`               |
| communication   | business — `communicate`                   | business — `communicate`            |
| release         | human closes                               | human closes                        |

## Process

### 1. Explore

Read whatever exists; don't assume:

- `git remote -v` — which GitHub repo is this?
- **Mode evidence**: is mattpocock/skills installed (its skills — `triage`,
  `grill-with-docs`, `to-spec` — present in the repo's skills folder, or
  `docs/agents/issue-tracker.md` written by `setup-matt-pocock-skills`)?
  Installed → recommend **full**. Absent → recommend **standalone**; a repo
  of documents with no application code is standalone even if developers
  hang around it.
- **Owner type first**: is the repo owned by an **organization or a personal
  account** (`gh repo view --json owner --jq .owner`)? Everything about
  token strategy branches on this — see
  [TOKENS.md](TOKENS.md) before recommending any token setup.
- `docs/agents/collaboration.md` and `skills-web.config.json` — prior output
  of this skill? Then this is a re-run: present the current values and only
  ask about changes.
- `docs/agents/issue-tracker.md` / `triage-labels.md` — output of
  `setup-matt-pocock-skills`; reuse its answers (tracker, label vocabulary)
  rather than asking again.
- Does the repo have a GitHub Projects board? (`gh project list --owner <org>`)
  Which Status columns exist?
- Where do architecture docs and ADRs live? (`docs/architecture`, `docs/adr`,
  or wherever exploration finds them)

### 2. Present findings and ask

Lead each question with the recommended answer so the user can accept it in
a word:

1. **Mode** — full or standalone, led by the evidence found above. On a
   re-run where matt's skills have newly appeared, this is the headline
   question: switching to full rewires the design and agent-ready stages
   to the developer skills and nothing else.
2. **Board** — which project is the source of truth, and which column maps
   to each canonical stage? Propose the mapping from the column names found;
   flag canonical stages with no column and ask whether to add a column or
   mark the stage as "not used" (skills for unused stages tell the user the
   stage is not configured).
3. **How issues move** — dragged manually only, or does the repo have a
   helper script / automation? Record the exact command if one exists.
4. **Token strategy** — branch on the owner type established during
   exploration:
   - **Org-owned**: the happy path — one fine-grained PAT (org Projects
     read/write + repo Issues read/write + PR read). Recommend it and move
     on.
   - **Personal account**: fine-grained PATs cannot reach user-owned
     Projects v2 boards at all (the fine-grained UI's repo-"Projects" entry
     is a legacy decoy — warn the user before they hunt for it). Present
     the four-rung ladder from [TOKENS.md](TOKENS.md) **in order, with
     honest trade-offs**: (a) single classic `repo`+`read:project` token,
     (b) two-token split with board-writes-off (nudge comments + GitHub's
     built-in project workflows — which hide behind the project's **⋯ menu
     → Workflows**, not Settings), (c) machine account for structural
     confinement, (d) move to an org as the exit. Let the user pick a rung;
     record the choice and its consequences in the collaboration doc.
5. **Web-pack facts** — repo slug, board URL, product name, one example of
   a typical end user (e.g. "a coach or analyst"), architecture-docs path,
   ADR path, the **setup contact** (who a business user asks for repo
   access — name plus handle or email), and the two **stage actors** the
   web skills name for the middle stages: who works the design stage
   (full: "the developers"; standalone: e.g. "the drafting agent") and who
   works the agent-ready stage.

### 3. Confirm and write

Show drafts of both files, let the user edit, then write:

- `docs/agents/collaboration.md` from [collaboration.md](../../../templates/collaboration.md)
- `skills-web.config.json` from [skills-web.config.example.json](../../../templates/skills-web.config.example.json)

Add (or update) a `### Collaboration skills` line in the repo's `AGENTS.md`
or `CLAUDE.md` (edit whichever exists; never create a second one) pointing
to `docs/agents/collaboration.md`.

Regardless of the token rung chosen, bake the process-safety rules into
whatever automation exists (details in [TOKENS.md](TOKENS.md)): `Refs #n`
never `Closes #n` in PR bodies, merge-close rescue via Issues write,
promotion never demotes, and `gh auth refresh -s project` for local board
scripting.

### 4. Verify with the doctor

Finish by running the read-only capability probe against every token the
setup uses — it catches the silent classic-token visibility trap ("board
readable, item content invisible") as a one-line diagnosis:

```bash
PROJECT_OWNER=<owner> PROJECT_NUMBER=<n> REPO=<owner/name> \
  BOARD_TOKEN=… [ISSUES_TOKEN=…] <package-path>/scripts/board-doctor.sh
```

Healthy output ends with "N items, N linked to issue numbers" for the
board token. Record the exact command in the collaboration doc so it gets
re-run after **any** future token change.

### 5. Done

Tell the user which skills now read these files, and that the natural next
step is `/onboard-business` — building and provisioning the business team's
web skills from the config just written.

In standalone mode, also name the exit ramp: when developers join and
install mattpocock/skills, re-running `/configure` is the entire migration
— same board, same columns, the middle stages change owners.
