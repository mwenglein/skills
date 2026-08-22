#!/usr/bin/env bash
# Build the business team's web skill pack: substitute a consuming repo's
# facts into the skills-web/ templates, validate against the claude.ai
# upload rules, and zip one upload per skill.
#
#   build-web-skills.sh [-c skills-web.config.json] [-o outdir]
#
# Config: flat JSON of PLACEHOLDER -> value (see
# templates/skills-web.config.example.json). Every {{KEY}} in the templates
# must be covered; unresolved placeholders fail the build.
#
# Upload rules enforced:
#   - skill directory name equals the SKILL.md frontmatter `name`
#   - frontmatter `description` is <= 200 characters AFTER substitution
#   - no `gh` CLI usage (web skills talk to GitHub through the connector)
#
# Requires: jq, zip. The same zip serves org-wide provisioning
# (Organization settings -> Skills) and individual upload (Customize ->
# Skills).
set -euo pipefail

PKG_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
SRC="$PKG_ROOT/skills-web"
CONFIG="skills-web.config.json"
OUT="dist/web-skills"

while getopts "c:o:" opt; do
  case $opt in
    c) CONFIG=$OPTARG ;;
    o) OUT=$OPTARG ;;
    *) exit 2 ;;
  esac
done

command -v jq >/dev/null || { echo "error: jq is required"; exit 1; }
[ -f "$CONFIG" ] || { echo "error: config $CONFIG not found (see templates/skills-web.config.example.json)"; exit 1; }

STAGE=$(mktemp -d)
trap 'rm -rf "$STAGE"' EXIT
rm -rf "$OUT"
mkdir -p "$OUT"
OUT_ABS="$(cd "$OUT" && pwd)"

# Substitution program built once from the config.
SED_SCRIPT=$(jq -r 'to_entries[] | "s|{{\(.key)}}|\(.value)|g"' "$CONFIG")

fail=0
built=0

for dir in "$SRC"/*/; do
  name=$(basename "$dir")
  skill_ok=1
  mkdir -p "$STAGE/$name"
  sed "$SED_SCRIPT" "$dir/SKILL.md" > "$STAGE/$name/SKILL.md"
  out="$STAGE/$name/SKILL.md"

  if grep -qE '\{\{[A-Z_]+\}\}' "$out"; then
    echo "FAIL $name: unresolved placeholders: $(grep -oE '\{\{[A-Z_]+\}\}' "$out" | sort -u | tr '\n' ' ')"
    skill_ok=0
  fi

  fm_name=$(awk -F': ' '/^name:/ { print $2; exit }' "$out" | tr -d '\r')
  if [ "$fm_name" != "$name" ]; then
    echo "FAIL $name: frontmatter name \"$fm_name\" != directory name \"$name\""
    skill_ok=0
  fi

  desc=$(awk '/^description:/ { sub(/^description: /, ""); print; exit }' "$out" | tr -d '\r')
  if [ -z "$desc" ]; then
    echo "FAIL $name: missing description"
    skill_ok=0
  elif [ "${#desc}" -gt 200 ]; then
    echo "FAIL $name: description is ${#desc} chars after substitution (claude.ai limit: 200)"
    skill_ok=0
  fi

  if grep -qE '(^|[^a-zA-Z])gh (issue|pr|api|repo)' "$out"; then
    echo "FAIL $name: references the gh CLI — web skills must use the GitHub connector"
    skill_ok=0
  fi

  if [ "$skill_ok" -eq 1 ]; then
    (cd "$STAGE" && zip -qr "$OUT_ABS/$name.zip" "$name")
    echo "OK   $name -> $OUT/$name.zip (description: ${#desc} chars)"
    built=$((built + 1))
  else
    fail=1
  fi
done

[ "$fail" -eq 0 ] || { echo; echo "validation failed — nothing you should upload"; exit 1; }
echo
echo "built $built skill zip(s) in $OUT/"
