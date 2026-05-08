---
name: product-brief
description: Generate a written product brief from clarified requirements and save it to Hermes memory and PRODUCT_BRIEF.md
version: 1.0.0
tags: [planning, brief, memory]
---

## When to Use

After `clarify-requirements` has run and answers are saved to Hermes memory. Creates a written artifact that can be handed to a coding engine or shared with collaborators.

## Prerequisites

- Hermes memory contains `requirements-[project-name]`

## Procedure

1. Retrieve `requirements-[project-name]` from Hermes memory.
2. Generate a product brief with these sections:
   - **Problem Statement** — one paragraph: what problem, who has it, how often
   - **Target Users** — specific description (not "developers" — be precise)
   - **Core Features (V1)** — numbered list, priority order, max 5, each with one-sentence description
   - **Out of Scope (V1)** — numbered list of explicit exclusions
   - **Tech Stack** — each layer (frontend, backend, database, auth, deployment, monitoring) with chosen tool and one-sentence rationale
   - **Success Criteria** — measurable outcomes 30 days after launch
   - **Open Questions** — anything marked [OPEN QUESTION] in requirements
3. Save to Hermes memory under key: `product-brief-[project-name]`
4. Write to `PRODUCT_BRIEF.md` in current directory
5. Offer to continue to design-handoff or choose-engine

## Pitfalls

- Do not invent requirements not in memory. Mark anything unclear as an open question.
- Do not list more than 5 core features. Pick the 5 highest-priority.
- Tech stack section must be specific. "Supabase PostgreSQL — chosen for built-in RLS and auth" not "we'll use a database."

## Verification

- `PRODUCT_BRIEF.md` exists in current directory
- Brief retrievable from Hermes memory as `product-brief-[project-name]`
- All open questions from requirements appear in the Open Questions section
