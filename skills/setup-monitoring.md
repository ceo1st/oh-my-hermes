---
name: setup-monitoring
description: Configure Sentry error tracking and document Uptime Kuma setup for a deployed app
version: 1.0.0
tags: [monitoring, sentry, uptime, ops]
---

## When to Use

After deploying to Vercel for the first time. Run once per project.

## Prerequisites

- App deployed to Vercel with working `/api/health` endpoint
- Sentry account at sentry.io
- SLACK_WEBHOOK_URL available for notifications

## Procedure

**Sentry (error tracking):**
```bash
npm install @sentry/nextjs
npx @sentry/wizard@latest -i nextjs
```

The wizard creates `sentry.client.config.ts`, `sentry.server.config.ts`, `sentry.edge.config.ts`, and updates `next.config.js`. Review changes before committing.

Add to `.env.local`:
```
SENTRY_DSN=your-dsn-from-sentry-dashboard
SENTRY_AUTH_TOKEN=your-auth-token
```

Add to Vercel:
```bash
vercel env add SENTRY_DSN production
vercel env add SENTRY_AUTH_TOKEN production
```

**Uptime Kuma (uptime monitoring):**

Uptime Kuma is a self-hosted uptime monitor. If you have a VPS ($5/month):
```bash
docker run -d --restart=always -p 3001:3001 -v uptime-kuma:/app/data --name uptime-kuma louislam/uptime-kuma:1
```

Then in the Uptime Kuma UI:
1. Add new monitor → HTTP(s)
2. URL: `https://[your-app].vercel.app/api/health`
3. Heartbeat interval: 60 seconds
4. Set up Slack notification integration with your SLACK_WEBHOOK_URL

Alternative (no self-hosting): Better Uptime (betteruptime.com) offers a free tier with similar functionality.

**Save config to Hermes memory:**
- key: `monitoring-config`, value: `{ sentry: true, uptimeKuma: [url-or-null], slackAlert: true }`

## Pitfalls

- The Sentry wizard modifies `next.config.js`. Review the diff before committing — it adds `withSentryConfig` wrapper.
- Test Sentry is working: trigger a deliberate error in dev, confirm it appears in Sentry dashboard before deploying.
- Uptime Kuma polls every 60 seconds — first alert fires after the first failed check, not immediately.

## Verification

- Sentry DSN is in Vercel env
- Trigger test error in dev → confirm it appears in Sentry
- Uptime Kuma shows monitor as "Up" for your health endpoint
- Monitoring config saved to Hermes memory
