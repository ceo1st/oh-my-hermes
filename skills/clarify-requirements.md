---
name: clarify-requirements
description: Ask structured clarifying questions before starting a new project or feature, then save answers to Hermes memory
version: 1.0.0
tags: [requirements, planning, memory]
---

## When to Use

Use at the start of a new project or a significant new feature when requirements are vague or not yet written down. Do not use for bug fixes or small targeted changes.

## Prerequisites

None. Run before anything else.

## Procedure

Ask these 7 questions. Wait for all answers before saving.

1. What problem does this solve? Who experiences it and how often?
2. Who are the primary users? Be specific (not "developers" — "solo founders building SaaS apps").
3. What are the 3 most important features for the first version? Priority order.
4. What is explicitly out of scope for this version?
5. What is the preferred tech stack, or are there constraints (existing codebase, required integrations)?
6. Are there hard constraints — deadline, budget, must-integrate-with systems, compliance?
7. What does success look like 30 days after launch?

After collecting all 7 answers:
- Save to Hermes memory under key: `requirements-[project-name]`
- Format as structured Q&A list
- Confirm to user and offer to run `product-brief`

## Pitfalls

- Do not start implementing during clarification. If user describes implementation, redirect: "Let's finish requirements first."
- Do not ask more than 7 questions.
- Do not save partial answers. Wait for all 7.
- If user cannot answer a question, save as "[OPEN QUESTION: ...]" — do not skip.

## Verification

Recall `requirements-[project-name]` from Hermes memory. Confirm all 7 answers are present and open questions are marked.
