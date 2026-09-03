---
name: connect-analytics
description: One-time Google Analytics + Search Console connection - sets up the official GA4 MCP server and a GSC MCP server against the user's Google account (OAuth, read-only), verifies access, and hands the marketing-analytics skill a working data source.
disable-model-invocation: true
---

Connect the user's Google Analytics and Search Console data to the agent —
**the user's account via OAuth, not a service account**, so the agent sees
exactly the properties the human can see. One-time setup; afterwards the
`marketing-analytics` skill works with the data directly.

## What gets installed, and why

| Server | Provides | Status |
| --- | --- | --- |
| Official `analytics-mcp` (googleanalytics/google-analytics-mcp) | GA4 Data + Admin APIs: `run_report`, `run_funnel_report`, `run_realtime_report`, `get_custom_dimensions_and_metrics`, property/account admin reads | **Official, read-only** — GA4 has no keyword-level data |
| A GSC MCP server (community; e.g. Suganthans-GSC-MCP) | Search Console: queries, clicks, impressions, CTR, position — **the keyword analysis tool** | No official GSC server exists (verified 2026-09); community servers are OAuth-based, MIT-licensed |

**Do not skip the GSC server.** "Keyword analysis" on GA4 alone is a dead
end — GA4 shows landing pages and channels, but which *search terms*
brought people there lives only in Search Console.

## Prerequisites (human decisions, agent walks them through)

1. A Google Cloud project with **Analytics Admin API**, **Analytics Data
   API**, and **Search Console API** enabled
2. An **OAuth client of type "Desktop app"** in that project (consent
   screen: the user's own account as test user is enough)
3. The Google account used in the flow must have access to the target GA4
   property and the GSC property

## Setup: official GA4 MCP

```bash
# 1. Auth as the user, read-only analytics scope (opens browser):
gcloud auth application-default login \
  --scopes=https://www.googleapis.com/auth/analytics.readonly,https://www.googleapis.com/auth/cloud-platform

# 2. Register the local MCP server:
claude mcp add analytics-mcp \
  --scope user \
  -e GOOGLE_PROJECT_ID=<project-id> \
  -- pipx run analytics-mcp
```

(Application Default Credentials carry the user identity — no service
account JSON, so no identity mismatch debugging later. If the user
insists on a service account for automation later, that is a deliberate
switch with Viewer-role grants on the property — not the default here.)

Cursor/other clients: register the same command
(`pipx run analytics-mcp` with `GOOGLE_PROJECT_ID`) in the MCP config.

## Setup: GSC MCP

Follow the chosen server's README (they differ in tool set but share the
shape): enable the Search Console API, reuse the Desktop OAuth client,
then either `npx`/`uvx` the server via MCP config or install it
locally. The OAuth browser flow runs once on first use; the token is
stored locally (typically `~/.config/gsc-mcp/`). Do not commit tokens or
client secrets anywhere — the repo's `.gitignore` already excludes them.

## Verify (both servers, before declaring success)

1. GA4: list accounts/properties, then `run_report` for sessions over the
   last 7 days on one property
2. GSC: `list_properties`, then a top-queries query for one property
3. Empty arrays usually mean the **wrong Google account** completed the
   OAuth flow, or the account lacks property access — redo the flow with
   the right account rather than switching to a service account

Completion: both servers respond, the working property (GA4) and site
(GSC) are named, and the user knows data arrives read-only.
