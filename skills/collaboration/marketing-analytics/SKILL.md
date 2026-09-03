---
name: marketing-analytics
description: Read GA4 and Search Console through the connected MCP servers to learn what content performs - traffic, keyword opportunities, past-post performance, tracking setup guidance. The evidence base for picking topics, hooks, and ad investment.
---

Turn the connected Google Analytics (GA4) and Search Console data into
marketing decisions: which topics earn traffic, which keywords are within
reach, which past posts performed, and how new content gets measured. Read
and analyze — every publication action stays with `publish` and the human.

Requires the MCP servers from `connect-analytics`. If they are missing or
erroring, run that skill's setup first — never guess numbers.

## The two data sources, and what each is for

- **GA4** (official `analytics-mcp`): behavior on the site — sessions,
  engaged sessions, engagement rate, conversions, landing pages, traffic
  sources, realtime spikes. Use `run_report` with explicit dimensions and
  metrics; `run_funnel_report` for journey questions; `run_realtime_report`
  only for launch-day monitoring.
- **Search Console** (GSC MCP): search terms — queries, clicks,
  impressions, CTR, average position, and the analytical tools the chosen
  server ships (quick wins, content decay, cannibalization, content gaps).

Keyword **demand** is GSC. On-site **behavior** is GA4. Topics are picked
where the two overlap.

## Standing analyses

**Topic opportunities** — run the GSC server's opportunity tooling
(`quick_wins`: positions 4–15 with impressions; `content_gaps`: demand
without content) plus GA4 landing-page engagement. Output: a ranked list
of candidate topics with the evidence attached, ready to seed `brainstorm`
or a triage issue.

**Past-post performance** — for any published piece (the issue or its URL
from `publish`'s records): GSC queries and CTR trend for the page, GA4
sessions/engagement/conversions on the landing page, week-over-week since
publication. Output: a performance note on the issue — what brought
traffic, what engaged, what it converted, and whether it is climbing,
flat, or decaying (`content_decay`).

**Channel reality check** — before proposing ad spend: GA4 traffic by
source shows what organic/social/paid already deliver, and engagement by
source shows which traffic is worth paying for. Be explicit when data is
too young to decide (new property, low volume).

## Tracking new content

The GA4 MCP is read-only — it **reports**, it cannot instrument. For each
new piece, check the measurement loop exists:

1. The landing page fires the GA4 property's page_view (compare GA4
   realtime/landing-page reports after publication)
2. Events that matter are events, not just pageviews — outbound clicks,
   sign-up starts, video plays; propose the event design and let the user
   (or the site repo) implement it, e.g. via Google Tag Manager
3. UTM conventions on every link the piece carries — propose tags in the
   repo's scheme (e.g. `utm_source=<channel>&utm_campaign=<issue-number>`),
   so `past-post performance` can attribute spikes to this campaign later

## Honest numbers

- GSC data lags ~2 days; never present it as real-time
- State the date range of every analysis in the output
- Small samples get labeled small — "42 sessions" is a hint, not a verdict
- Distinguish **correlation from attribution** in plain words: a spike
  after a post is evidence, not proof; say what else changed
- Conversions need GA4 conversion events configured — if none exist, say
  so and propose them instead of reporting traffic as success

Output discipline: every claim carries its source (GA4 report or GSC
query), its date range, and its property/site. Numbers without provenance
do not leave this skill.
