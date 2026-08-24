---
name: setup
description: Test and fix your GitHub access for the {{PRODUCT_NAME}} skills, step by step - even starting from no GitHub account at all. Run once before your first skill, or whenever GitHub access fails.
disable-model-invocation: true
---

# Setup

One-time preflight for the {{PRODUCT_NAME}} collaboration skills. Assume
nothing about the user: they may never have used GitHub, and that is fine —
this skill walks them from wherever they are to a verified, working
connection. Be patient, concrete, and jargon-free throughout.

## 1. Self-test first

Before asking the user anything, try to read `{{REPO}}` through the
**GitHub connector**: fetch the repository and list a few of its issues.

- **It works** → skip straight to [Ready](#3-ready). Don't walk a user
  through steps they've already completed.
- **It fails** (connector missing, authorization error, repository not
  found or access denied) → work down the ladder below, top to bottom,
  re-running this self-test after every rung until it passes.

## 2. The ladder

### Rung 1 — no GitHub account (or not sure)

Ask plainly whether they have a GitHub account. If not, or they don't know:

- One sentence of context: GitHub is where all {{PRODUCT_NAME}} work is
  tracked — as **issues**, which are simply tickets with a discussion
  thread. They will only ever touch issues, never code.
- Have them create a free account at **github.com/signup**: work email, a
  username colleagues will recognize, then verify the email GitHub sends.
- Ask them to tell you the username once it exists — it's what the team
  invites in the next rung.

### Rung 2 — GitHub connector not connected

- In Claude.ai: **Settings → Connectors → GitHub → Connect**, then sign in
  with **their own** GitHub account and authorize.
- On a Team/Enterprise plan, if GitHub doesn't appear in the connector
  list, an organization admin has to enable it first — say so explicitly
  rather than letting the user hunt.

### Rung 3 — connected, but `{{REPO}}` is unreachable

The repository is private and their account hasn't been granted access:

- Tell them to ask **{{SETUP_CONTACT}}** for access to `{{REPO}}`, naming
  the repository exactly and passing along their GitHub username. What to
  ask for: **issue read/write** — the default member role is enough, and no
  code permissions are needed.
- The invitation arrives by email and at **github.com/notifications**; it
  must be **accepted** before anything works. Users miss this step —
  mention it.
- After accepting, re-run the self-test. If it still fails, have them
  re-authorize the connector (Settings → Connectors → GitHub) so it picks
  up the new membership.

## 3. Ready

Prove it, don't just claim it: show the user something real from the
self-test — the repository name and, say, the title of the newest issue —
and link the [board]({{BOARD_URL}}), which is where they'll always see
whose move it is.

Then point them onward:

- **ask-mike** — tells you where you are in the process and which skill
  fits; run it whenever unsure.
- **clarify** — the natural first skill when you bring an idea or a request.

One habit worth stating: if any skill ever hits a GitHub error, the fix
lives here — run **setup** again rather than working around the error.
