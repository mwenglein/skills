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

## The canonical stages

The collaboration skills speak in canonical stage names. The mapping doc
translates them to whatever the repo's board actually calls them:

| Canonical stage | Owner      | Skill there                     |
| --------------- | ---------- | ------------------------------- |
| triage          | maintainer | `triage` (mattpocock/skills)    |
| clarification   | business   | `clarify`                       |
| design          | developers | `grill-with-docs` → `to-spec`   |
| double-check    | business   | `double-check`                  |
| agent-ready     | developers | `to-tickets` → `implement`      |
| review          | both       | `walkthrough`                   |
| documentation   | business   | `document`                      |
| communication   | business   | `communicate`                   |
| release         | human      | (close on production release)   |

## Process

### 1. Explore

Read whatever exists; don't assume:

- `git remote -v` — which GitHub repo is this?
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

1. **Board** — which project is the source of truth, and which column maps
   to each canonical stage? Propose the mapping from the column names found;
   flag canonical stages with no column and ask whether to add a column or
   mark the stage as "not used" (skills for unused stages tell the user the
   stage is not configured).
2. **How issues move** — dragged manually only, or does the repo have a
   helper script / automation? Record the exact command if one exists.
3. **Token strategy** — branch on the owner type established in step 1:
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
4. **Web-pack facts** — repo slug, board URL, product name, one example of a
   typical end user (e.g. "a coach or analyst"), architecture-docs path,
   ADR path.

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
