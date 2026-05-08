# Design Handoff Protocol

## What this is

Claude Design is a human-in-the-loop tool. There is no Claude Design API. You do the design work, then hand off results to Hermes using a structured protocol so Claude Code or Codex can implement from a clear spec.

---

## When to do a design step

Do a design step when:
- Starting a new app with no UI/UX decisions made
- Adding a major new surface (new page, new dashboard, new user flow)
- Visual direction is unclear and you want to explore before committing

Skip it when:
- The change is purely backend (API, database, auth)
- The task is a bug fix or small targeted change
- You already have a clear visual spec or mockup

---

## Step 1 — Work in Claude Design

Open [claude.ai/design](https://claude.ai/design). Describe:
- The user (who is using this?)
- The goal (what are they trying to do?)
- The context (what screen comes before? what after?)
- Constraints (mobile-first, existing design system, etc.)

Iterate until you have a direction you want to implement.

---

## Step 2 — Export the design output

There is no automated export. Copy the relevant output as text.

Copy:
- Component descriptions (what exists on screen, what it does)
- Layout notes (arrangement, responsive behavior)
- Interaction patterns (click, hover, form submit)
- Data requirements (what data does each component need?)
- Edge cases

Skip:
- Aesthetic rationale
- Alternative directions you are not pursuing

Paste into: `design-output.md` in your project root.

---

## Step 3 — Run the design-handoff skill

```
tell hermes: I have a design output. Run design-handoff.
```

Hermes reads `design-output.md`, generates an implementation spec, saves it to memory as `implementation-spec-[feature-name]`, and routes to Claude Code or Codex.

The spec format:

```markdown
# Implementation Spec: [Feature Name]

## Components to build
- ComponentName: description, props

## Data requirements
- What data each component needs, where it comes from

## Routes / Pages
- /path: what renders here

## API endpoints needed
- POST /api/path: request/response shape

## Database changes needed
- New tables, columns, indexes

## Interactions to implement
- Specific click handlers, form submissions

## Edge cases to handle
- Specific edge cases from the design

## Implementation order
1. Data layer
2. API
3. Components
4. Integration
```

---

## Tips for better handoffs

**Be specific.** "A card with user info" is vague. "A card showing username, avatar, and join date with a settings button linking to /settings" is implementable.

**Add data sources.** Designers describe what is visible, not where data comes from. Add notes about data sources when copying design output.

**Flag unknowns.** If a UI feature is unclear to implement, mark it `[UNKNOWN - research needed]`. Hermes will flag it in the spec.

**One handoff per feature.** Do not combine unrelated features in one session.

---

## Recalling the spec

```
tell hermes: show me the implementation spec for the dashboard feature
```

Hermes retrieves it from persistent memory.
