---
name: create-skill
description: Create a new Oh My Hermes skill in the correct SKILL.md format and install it to ~/.hermes/skills/
version: 1.0.0
tags: [meta, skills, creation]
---

## When to Use

When you want to add a new skill to Oh My Hermes — either to extend the existing skill pack or to create a project-specific skill. This is the meta-skill: use Oh My Hermes to build Oh My Hermes.

## Prerequisites

- Oh My Hermes installed (skills directory at `~/.hermes/skills/`)
- A clear idea of what the new skill should do

## Procedure

Ask the user for the following information before generating:

1. **Skill name** — lowercase, hyphenated (e.g. `create-github-pr`)
2. **One-line description** — this is what Hermes uses to decide when to load the skill
3. **When to use** — specific trigger conditions
4. **What it does** — step-by-step procedure
5. **Prerequisites** — tools, credentials, prior state required
6. **Known pitfalls** — anything that has gone wrong with this type of task before

Then generate the skill file in this exact format:

```markdown
---
name: [skill-name]
description: [one-line description for Hermes matching]
version: 1.0.0
tags: [tag1, tag2]
---

## When to Use
[specific trigger conditions — not vague]

## Prerequisites
[everything required before this skill can run]

## Procedure
[numbered steps — specific and testable]

## Pitfalls
[only real failure modes, not hypotheticals]

## Verification
[concrete check that the skill completed successfully]
```

Write the skill to two locations:
1. `~/.hermes/skills/[skill-name].md` — so Hermes loads it immediately
2. `/path/to/oh-my-hermes/skills/[skill-name].md` — so it persists in the repo (if the repo is accessible)

Save to Hermes memory: key `skill-created-[skill-name]`, value: `{ name, description, date }`

Offer to run the new skill immediately to test it.

## Pitfalls

- The `description` field is the most important line. Hermes uses it to match incoming requests to skills. Make it specific and action-oriented: "Deploy project to Vercel with pre-deploy checks" not "Vercel deployment."
- Do not include aspirational steps in the Procedure. Only steps that are concrete and testable.
- The Pitfalls section should only contain failures that have actually been observed, not hypothetical problems.
- After writing the skill, always confirm it was written to `~/.hermes/skills/` — not just to the repo directory.

## Verification

- `~/.hermes/skills/[skill-name].md` exists
- Skill is loadable: tell Hermes "load skill [skill-name]"
- Skill saved to Hermes memory
