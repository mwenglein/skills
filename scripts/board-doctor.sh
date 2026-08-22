#!/usr/bin/env bash
# Read-only capability probe for board automation tokens.
#
# After ANY token change, this answers in one line what otherwise costs a
# debugging afternoon: can each token see the board, the repo, and — the
# silent killer — the ISSUE CONTENT of board items in private repos
# ("N items, M linked to issue numbers"). See TOKENS.md next to the
# configure skill for why M < N usually means a classic token without
# `repo` scope hitting the Projects v2 visibility trap.
#
#   PROJECT_OWNER=me PROJECT_NUMBER=1 REPO=me/product \
#     BOARD_TOKEN=... [ISSUES_TOKEN=...] scripts/board-doctor.sh
#
# Tokens: probes BOARD_TOKEN and ISSUES_TOKEN when set; with neither set it
# probes the single ambient token (GH_TOKEN, or `gh auth token`).
# Strictly read-only: no mutations, no writes probed (write capability is
# inferred from reported scopes/permissions only).
#
# Requires: curl, jq.
set -euo pipefail

: "${PROJECT_OWNER:?set PROJECT_OWNER (org or user login owning the board)}"
: "${PROJECT_NUMBER:?set PROJECT_NUMBER}"
: "${REPO:?set REPO (owner/name)}"

command -v jq >/dev/null || { echo "error: jq is required"; exit 1; }

API=https://api.github.com

probe_token() {
  local label=$1 token=$2

  echo "== $label =="

  # Identity + classic scopes (fine-grained tokens send no scopes header).
  local hdr login scopes
  hdr=$(curl -s -D - -o /dev/null -H "Authorization: Bearer $token" "$API/user")
  login=$(curl -s -H "Authorization: Bearer $token" "$API/user" | jq -r '.login // "?"')
  scopes=$(printf '%s' "$hdr" | tr -d '\r' | awk -F': ' 'tolower($1)=="x-oauth-scopes" { print $2 }')
  if [ -n "${scopes:-}" ]; then
    echo "   identity: $login (classic token; scopes: ${scopes:-none})"
  else
    echo "   identity: $login (fine-grained or app token; no scope header)"
  fi

  # Repo content visibility.
  local repo_code
  repo_code=$(curl -s -o /dev/null -w '%{http_code}' -H "Authorization: Bearer $token" "$API/repos/$REPO")
  if [ "$repo_code" = "200" ]; then
    local issues_code
    issues_code=$(curl -s -o /dev/null -w '%{http_code}' -H "Authorization: Bearer $token" "$API/repos/$REPO/issues?per_page=1&state=all")
    echo "   repo $REPO: visible (issues read: HTTP $issues_code)"
  else
    echo "   repo $REPO: NOT visible (HTTP $repo_code)"
  fi

  # Board: org first, then user fallback (keeps an org migration config-only).
  local q resp proj
  q='query($owner:String!,$number:Int!){
      organization(login:$owner){ projectV2(number:$number){ id title
        field(name:"Status"){ ... on ProjectV2SingleSelectField { options { name } } }
        items(first:100){ totalCount nodes { content { ... on Issue { number } ... on PullRequest { number } } } } } }
      user(login:$owner){ projectV2(number:$number){ id title
        field(name:"Status"){ ... on ProjectV2SingleSelectField { options { name } } }
        items(first:100){ totalCount nodes { content { ... on Issue { number } ... on PullRequest { number } } } } } } }'
  resp=$(jq -n --arg q "$q" --arg owner "$PROJECT_OWNER" --argjson number "$PROJECT_NUMBER" \
      '{query:$q, variables:{owner:$owner, number:$number}}' |
    curl -s -X POST -H "Authorization: Bearer $token" -H "Content-Type: application/json" \
      --data @- "$API/graphql")
  proj=$(printf '%s' "$resp" | jq '.data.organization.projectV2 // .data.user.projectV2 // empty')

  if [ -z "$proj" ]; then
    local err
    err=$(printf '%s' "$resp" | jq -r '[.errors[]?.message] | join("; ") | .[0:120]')
    echo "   board $PROJECT_OWNER/#$PROJECT_NUMBER: NOT readable (${err:-empty response})"
    echo
    return
  fi

  local title columns total linked
  title=$(printf '%s' "$proj" | jq -r .title)
  columns=$(printf '%s' "$proj" | jq '[.field.options[]?.name] | length')
  total=$(printf '%s' "$proj" | jq .items.totalCount)
  linked=$(printf '%s' "$proj" | jq '[.items.nodes[].content | select(. != null and .number != null)] | length')
  echo "   board \"$title\": readable ($columns Status columns)"
  echo "   items: $total total, $linked of first $(printf '%s' "$proj" | jq '.items.nodes | length') linked to issue numbers"
  if [ "$linked" -lt "$(printf '%s' "$proj" | jq '.items.nodes | length')" ]; then
    echo "   ⚠ unlinked items: this token sees the board but NOT the item content."
    echo "     Classic token without \`repo\` scope + private repo = the visibility"
    echo "     trap (TOKENS.md). Board↔issue joins WILL misbehave with this token."
  fi
  echo
}

probed=0
if [ -n "${BOARD_TOKEN:-}" ]; then probe_token "BOARD_TOKEN" "$BOARD_TOKEN"; probed=1; fi
if [ -n "${ISSUES_TOKEN:-}" ]; then probe_token "ISSUES_TOKEN" "$ISSUES_TOKEN"; probed=1; fi
if [ "$probed" -eq 0 ]; then
  TOKEN="${GH_TOKEN:-$(gh auth token 2>/dev/null || true)}"
  [ -n "$TOKEN" ] || { echo "error: no token (set BOARD_TOKEN/ISSUES_TOKEN/GH_TOKEN or gh auth login)"; exit 1; }
  probe_token "ambient token" "$TOKEN"
fi
