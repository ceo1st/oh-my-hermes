---
name: choose-engine
description: Route a task to the right engine — Claude Code, Codex, or Hermes — based on task type and complexity
version: 1.0.0
tags: [routing, orchestration, engine]
---

## When to Use

When starting a new task and unsure which coding engine to use. Also use automatically at the end of `design-handoff` and `product-brief` to route the next step.

## Prerequisites

- A task description (from user, from memory, or from an implementation spec)

## Procedure

Apply this decision tree:

1. **Is this UI/UX exploration before any code exists?**
   → Claude Design (human-in-the-loop). Remind user to open claude.ai/design, then run `design-handoff` with the output.

2. **Is this an operational task?** (deploy, monitor, notify, schedule, check health, remember context)
   → Hermes handles it directly. Load the appropriate skill.

3. **Is this a complex multi-file change?** Any of: new feature spanning multiple files, architectural refactor, new subsystem, writing a test suite, building from scratch with many unknown decisions
   → Claude Code. Load `implement-with-claude-code`.

4. **Is this a targeted single-file change?** Any of: known bug in a specific file, adding a field to an existing component, quick prototype to test an idea
   → Codex. Load `implement-with-codex`.

5. **Still unsure?** Ask one clarifying question: "How many files will this change?" 1-2 files → Codex. 3+ files → Claude Code.

Announce the recommendation with a one-sentence rationale. Offer to immediately load the implement skill.

## Pitfalls

- Do not overthink. The choice between Claude Code and Codex is recoverable — you can always switch mid-task. Speed of decision matters more than perfection.
- Do not route operational tasks (deploy, notify) to coding engines. Hermes handles those directly.

## Verification

Recommendation stated clearly with rationale. User or Hermes confirms and proceeds to implement skill.
