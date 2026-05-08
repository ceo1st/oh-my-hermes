---
name: design-handoff
description: Convert Claude Design session output into a structured implementation spec, save to memory and IMPLEMENTATION_SPEC.md
version: 1.0.0
tags: [design, handoff, implementation, memory]
---

## When to Use

After doing UI/UX work in Claude Design (claude.ai/design) and exporting design notes to `design-output.md` in the current directory. Use before routing to a coding engine.

## Prerequisites

- `design-output.md` exists in the current directory with exported design notes
- `product-brief-[project-name]` in Hermes memory (recommended)

## Procedure

1. Read `design-output.md` from the current directory
2. Generate an implementation spec with these sections:
   - **Components to build** — name, description, props/data each needs
   - **Data requirements** — what data each component needs and where it comes from
   - **Routes / Pages** — each route and what renders there
   - **API endpoints needed** — method, path, request shape, response shape
   - **Database changes needed** — new tables, columns, indexes, RLS policies
   - **Interactions to implement** — click handlers, form submissions, real-time updates
   - **Edge cases to handle** — specific edge cases called out in the design
   - **Implementation order** — recommended sequence (data layer → API → components → integration)
3. Flag any items with `[NEEDS CLARIFICATION]` if the design is ambiguous about implementation details
4. Save to Hermes memory under key: `implementation-spec-[feature-name]`
5. Write to `IMPLEMENTATION_SPEC.md` in the current directory
6. Run `choose-engine` to route to the appropriate coding engine

## Pitfalls

- Do not guess at data shapes not mentioned in the design output. Mark them [NEEDS CLARIFICATION].
- Do not assume a specific database schema unless it was stated in the design output or product brief.
- Implementation order matters — always start with the data layer, not the UI components.

## Verification

- `IMPLEMENTATION_SPEC.md` exists in current directory
- All ambiguities are marked [NEEDS CLARIFICATION]
- Spec is retrievable from Hermes memory as `implementation-spec-[feature-name]`
