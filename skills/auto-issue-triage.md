---
name: auto-issue-triage
description: Use when running on a cron schedule to automatically find, score, and pick the highest-priority GitHub issue to work on next
version: 1.0.0
tags: [github, issues, triage, cron, autonomous]
metadata:
  hermes:
    tags: [github, triage, autonomous, kanban]
    requires_toolsets: [terminal, web]
---

## Overview

Automated triage pass. Scores every open issue, picks the top priority, creates a kanban card, and routes to the dev loop. Runs unattended on an hourly cron schedule.

## When to Use

- Triggered by Hermes cron (hourly)
- No human present — fully autonomous
- Part of the `cto-loop` workflow

## Prerequisites

- GitHub CLI authenticated: `gh auth login`
- Hermes memory has `github-repo` key set (owner/repo format)
- Cron configured (see Setup below)

## Setup (one-time)

```bash
hermes cron add "0 * * * *" "Run auto-issue-triage for [owner/repo]"
```

Or natural language:
```bash
hermes cron add "every 1h" "Run auto-issue-triage for [owner/repo]"
```

Verify:
```bash
hermes cron list
```

## Procedure

1. **Fetch open issues:**
   ```bash
   gh issue list --repo [owner/repo] --state open \
     --json number,title,labels,createdAt,comments --limit 50
   ```

2. **Score each issue** (0–10, higher = do first):
   - `bug` label: +4
   - `priority:high` label: +3
   - `priority:low` label: −2
   - No labels: +1 (needs triage, flag it)
   - Older than 7 days: +1
   - Has comments: +1 per comment, max +2
   - Already assigned or labeled `in-progress`: skip
   - Labeled `wontfix`, `blocked`, `needs-design`: skip

3. **Pick top-scoring issue.** Tie → pick older one.

4. **Check if a task is already in progress:**
   - Retrieve `current-task` from Hermes memory
   - Already in progress and not blocked → skip, send quick status update
   - Blocked or stalled > 4 hours → escalate via `send-notification`

5. **Create kanban card** via `kanban-task`:
   ```
   kanban_create title="[issue title]" description="Issue #[n] | Score: [n] | [why in one line]"
   ```
   Save task ID to memory: `task-id-issue-[n]`.

6. **Assign and label on GitHub:**
   ```bash
   gh issue edit [number] --add-label "in-progress"
   ```

7. **Save to memory:** key `current-task` → `{ issueNumber, taskId, title, assignedAt }`

8. **Spawn Dev Agent** (or load `choose-engine` directly) with the issue title and body.

9. **If no actionable issues:**
   - `send-notification`: "No open issues. All caught up."
   - Log to memory: `{ checkedAt, status: "idle" }`

## Pitfalls

- Never start two tasks in parallel. Always check `current-task` memory first.
- Vague issue body → do not guess. Ask founder via `send-notification` before starting.
- Cron sessions cannot create more cron jobs — do not try to schedule inside this skill.

## Verification

- Kanban card created and visible in `hermes kanban list`
- `current-task` in Hermes memory
- Issue labeled `in-progress` on GitHub
