# Engine Routing

## The question

When you are about to do work, which engine should do it?

This is not a preference question. There are concrete criteria.

---

## Decision framework

```
Is this UI/UX work before any code exists?
  → Claude Design (human-in-the-loop)
  → Then run design-handoff skill to produce an implementation spec

Is this an operational task?
  (deploy, monitor, notify, schedule, remember, check health)
  → Hermes directly

Is the task complex, multi-file, or requires architectural judgment?
  → Claude Code

Is the task targeted, well-defined, and involves 1-2 files?
  → Codex

Are you unsure?
  → Run the choose-engine skill in Hermes
```

---

## Claude Code

**Use when:**
- Building a new feature from scratch
- Refactoring across multiple files
- Writing a test suite
- The implementation requires making many unknown decisions
- The task involves understanding a complex codebase and changing multiple parts

**Avoid when:**
- The change is one file and the fix is already decided
- You need a fast prototype to test an idea

**Strengths:**
- Full file system access and git integration
- Can run commands and observe output
- Handles complex multi-step reasoning across many files
- AGENTS.md aware (reads your project conventions)
- Strong at test-writing and maintaining type safety

**Context handoff from Hermes:**
Before launching Claude Code, Hermes should pass: the task description, relevant memory entries (architecture decisions, prior implementations), and the implementation spec from design-handoff if a design step happened.

The `implement-with-claude-code` skill handles this handoff.

---

## Codex

**Use when:**
- Fixing a specific bug in a known file
- Making a targeted change with a clear outcome
- Exploring how something works before committing to full implementation
- Fast iteration on a prototype

**Avoid when:**
- The task requires understanding 10+ files simultaneously
- There are many unknown decisions to make during implementation

**Strengths:**
- Fast
- Good at targeted, self-contained changes
- Useful for quick exploration and experimentation

The `implement-with-codex` skill handles context handoff.

---

## Hermes

**Use when:**
- Deploying to Vercel
- Running database migrations
- Sending notifications
- Setting up or checking monitoring
- Scheduling recurring tasks
- Remembering context across sessions
- Orchestrating a sequence of engine calls

Hermes does not write application code directly. It delegates coding to Claude Code or Codex. Hermes coordinates: loads skills, passes context, calls tools, records results in memory, routes to the next step.

---

## Claude Design

**Use when:**
- Starting a new app and UI/UX decisions have not been made
- Exploring visual directions before committing to code
- Generating wireframes or component specs

There is no Claude Design API. This step always requires a human.

Protocol:
1. Open Claude Design at claude.ai/design
2. Describe what you are building
3. Export design decisions as text
4. Give text to Hermes, run `design-handoff` skill
5. Hermes converts to implementation spec and saves to memory
6. Hermes routes spec to Claude Code or Codex

See `docs/design-handoff.md` for the full protocol.

---

## Engine comparison

| Dimension | Hermes | Claude Code | Codex | Claude Design |
|---|---|---|---|---|
| Writes app code | No (delegates) | Yes | Yes | No |
| Runs shell commands | Yes | Yes | Limited | No |
| Long-lived across sessions | Yes | No | No | No |
| Memory/context | Persistent | Per-session | Per-session | Per-session |
| Best for | Orchestration, ops | Complex multi-file coding | Quick targeted coding | UI/UX exploration |
| Human required | No | No | No | Yes |

---

## The choose-engine skill

Run this when unsure:

```
tell hermes: I need to [describe task]. Which engine should I use?
→ Hermes loads choose-engine skill
→ Hermes asks 2-3 clarifying questions
→ Hermes recommends an engine and explains why
→ Hermes offers to launch the implement skill for that engine
```

Skill documented in `skills/choose-engine.md`.
