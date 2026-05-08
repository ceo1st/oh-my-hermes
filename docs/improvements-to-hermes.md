# Improvements to Hermes

Concrete proposals collected while building Oh My Hermes. Each is classified by where it should live.

Classifications:
- **Hermes core** — functionality that should be built into Hermes itself
- **Hermes docs** — better documentation or official examples in the Hermes repo
- **Extension layer** — this repo (Oh My Hermes) is the right home
- **Deferred** — good idea but not yet well-understood enough to implement

---

## 1. Official app-building workflow primitives

**Proposal:** Add a set of curated, officially-maintained skills to the Skills Hub specifically for app-building workflows: deploy, health-check, connect-database, setup-monitoring.

**Why:** The Skills Hub currently focuses on general productivity. App-building is one of the most common use cases for Hermes, but there are no official skills for it.

**Classification:** Hermes core (Skills Hub) — should be maintained by the Hermes team with versioning and tested against real deployments.

---

## 2. AGENTS.md app project template

**Proposal:** Ship an official `AGENTS.md` template for software projects in the Hermes documentation. It should include standard sections: Build Commands, Architecture, Security Baseline, Engine Guidance, Monitoring, Deployment.

**Why:** AGENTS.md is the most practical way to version-control agent behavior, but there is no official guidance on what sections a software project AGENTS.md should have.

**Classification:** Hermes docs — a template in the official docs with annotation for each section.

---

## 3. Structured deployment lifecycle events

**Proposal:** Add a `deploy` event type to Hermes cron and the skill system. Skills should be able to emit `deploy.started`, `deploy.completed`, and `deploy.failed` events that other skills can subscribe to.

**Why:** Currently, skills are sequential and stateless. Deployment workflows need to react to events (e.g., if deploy fails, trigger rollback or notification automatically). A basic event bus would unlock reactive workflows.

**Classification:** Hermes core — requires changes to the skill execution model.

---

## 4. Health check cron pattern documentation

**Proposal:** Add an official documented pattern for using Hermes cron to run recurring health checks. Show: how to set up a cron job that calls a health endpoint, parses the response, and sends a notification on failure.

**Why:** Hermes cron is powerful but the app-ops use case (monitor my app) is not documented anywhere.

**Classification:** Hermes docs — a tutorial or recipe in the docs, with a sample skill in Skills Hub.

---

## 5. Memory ergonomics for long-lived software projects

**Proposal:** Add a `project` memory type with explicit support for structured metadata: project name, tech stack, deployment URL, last deploy timestamp, monitoring status. This would be queryable with structured filters (e.g., "all projects deployed to Vercel").

**Why:** Currently, project memory is free-form strings. For a developer using Hermes to manage multiple active projects, querying memory is cumbersome. Structured types would make Hermes much more useful as an app-ops layer.

**Classification:** Hermes core — requires changes to the memory data model.

---

## 6. Multi-engine orchestration documentation

**Proposal:** Official documentation for the pattern of using Hermes to orchestrate Claude Code and Codex as sub-engines. Currently there is no guidance on how Hermes should hand off tasks to these tools.

**Why:** This is the central orchestration pattern of Oh My Hermes, and developers using Hermes for app-building will naturally want to use multiple coding engines. Without documentation, they have to discover the pattern themselves.

**Classification:** Hermes docs — a guide titled "Using Hermes to orchestrate coding engines."

---

## 7. Design-to-code handoff pattern

**Proposal:** Official documentation for the Claude Design → Hermes → coding engine handoff flow. Include: how to structure design output for agent consumption, how to use Hermes memory as the handoff medium, how to route to Claude Code or Codex.

**Why:** Claude Design and Claude Code/Codex are made by the same company. There should be a documented way to use them together. Currently, this workflow requires assembling it yourself.

**Classification:** Hermes docs — a workflow recipe. Ideally, a joint Anthropic/Nous Research document or tutorial.

---

## 8. Better onboarding for app-building use cases

**Proposal:** Add an "App builder" track to the Hermes onboarding flow. After installing, users should be able to choose: "I want to use Hermes as a personal assistant" vs "I want to use Hermes to build and operate software." The second track installs relevant skills and sets up project conventions.

**Why:** The current onboarding is general-purpose. Developers who want to use Hermes for software projects have to figure out the app-building setup on their own.

**Classification:** Hermes core — changes to the CLI onboarding flow.

---

## 9. MCP integration patterns for developer tools

**Proposal:** Official examples of Hermes using MCP (Model Context Protocol) to connect with developer tools: GitHub (create PRs, manage issues), Vercel (query deployment status), Sentry (query recent errors), Linear (create incidents).

**Why:** Hermes supports MCP but there are no official examples for the developer tooling integrations that would make it most useful for software teams.

**Classification:** Hermes docs — a "Developer tools" section in the integrations documentation.

---

## 10. Per-project skill scoping

**Proposal:** Allow skills to be scoped to a specific project via AGENTS.md. Example: `skills: [deploy-to-vercel, connect-supabase]` in AGENTS.md would limit which skills Hermes loads when working in that project.

**Why:** As the Skills Hub grows, Hermes will have many skills loaded globally. Per-project scoping would prevent skill name collisions and reduce noise in skill matching.

**Classification:** Hermes core — requires changes to the skill discovery mechanism.
