# Workflows

## What workflows are

Workflows are composite documents that chain multiple skills together for a complete lifecycle outcome. They are not code — they are structured instructions that Hermes follows to coordinate a multi-step outcome. Each workflow references skills by name. Hermes loads them in order.

---

## Available workflows

### idea-to-deploy

The full journey from an idea to a running deployed app.

```
clarify-requirements     → stores answers in Hermes memory
product-brief            → generates brief from clarified requirements
[human] Claude Design    → UI/UX work (human step)
design-handoff           → converts design output to implementation spec
choose-engine            → routes to Claude Code or Codex
implement                → coding engine executes spec
deploy-to-vercel         → deploys, captures preview URL
connect-supabase         → wires database, runs migrations (if needed)
send-notification        → Slack notification with deployment URL
post-deploy-followup     → verifies health, logs deployment to memory
```

Invoke:
```
tell hermes: start a new app
```

---

### design-to-code

When requirements are clear but you want UI/UX design before coding.

```
[human] Claude Design    → UI/UX work
design-handoff           → design → implementation spec
choose-engine            → route to coding engine
implement                → execute spec
```

Invoke:
```
tell hermes: I have done design work. Convert it to code.
```

---

### deploy-and-monitor

For deploying an existing codebase and setting up monitoring.

```
deploy-to-vercel         → deploys, captures URL
connect-supabase         → (if needed)
setup-monitoring         → configures Uptime Kuma + Sentry
send-notification        → Slack notification
post-deploy-followup     → health check, memory log
```

Invoke:
```
tell hermes: deploy this app and set up monitoring
```

---

## Running individual skills

You do not need a full workflow every time:

```
tell hermes: run health-check on https://myapp.vercel.app
tell hermes: send a deployment notification to Slack
tell hermes: generate a product brief from our requirements
```

---

## Resuming a workflow

Hermes saves progress to memory. If a session ends mid-workflow:

```
tell hermes: we were running idea-to-deploy.
We completed clarify-requirements and product-brief.
Continue from design-handoff.
```

Hermes loads prior session memory and continues. No workflow state is lost between sessions.

---

## Custom workflows

Create workflow documents in `~/.hermes/workflows/`. Follow the structure of the included workflows. Reference skills by their `name` field from the skill frontmatter.
