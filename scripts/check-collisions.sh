#!/usr/bin/env bash
# Guard the flat skill namespace: no skill in this package (IDE or web tree)
# may share a name with a skill in mattpocock/skills, because installed
# skills all land in one .agents/skills folder — and mixed-team readers must
# never wonder which package a name belongs to.
#
# Compares frontmatter names against the pinned vendor/mattpocock submodule.
# Run after `git submodule update --remote vendor/mattpocock` to learn
# immediately when an upstream release claims a name we use.
set -euo pipefail

cd "$(dirname "$0")/.."

[ -f vendor/mattpocock/README.md ] || {
  echo "error: vendor/mattpocock submodule not initialized (git submodule update --init)"
  exit 1
}

names_of() {
  # frontmatter `name:` of every SKILL.md under the given roots
  find "$@" -name SKILL.md -exec awk -F': ' '/^name:/ { print $2; exit }' {} \; | tr -d '\r' | sort -u
}

OURS=$(names_of skills skills-web)
UPSTREAM=$(names_of vendor/mattpocock/skills)

COLLISIONS=$(comm -12 <(echo "$OURS") <(echo "$UPSTREAM"))
if [ -n "$COLLISIONS" ]; then
  echo "FAIL: skill name collision(s) with mattpocock/skills:"
  echo "$COLLISIONS" | sed 's/^/  - /'
  exit 1
fi

echo "no collisions with upstream ($(echo "$UPSTREAM" | wc -l | tr -d ' ') upstream names checked)"
echo "our skills: $(echo "$OURS" | tr '\n' ' ')"
