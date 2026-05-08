---
name: implement-with-claude-code
description: Scaffold a Claude Code session with full project context from Hermes memory for complex multi-file implementation tasks
version: 1.0.0
tags: [implementation, claude-code, coding]
---

## When to Use

When `choose-engine` has routed a task to Claude Code. Use for complex multi-file changes, new features from scratch, architectural refactors, and test suites.

## Prerequisites

- Claude Code installed (`npm install -g @anthropic-ai/claude-code` or via Homebrew)
- Task description available (from user, from `implementation-spec-[name]` in memory, or from `product-brief-[name]`)
- Project has an `AGENTS.md` file (run `bootstrap.sh` if missing)

## Procedure

1. Retrieve relevant context from Hermes memory:
   - `product-brief-[project-name]` (if exists)
   - `implementation-spec-[feature-name]` (if design handoff was done)
   - `requirements-[project-name]` (if exists)
   - Any architecture decisions or "avoid" notes

2. Compose the handoff prompt in this format:
   ```
   Context from project memory:
   [paste relevant memory entries]

   Task:
   [clear description of what to implement]

   Constraints:
   - Read AGENTS.md for project conventions before starting
   - [any specific constraints from requirements or product brief]
   - [tech stack requirements]

   Expected output:
   [what should exist when this is done]
   ```

3. Instruct the user: "Open Claude Code in the project directory with: `claude`"
4. Provide the exact prompt to paste into Claude Code (from step 2)
5. Remind the user: after Claude Code completes, tell Hermes the outcome so it can be saved to memory

## Pitfalls

- Always include "Read AGENTS.md before starting" in the prompt — Claude Code follows this instruction and it ensures conventions are respected.
- Include relevant memory context in the handoff prompt. Claude Code has no access to Hermes memory — context must be explicitly passed.
- Do not give Claude Code a vague task. "Add billing" is bad. "Add Stripe subscription billing — monthly and annual plans, store subscription status in Supabase users table, add /api/billing/subscribe and /api/billing/cancel endpoints" is good.

## Verification

After Claude Code session completes:
- Ask user to confirm the expected output exists
- Save outcome to Hermes memory: key `implementation-[feature-name]`, value `completed by Claude Code on [date]`
