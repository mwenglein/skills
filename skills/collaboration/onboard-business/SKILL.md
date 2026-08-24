---
name: onboard-business
description: Integrate the business team into the development process - build their web skill pack from this repo's config and walk the developer through provisioning, subscriptions, and upload. Run after /configure, and again whenever skills or config change.
disable-model-invocation: true
---

Walk a developer through integrating their **business team** into the
agentic development process: business users run `clarify`, `double-check`,
`document`, and `communicate` from a chat product (no IDE, no git), which
requires building customized skill uploads and provisioning them centrally.

This is a genuinely helpful dialogue, not a script dump. At each step,
explain what is happening and why before doing it.

## 1. Explain the model

Open by explaining, briefly and concretely:

- The business team participates through **six web skills** built from
  templates in this package, with this repo's facts (repo slug, board URL,
  product name, setup contact) baked in at build time: the four stage
  skills, `ask-mike` — the router that tells a business user where they
  are in the process and which skill fits — and `setup`, the first-run
  preflight that gets a user from nothing (no GitHub account, no
  connector) to a verified connection.
- The skills talk to GitHub through the chat product's **GitHub
  connector/MCP** — business users need GitHub accounts with issue
  read/write on this repo, but never touch code or branches. Users who
  lack an account or access get walked there by `setup`; be ready to
  grant repo access when it sends them to you.
- The ping-pong, per the mode in `docs/agents/collaboration.md`: **full**
  — business clarifies → developers design → business double-checks →
  developers implement → both walk through → business documents and
  communicates. **Standalone** — the same loop with the agent in the
  developers' seat: `outline` designs, `draft` produces.

## 2. Check prerequisites

- `skills-web.config.json` and `docs/agents/collaboration.md` exist — if
  not, stop and run `/configure` first.
- Ask which **agentic setup the business users have**. Currently supported:
  **Claude.ai** (Team/Enterprise, or individual Pro/Max accounts) — its
  Agent Skills feature runs this package's `SKILL.md` format natively.
  Other major frameworks (e.g. ChatGPT/custom GPTs) do not run this format
  today; if that is the answer, say so honestly and stop rather than
  improvising a port.
- **Recommend a team subscription** and explain why: org-provisioned skills
  are uploaded once by an org owner, appear for every member automatically,
  and re-uploading replaces them in place — so every business user is
  always on the same version. Individual accounts work but every user
  uploads and updates by hand, which drifts.

## 3. Build the pack

From the consuming repo (this package available at the path recorded in the
collaboration doc, typically a `vendor/` submodule):

```bash
<package-path>/scripts/build-web-skills.sh -c skills-web.config.json -o dist/web-skills
```

Explain the output: one zip per skill, validated (names, description
limits, no unresolved placeholders, no CLI dependencies). Show the user the
list.

## 4. Walk the upload

- **Team/Enterprise org**: an org owner uploads each zip under
  **Organization settings → Skills**. Members may need Skills/code
  execution enabled (default-on for Team plans).
- **Individual accounts**: each user uploads under **Customize → Skills**.

Then each business user connects GitHub once (**Settings → Connectors →
GitHub**), authenticating with their own GitHub account. Verify with them:
org membership plus issue read/write on the repo is enough.

## 5. Hand over a pilot script

End by giving the developer a short pilot to run with one business user:

0. The business user runs `setup` first — it self-tests their GitHub
   access and walks them from wherever they are (no account, no
   connector, no repo access) to a verified connection
1. Pick a real, fuzzy feature idea → "clarify this idea" (`clarify`) —
   issue appears in the clarification stage on the board
2. The design stage runs (developers grill and spec it, or `outline` in
   standalone mode) → business runs `double-check` on the result
3. After the work ships: "what's waiting for documentation?" (`document`),
   then `communicate` one stage later
4. Confirm every hop is visible on the board

Remind them: when skills or config change, re-run this skill — rebuilding
and re-uploading is the whole update story.
