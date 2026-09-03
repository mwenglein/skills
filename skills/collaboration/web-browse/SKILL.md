---
name: web-browse
description: Browse the live web with Tavily - search beyond Google listings, extract full page content, crawl competitor sites, map site structure. Manages the Tavily MCP OAuth setup so the agent uses the user's account. The engine behind scout and any skill that needs real pages.
---

Read the live web — not search-result snippets — using the user's Tavily
account. Four capabilities: **search** (fresh web results ranked for LLMs),
**extract** (full page content, cleaned), **crawl** (walk a site's pages),
**map** (a site's URL structure). `scout` uses these as its research
engine; other skills call them directly when they need real pages.

## One-time setup: connect the account

The user's account, not a shared key — check first, set up only if missing:

1. **Check**: are Tavily tools (`tavily_search`, `tavily_extract`,
   `tavily_crawl`, `tavily_map`) already available in this session, or a
   `tavily` namespace present? If yes — done, skip to usage.
2. **Key naming**: ask the user to create (or confirm) an API key named
   **`mcp_auth_default`** at app.tavily.com — the OAuth flow hands the
   agent exactly this key from their account (personal wins over team).
   There is no scoped minting: whoever completes OAuth gets full API
   privileges, so it should be the user's own account.
3. **Connect the hosted MCP server** (Streamable HTTP, OAuth round trip —
   no key in URLs or configs):

   ```
   claude mcp add --transport http tavily https://mcp.tavily.com/mcp/ --scope user
   ```

   Cursor and other clients: point the MCP config at
   `https://mcp.tavily.com/mcp/`; the client opens the browser consent
   flow on first use.
4. **Verify**: call `tavily_search` with a trivial query. Then check
   credit health via the usage endpoint
   (`GET https://api.tavily.com/usage`, bearer key) if a raw key is
   available, or note that credits burn at 1 per basic search, 2 per
   advanced.

If MCP is unavailable in the environment, fall back to the REST API
(`https://api.tavily.com/{search,extract,crawl,map}`, header
`Authorization: Bearer tvly-…`) — the tool semantics below are identical.

## Choose the right tool

| Need | Tool | Notes |
| --- | --- | --- |
| Fresh answers, "what's out there" | `tavily_search` | `search_depth: "advanced"` for thorough missions (2 credits, cleaner chunks); `max_results` 5–10; `chunks_per_source` 3 |
| Read ONE known page properly | `tavily_extract` | Full cleaned content — competitor pricing pages, changelogs, docs. Prefer over crawling single URLs |
| Everything on a competitor's site | `tavily_crawl` | Set `max_depth` ≤ 2 and a `max_pages` budget first — crawling is expensive; extract key pages by hand instead when possible |
| Understand a site's structure | `tavily_map` | Cheap reconnaissance before a crawl: blog sections, pricing paths, doc trees |

## Discipline

- Cite every extracted page by URL — same rule as `scout`'s research notes
- State the credit cost of a planned crawl before running it; get consent
  for anything beyond ~20 pages
- Extracted content is a **snapshot** — record the access date; marketing
  claims about competitors go stale fast
- Respect robots and paywalls: extract what is publicly served, never
  coach the user on circumventing access controls
- Batch extract calls for multiple known URLs in one step rather than
  search-then-extract one at a time
