---
name: kanban-task
description: Use when any agent starts, updates, or completes a unit of work that should be visible on the Hermes kanban board
version: 1.0.0
tags: [kanban, task, tracking, ops, autonomous]
metadata:
  hermes:
    tags: [kanban, tracking, agents]
    requires_toolsets: [terminal]
---

## Overview

Creates and updates cards in the Hermes kanban board (`hermes kanban`). Every agent action that moves work forward must call this skill — the kanban is the source of truth the CTO reads via `hermes kanban watch`.

## Kanban columns

| Status | Meaning |
|---|---|
| Backlog | Triaged, not started |
| In Progress | Dev Agent working on it |
| Review | PR created, QA reviewing |
| Awaiting Approval | QA passed, waiting for founder YES/NO |
| Done | Merged and deployed |
| Blocked | Stalled — needs human decision |

## Procedure

**Create a new task (PM Agent, after triaging an issue):**
```bash
hermes kanban create "Fix: [what] — Issue #[n] | Priority: [score]"
```
Or via agent toolset (preferred inside a skill):
```
kanban_create title="Fix: [what]" description="Issue #[n] | Why: [one sentence] | Acceptance: [criteria]"
```

Save returned task ID to Hermes memory: key `task-id-issue-[n]`.

**Claim and move to in-progress (Dev Agent):**
```bash
hermes kanban claim [task-id]
hermes kanban comment [task-id] "Dev Agent started at [time]. Engine: [hermes/claude-code/codex]"
```

**Move to review (Dev Agent, after PR created):**
```bash
hermes kanban comment [task-id] "PR #[number] created: [url]"
```
Then reassign to QA Agent.

**Move to awaiting-approval (QA Agent, after review passes):**
```bash
hermes kanban comment [task-id] "QA passed. Preview healthy. Approval sent to founder at [time]."
```

**Complete (Ops Agent, after merge + healthy deploy):**
```bash
hermes kanban complete [task-id]
hermes kanban comment [task-id] "Merged PR #[n]. Production healthy at [time]."
```

**Block (any agent, when stalled):**
```bash
hermes kanban block [task-id]
hermes kanban comment [task-id] "Blocked: [what is blocking and since when]"
```
Then load `send-notification` — CTO Agent is alerted immediately.

## Quick reference

| Agent | Action | Command |
|---|---|---|
| PM | Issue triaged | `kanban_create` |
| Dev | Starting work | `hermes kanban claim [id]` |
| Dev | PR created | `kanban_comment [id] "PR #n: url"` |
| QA | Review passed | `kanban_comment [id] "QA passed..."` |
| Ops | Deployed healthy | `hermes kanban complete [id]` |
| Any | Cannot proceed | `hermes kanban block [id]` |

## Live monitoring

To watch the board in real time:
```bash
hermes kanban watch    # live dashboard
hermes kanban list     # snapshot
hermes kanban stats    # summary counts
```

## Pitfalls

- Save the task ID to memory immediately after `kanban_create` — without it you cannot update the card later.
- Do not skip this skill. The kanban is how the CTO monitors the loop.
- `hermes kanban complete` is final. For partial progress, use `kanban_comment` to log state.
- Blocked cards are auto-surfaced in `hermes kanban watch`. Always add a comment explaining what is blocking before blocking the card.

## Verification

`hermes kanban list` shows the card in the correct state with an accurate comment thread.
