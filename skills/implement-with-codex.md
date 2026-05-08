---
name: implement-with-codex
description: Scaffold a Codex CLI invocation with full context for targeted single-file or quick-fix tasks
version: 1.0.0
tags: [implementation, codex, coding]
---

## When to Use

When `choose-engine` has routed a task to Codex. Use for quick targeted fixes, single-file changes, exploratory prototypes, and well-defined small tasks.

## Prerequisites

- Codex CLI installed (`npm install -g @openai/codex`)
- Task description is specific and well-scoped
- OPENAI_API_KEY set in environment

## Procedure

1. Retrieve any relevant context from Hermes memory (architecture decisions, the specific file and function in question)

2. Compose the Codex command. Codex context is per-invocation — ALL relevant context must be in the command string:
   ```bash
   codex "[full task description with all context]"
   ```

   Example of a good Codex prompt:
   ```bash
   codex "In src/middleware.ts, the auth redirect is sending users to /login even when they are authenticated. The auth check uses supabase.auth.getSession(). Fix the condition so authenticated users are redirected to /dashboard instead of /login. Do not change any other files."
   ```

3. Provide the exact `codex` command to the user or execute it directly if in an automated context

4. After completion, save outcome to Hermes memory

## Pitfalls

- Codex has no persistent context — every invocation starts fresh. Put ALL relevant context in the prompt string.
- Scope the task tightly. If it expands to 3+ files during implementation, stop and route to Claude Code instead.
- Codex works best when the file and function are named explicitly in the prompt.

## Verification

After Codex completes:
- Confirm the specific file was changed as expected
- Run the build or typecheck to confirm no regressions: `npm run typecheck`
- Save outcome to Hermes memory
