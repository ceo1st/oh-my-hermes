---
name: health-check
description: Call the /api/health endpoint of a deployed app, validate the response, and report pass or fail
version: 1.0.0
tags: [health, monitoring, ops]
---

## When to Use

After every deployment. Also use on demand to check if a running app is healthy. Called automatically by `post-deploy-followup`.

## Prerequisites

- A deployed app URL (from Hermes memory key `last-deployment`, or provided directly)

## Procedure

1. Get the app URL — from Hermes memory key `last-deployment` or from the user
2. Call `GET [url]/api/health`
3. Measure response time
4. Evaluate:
   - HTTP status must be 200
   - Response body must parse as JSON
   - `status` field must equal `"ok"`
   - Response time must be under 3000ms

5. Report clearly:
   ```
   Health check: [url]/api/health
   Status:        [PASS / FAIL]
   HTTP:          [200 / other]
   Response time: [ms]ms
   Body:          { "status": "ok", "version": "...", "timestamp": "..." }
   ```

6. If FAIL:
   - Check Vercel dashboard for deployment errors or function logs
   - Check if the deployment URL is correct (sometimes a new URL is generated)
   - If status is 404 on /api/health: health endpoint is missing — run bootstrap.sh to add it
   - Offer to run `send-notification` with failure alert
   - Save failure to Hermes memory: key `health-failure-log`

## Pitfalls

- HTTP 404 on `/api/health` means the endpoint is missing, not that the app is down. The app may be running fine but the health route was never added.
- A response time over 3000ms is a warning, not an automatic failure — but log it.
- Cold starts on Vercel serverless functions can cause the first request to be slow. If the first check times out, retry once before reporting failure.

## Verification

Clear PASS or FAIL report with HTTP status, response time, and body content.
