---
name: greenlight
description: Content review before publishing - verify claims against what actually shipped, brand voice, channel conventions, CTA, SEO basics; greenlight the piece or bounce it with specific notes. The content-pipeline review stage.
---

Review marketing copy for a piece in the review stage and decide: **greenlight**
it for publication, or bounce it back with specific notes. This is the
content-pipeline review — the sibling of `walkthrough`, checking words
against reality instead of clicks against acceptance criteria.

The repo's collaboration conventions should have been provided to you — see
`docs/agents/collaboration.md`. If they are missing, tell the user to run
`/configure` first.

## Load the source of truth first

The review compares copy against **what actually shipped** — never against
the plan or the brief's optimism. Per the repo's conventions, pull the
merged work behind the piece: PR descriptions, changelog entries, docs
pages. What shipped wins; where the copy claims more than reality supports,
reality wins.

Also load: the piece itself (PR diff or document), the issue's brief
(audience, message, channels decided during clarification), and any
`scout` research note — it is the claims-accuracy baseline.

## The checklist

Work the piece check by check, in dialogue with the user:

- **Claims accuracy** — every factual claim traceable to what shipped;
  superlatives ("fastest", "easiest") flagged unless evidenced; numbers
  carry their source
- **Brand voice** — consistent with the repo's established voice; if a
  `CONTEXT.md` or style notes exist, they are the reference
- **Channel conventions** — for each target channel from the brief: length,
  format, link and hashtag norms, first-line hook where the channel
  demands one
- **Call to action** — present, specific, and pointing somewhere real
- **Links and names** — every link resolves; third-party marks used
  correctly; customer names only with permission
- **SEO basics** — headline and body carry the keywords the outline chose;
  meta description exists where the channel uses one

Capture observations in the user's words — their wording is the revision
note.

## The verdict

- **All checks pass** → greenlight: post the approval comment listing the
  verified claims (the publish stage reuses this list), then note that the
  piece looks eligible for its next stage. Board moves stay human
  decisions.
- **Failures** → bounce: concrete, per-check notes on the issue, back to
  the draft stage. "Make it pop" is not a note; "second paragraph claims
  import-from-XYZ, ships in #1234 only for ABC — restate or cut" is.
- **Unverifiable claims** → follow-up on the source issue per the repo's
  conventions. The copy waits or gets cut; it never ships on guesswork.

Completion: verdict posted with the checked-claims list or the bounce notes.
