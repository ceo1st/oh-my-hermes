---
name: send-notification
description: Send a deployment, health, or status notification via Slack webhook with email fallback
version: 1.0.0
tags: [notification, slack, ops]
---

## When to Use

After deployments, after health check results, after incidents. Called automatically by `post-deploy-followup`.

## Prerequisites

- `SLACK_WEBHOOK_URL` in environment (check with: `echo $SLACK_WEBHOOK_URL`)

## Procedure

**Compose the message.** Include:
- Event type: Deploy / Health Fail / Health Pass / Update
- Project name
- Environment: production or preview
- URL (if deployment)
- Timestamp
- Brief status note

**Send to Slack:**
```bash
curl -s -o /dev/null -w "%{http_code}" -X POST "$SLACK_WEBHOOK_URL" \
  -H 'Content-Type: application/json' \
  -d "{\"text\": \"[event] [project] → [environment]\n[url]\n[status]\n[timestamp]\"}"
```

**Check the response.** HTTP 200 = delivered. Anything else = failed.

**If SLACK_WEBHOOK_URL is not set:**
- Print the notification to console
- Print instructions: "Set SLACK_WEBHOOK_URL in your environment to enable Slack notifications. Get a webhook URL at api.slack.com/apps → Incoming Webhooks."
- Do not fail silently — always print the notification content even if it cannot be delivered.

**Save to Hermes memory:**
- key: `notification-log`, append entry: `{ event, timestamp, delivered: true/false }`

## Pitfalls

- Slack webhook URLs can expire or be revoked. If you get a non-200 response, check the webhook URL is still valid in the Slack app settings.
- Keep messages short. Slack truncates messages over 4000 characters.
- Do not include raw env var values or credentials in notification messages.

## Verification

- HTTP 200 response from Slack
- Message appears in the target Slack channel
- Notification logged in Hermes memory
