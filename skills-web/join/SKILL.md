---
name: join
description: Connect another product's board or repository to your {{PRODUCT_NAME}} skills - test access, verify the repo runs the pipeline, and record your preferences. Run once per additional product.
disable-model-invocation: true
---

# Join

Your {{PRODUCT_NAME}} skills ship pointed at one product's board
(`{{REPO}}`). This skill adds **another** product — a second repository
and its board — so the same skills work there too, in the same chat
product, with the same skill names. Run it once per product, and re-run it
if access breaks or the product's process changes.

Everything here needs only **issue read/write** on the target repository —
never code access, never secrets.

## 1. Name the product

Ask which repository or board they want to join, and accept any shape of
answer:

- **A URL** (repository, board, or issue link) — always preferred; extract
  the repository from it.
- **A product or repository name** — resolve it through the GitHub
  connector.
- **Something fuzzy** ("the strategy one") — search the connector for the
  repositories their account can reach and show the candidates, short
  names first.

## 2. Test access

Before anything else, try to read the target repository through the
**GitHub connector**: fetch the repository and list a few of its issues.

- **It works** → continue below.
- **Connector missing or not authorized** → the fix is the same as in the
  **setup** skill: Settings → Connectors → GitHub → Connect (on
  Team/Enterprise plans an admin may need to enable it first). Walk them
  through it, or send them to setup if they have no GitHub account at all.
- **Repository unreachable** → their account lacks access. Ask who owns
  or maintains this product, and have the user ask **that person** (this
  product's equivalent of {{SETUP_CONTACT}}) for access: issue read/write
  only, default member role, invitation accepted before retesting — the
  same ladder setup uses, pointed at a different door.

## 3. Verify the pipeline

A repository can only be joined if it runs **this same pipeline**. The
proof is mechanical: a **pinned issue labelled `pipeline-home`**, written
by the repo's `/configure` run, whose body records the product name, the
repository slug, the board URL, the mode (full or standalone), and the
setup contact.

Through the connector:

1. Search the repository for the `pipeline-home` issue and read its body.
2. Follow the board URL from the body and confirm the board loads and
   shows columns.

Then one of three outcomes:

- **Home issue found and board reachable** → verified. Continue to step 4.
- **No home issue, but the repo clearly runs the process** (an older
  configuration) → tell the user the repo's maintainers need to re-run
  `/configure` there once — that creates the home issue — and to come back
  afterwards. Don't improvise a home issue from guesswork: it is the
  compatibility proof, and a wrong one is worse than none.
- **Neither home issue nor any sign of the pipeline** → this repository
  doesn't run the process. Give the user the exact words for its
  maintainers: _"Please run the /configure skill in this repository — it
  takes a few minutes and makes it work with our business-side skills."_
  Nothing else to do here until they have.

## 4. Record your preferences

With verification passed, post **one comment** on the home issue recording
what the user wants remembered on this product — for example:

- how they want to be addressed
- preferred language for issues and documentation
- anything else they ask to have noted

No secrets, ever. The comment is the product's memory of *this user*: it
travels with the repository, and any skill on any future conversation can
re-read it.

## 5. Ready

Close out concretely:

- Confirm in one line: joined **<product short name from the home issue>**
  (`<repository slug>`), board linked, preferences recorded.
- Tell them how to address this product from now on: use its **short
  name** in any skill ("the Acme backlog"), or simply paste a link to one
  of its issues or its board — every skill resolves the product from that.
- Point onward, without starting: **ask-mike** routes within whichever
  product is active, and **new-issue** is the natural first card there.

One habit worth stating: joined products never need re-joining — but if a
skill ever reports the repository unreachable, run **setup** (default
product) or **join** again (other products) rather than working around the
error.
