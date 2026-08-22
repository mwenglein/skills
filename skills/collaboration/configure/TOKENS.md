# Board automation tokens — org vs personal account

Everything about token strategy branches on one fact: **who owns the
repository**. Establish it before recommending anything. All findings below
were empirically verified on a production setup (private personal repo,
GitHub Free) as of 2026-08.

## Organization-owned: the happy path

One fine-grained PAT covers everything: **org "Projects" read/write** (under
Organization permissions) + **repo Issues read/write** + **repo Pull
requests read** (needed to promote issues whose referencing PR merged).
Scope it to the single repo. Done — none of the rest of this document
applies.

## Personal-account repos: the core limitation

**Fine-grained PATs have no Projects permission for user-owned Projects v2
boards.** The fine-grained token UI shows a "Projects" entry under
*Repository permissions* — that is the **legacy repo-projects feature, a
decoy**; it does nothing for Projects v2. There is no account-level Projects
permission to find either. Say this to the user up front so they don't
spend an hour hunting for it.

Board access on personal accounts therefore means **classic tokens**, with
these facts shaping every workaround:

- `read:project` exists and grants read-only board access — good.
- **There is no read-only private-repo scope on classic tokens.** The
  minimum scope that grants private repo *content* visibility is full
  `repo` — read **and write**, on **every repo the account can access**. No
  sub-scope (`repo:status`, `public_repo`, …) helps.
- Editing a classic token's scopes **in place keeps the token value** — CI
  secrets don't need rotating after a scope change.

## The GraphQL visibility trap (the expensive lesson)

A classic token with **only** `read:project` can read a private board's
structure, field values, and items — **but not item content, not even the
linked issue's number**, when the item's repo is private. Any board↔issue
join then fails silently: items appear unlinked, and sync logic
misinterprets on-board issues as missing (taking intake paths, posting
wrong nudges).

Corollary for architecture: GraphQL queries that **mix repo data and board
data** (e.g. `repository.issue.projectItems`) cannot be served by split
tokens at all. Split-token designs must decompose into **number-keyed
joins** — the board query yields item + issue number, repo queries supply
state/labels — and even that only works if the board token also has repo
visibility.

## The configuration ladder (present in this order)

**(a) Single classic PAT** — `repo` + `read:project`, short expiry.
Simplest and broad; fine for solo owners who accept the blast radius (the
token can write every repo the account touches).

**(b) Two-token split, board-writes-off.** A fine-grained PAT (this repo
only: Issues read/write, Pull requests read) does all issue/label/PR work;
a classic `repo` + `read:project` token does board **reads**. The
automation never writes the board: promotions and intake degrade to
**idempotent, self-updating nudge comments** naming the due drag (and
self-deleting once conditions resolve). GitHub's **built-in Projects
workflows** replace the write side:

- *Auto-add to project* with filter `is:issue` — note GitHub Free allows
  **one** auto-add rule per project
- *Item added → set Status* (the intake column)
- *Auto-archive items*

Two UI decoys to warn about: built-in workflows live behind the project's
**⋯ menu → Workflows**, *not* the Settings page; and the built-in "Pull
request merged" workflow moves **PR items only, never referenced issues** —
issue promotion on PR events stays script/nudge territory.

**(c) Machine account — the clean confinement.** A dedicated account with
**Triage** on the repo and **Read** on the board; its classic
`repo` + `read:project` token then *structurally* reaches only that.
Recommend when (a)'s breadth is unacceptable and (b)'s degradation is too
weak.

**(d) Move to an org — the exit.** At org level one fine-grained token
replaces everything above. Design any project-lookup code to query
`organization` first and fall back to `user`, so the later migration is
config-only.

## Process safety (encode regardless of tokens)

- **`Refs #n`, never `Closes #n`** in PR bodies — issues must survive the
  merge to travel the pipeline.
- A **merge-close rescue** (reopen + nudge when GitHub auto-closes) needs
  only Issues write, so it works in every configuration.
- Auto-promotion must **never demote**.
- Local `gh` CLI users need the `project` scope before any board scripting
  works: `gh auth refresh -s project`.

## The doctor probe

After **any** token change, run the read-only probe this package ships:

```bash
<package-path>/scripts/board-doctor.sh
```

It reports a per-token capability matrix — most importantly **"N items, M
linked to issue numbers"** — turning the silent visibility trap above into
a one-line diagnosis instead of a debugging afternoon.
