---
name: post-deploy-followup
description: After every deployment — run health check, log deployment to memory, send Slack notification, check monitoring status
version: 1.0.0
tags: [deployment, ops, health, notification]
---

## When to Use

Run this after every deployment. It is the final step in the deploy workflow. Also triggered automatically by `deploy-to-vercel`.

## Prerequisites

- Deployment URL in Hermes memory (key: `last-deployment`) or provided directly
- `send-notification` skill available
- `health-check` skill available

## Procedure

1. **Get deployment URL** from Hermes memory key `last-deployment` or from the user

2. **Run health-check** on the deployment URL
   - If health check passes: continue
   - If health check fails: run `send-notification` with failure message, log failure to memory, and stop here — do not report success

3. **Log deployment to Hermes memory:**
   - key: `deployment-log`
   - Append: `{ url, timestamp, healthStatus: "healthy" | "unhealthy", engine: "claude-code" | "codex" | "manual" }`

4. **Send success notification** via `send-notification`:
   - Event: "Deploy"
   - Status: healthy
   - Include the URL

5. **Check monitoring status:**
   - Retrieve `monitoring-config` from Hermes memory
   - If monitoring is not yet configured: print reminder "Monitoring not configured. Run `setup-monitoring` to set up Sentry and Uptime Kuma."

6. **Print deployment summary:**
   ```
   Deployment summary
   ──────────────────
   URL:         [url]
   Health:      [PASS / FAIL]
   Notification: [sent to Slack / not sent]
   Monitoring:  [configured / not configured]
   Logged:      [yes]
   ```

## Pitfalls

- A passing health check is a necessary condition for reporting success, not a sufficient one. The app could still have bugs not covered by the /api/health endpoint. Always note this when reporting.
- Do not skip this skill after deployments. It is the only thing that logs deployment history to memory — without it, Hermes loses context about when and what was deployed.

## Verification

- Deployment logged in Hermes memory under `deployment-log`
- Slack notification delivered (or failure explained)
- Health status confirmed
- Monitoring status noted
