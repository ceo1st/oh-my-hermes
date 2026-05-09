---
name: kanban-task
description: Use when any agent starts, updates, or completes a unit of work that should be visible on the Hermes kanban board
version: 1.0.0
tags: [kanban, task, tracking, ops, autonomous]
---

## Overview

Creates and updates kanban cards in Hermes's built-in task manager. Every agent action that moves work forward must call this skill — the kanban is the source of truth the CTO reads.

## Kanban columns

| Status | Meaning |
|---|---|
| `backlog` | Triaged, not started |
| `in-progress` | Dev Agent working on it |
| `review` | PR created, QA reviewing |
| `awaiting-approval` | QA approved, waiting for founder YES/NO |
| `done` | Merged and deployed |
| `blocked` | Stalled — needs human decision |

## Procedure

**Create a new task (PM Agent, after triaging an issue):**
```bash
hermes task create \
  --title "[verb + what]" \
  --status backlog \
  --note "Issue #[n] | Priority: [score] | Why: [one sentence]"
```

Save the returned task ID to Hermes memory: key `task-id-issue-[n]`.

**Move to in-progress (Dev Agent, when starting implementation):**
```bash
hermes task update [task-id] --status in-progress --note "Dev Agent picked up at [time]"
```

**Move to review (Dev Agent, after PR created):**
```bash
hermes task update [task-id] \
  --status review \
  --note "PR #[pr-number] created: [pr-url]"
```

**Move to awaiting-approval (QA Agent, after review passes):**
```bash
hermes task update [task-id] \
  --status awaiting-approval \
  --note "QA passed. Preview: [url]. Approval sent to founder at [time]."
```

**Move to done (Ops Agent, after merge and healthy deploy):**
```bash
hermes task update [task-id] \
  --status done \
  --note "Merged PR #[n]. Production healthy. Deployed at [time]."
```

**Mark blocked (any agent, when stalled):**
```bash
hermes task update [task-id] \
  --status blocked \
  --note "[what is blocking it and since when]"
```
Then load `send-notification` — CTO Agent is notified immediately.

## Quick reference

| Agent | When to call | Status set to |
|---|---|---|
| PM Agent | Issue triaged and ticketed | `backlog` |
| Dev Agent | Starting implementation | `in-progress` |
| Dev Agent | PR created | `review` |
| QA Agent | Review passed, summary sent | `awaiting-approval` |
| Ops Agent | Merged and deployed healthy | `done` |
| Any | Cannot proceed without input | `blocked` |

## Pitfalls

- Every task must have a task ID saved to memory. Without the ID, you cannot update it later.
- Do not skip this skill to save time. The kanban is how the CTO monitors the loop — gaps break visibility.
- The `--note` field is the audit trail. Include enough detail that a future agent (or the founder) can understand what happened and when.

## Verification

`hermes task list` shows the card in the correct column with an accurate note.
