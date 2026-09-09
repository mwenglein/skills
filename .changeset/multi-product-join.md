---
"mwenglein-skills": minor
---

Multi-product participation for business users. A user can now take part
in several boards with one web pack, and the agent stays clear about which
product is meant without the user repeating themselves:

- **New `join` web skill**: connects another repository that runs the
  pipeline — tests access per repo (the setup ladder, pointed at a
  different door), verifies compatibility mechanically via the repo's
  pinned `pipeline-home` issue, and records the user's preferences for
  that product as a comment on it. Issue read/write only; no secrets.
- **Home issue**: `/configure` now creates a pinned `pipeline-home` issue
  recording product name, repository, board URL, mode, and setup contact —
  the mechanical compatibility proof on the business side and the lookup
  key for joined products.
- **Shared resolution ladder** in every web skill: the active product is
  resolved from the message (URL, issue number, product name), then
  conversation context, then the pack's default board — asking is the last
  resort, with short names, never repository slugs. Mid-conversation
  switches are announced explicitly.
