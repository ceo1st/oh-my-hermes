# Oh My Hermes

**An opinionated workflow layer for building, shipping, and operating apps with Hermes Agent.**

Like Oh My Zsh is to Zsh — not a replacement, an extension. Oh My Hermes gives Hermes the rails it needs to take you from raw idea to deployed app to monitored production system, without losing your mind in the middle.

---

## What problem does this solve?

Hermes Agent is powerful: persistent memory, autonomous skill generation, 19+ messaging platforms, cron scheduling, flexible deployment. But out of the box, it doesn't tell you *how* to use all of that to ship an app. There are no defaults for Vercel, no conventions for Supabase, no curated skills for the idea→deploy lifecycle, no AGENTS.md template for real projects.

Oh My Hermes fills that gap.

It is a curated collection of:

- **Skills** — 12 tested workflow skills covering the full app lifecycle
- **Conventions** — AGENTS.md templates and project structure standards that Hermes and other coding agents understand
- **Engine routing** — a clear framework for when to use Hermes, Claude Code, Codex, or Claude Design
- **Deployment patterns** — opinionated defaults for Vercel + Supabase + monitoring
- **Templates** — health endpoint starters, `.env` examples, project bootstrap scripts
- **Documentation** — a real architecture guide, not just a README

---

## The mental model

```
YOU
  └─ describe an idea

HERMES (operator + memory + orchestrator)
  ├─ clarifies requirements
  ├─ generates a product brief
  ├─ remembers project context across sessions
  ├─ routes work to the right engine
  ├─ runs deployment and health checks
  ├─ sends notifications
  └─ monitors production on a schedule

CLAUDE DESIGN (design surface — human step)
  └─ UI/UX exploration, wireframes, design handoff spec

CLAUDE CODE (coding engine)
  └─ complex multi-file changes, new features, architecture, refactors

CODEX (coding engine)
  └─ quick targeted fixes, single-file changes, exploration

VERCEL (deployment)
  └─ automatic deploys on git push, preview URLs, production

SUPABASE (backend)
  └─ PostgreSQL, auth, storage, RLS policies, migrations
```

Hermes is the operator that lives between all of these. It remembers. It schedules. It routes. It notifies. It never forgets context between sessions.

---

## Lifecycle

```
IDEA
  ↓  clarify-requirements    ← Hermes asks clarifying questions, stores answers
  ↓  product-brief           ← Hermes generates a brief and saves it to memory
  ↓  design-with-claude      ← You open Claude Design (human step), do UI/UX work
  ↓  design-handoff          ← Convert design output into an implementation spec
  ↓  choose-engine           ← Hermes routes the task: Claude Code or Codex
  ↓  implement               ← Coding engine executes against the spec
  ↓  deploy-to-vercel        ← Hermes deploys to Vercel, captures preview URL
  ↓  connect-supabase        ← Hermes wires up database, runs migrations
  ↓  send-notification       ← Hermes notifies you via Slack or email
  ↓  setup-monitoring        ← Hermes configures Uptime Kuma + Sentry
  ↓  post-deploy-followup    ← Hermes verifies health, logs deployment to memory
  ↓
RUNNING APP
  ↓  cron health checks      ← Hermes watches your app on a schedule (V2)
  ↓  incident response       ← Hermes alerts on failure (V2)
  ↓  iterate                 ← Loop back to implement with full project memory
```

---

## Installation

### For humans

**Requirements:**
- [Hermes Agent](https://hermes-agent.nousresearch.com/docs/getting-started/quickstart) v0.9+ installed
- Hermes skills directory at `~/.hermes/skills/`

```bash
curl -fsSL https://raw.githubusercontent.com/yourusername/oh-my-hermes/main/install.sh | bash
```

The installer copies all skills to `~/.hermes/skills/`, copies workflow files to `~/.hermes/workflows/`, confirms what was installed, and prints next steps.

### For new projects

Run the bootstrap script inside your project directory:

```bash
curl -fsSL https://raw.githubusercontent.com/yourusername/oh-my-hermes/main/scripts/bootstrap.sh | bash
```

This creates:
- `AGENTS.md` — pre-filled with conventions for your project
- `.env.example` — with all expected variables documented
- `src/app/api/health/route.ts` — a health endpoint (Next.js App Router)

### For LLM coding agents

If you are an AI agent setting up Oh My Hermes in a project:

```bash
git clone https://github.com/yourusername/oh-my-hermes
cd oh-my-hermes
bash install.sh
```

Then bootstrap the target project:

```bash
cd /path/to/your/project
bash /path/to/oh-my-hermes/scripts/bootstrap.sh
```

Verify the install:

```bash
bash /path/to/oh-my-hermes/scripts/verify.sh
```

---

## Engine routing

The decision is not arbitrary. Here is the framework:

| Situation | Use |
|---|---|
| UI/UX decision before any code exists | Claude Design (human-in-the-loop) |
| Complex multi-file change, new feature, architecture refactor | Claude Code |
| Quick fix, single-file change, prototype, exploration | Codex |
| Deploy, monitor, notify, schedule, remember context across sessions | Hermes directly |
| Not sure what to do next | Ask Hermes — it orchestrates |

Run the `choose-engine` skill in Hermes to get a routing recommendation for your specific task.

---

## Skills included

| Skill | What it does |
|---|---|
| `clarify-requirements` | Asks structured questions, stores answers in Hermes memory |
| `product-brief` | Generates a product brief from clarified requirements |
| `design-handoff` | Converts Claude Design output into an implementation spec |
| `choose-engine` | Routes a task to Claude Code, Codex, or Hermes |
| `implement-with-claude-code` | Scaffolds a Claude Code session for a task |
| `implement-with-codex` | Scaffolds a Codex session for a task |
| `deploy-to-vercel` | Deploys project to Vercel with pre-deploy checks |
| `connect-supabase` | Wires Supabase into a project, runs migrations |
| `setup-monitoring` | Configures Uptime Kuma + Sentry for a deployed app |
| `health-check` | Checks a running app's `/health` endpoint |
| `send-notification` | Sends a Slack or email notification |
| `post-deploy-followup` | Verifies deployment, logs to memory, checks health |

---

## Workflow examples

**Start a new app from scratch:**

```
tell hermes: start a new project
→ Hermes loads clarify-requirements skill
→ Hermes asks 5–7 clarifying questions, you answer
→ Hermes saves answers to memory, generates product brief
→ You open Claude Design for UI/UX work (human step)
→ You run design-handoff skill: design → implementation spec
→ Hermes routes to Claude Code (complex multi-file new app)
→ Claude Code implements the spec
→ Hermes runs deploy-to-vercel
→ Hermes sends Slack notification with preview URL
```

**Fix a bug quickly:**

```
tell hermes: fix the auth redirect bug in src/middleware.ts
→ Hermes loads context from memory (auth decisions, architecture)
→ Hermes routes to Codex (single-file targeted fix)
→ Codex fixes the bug, commits
→ Hermes deploys and verifies health endpoint
```

**Add a major feature:**

```
tell hermes: add subscription billing
→ Hermes loads product memory (architecture, database schema)
→ Hermes routes to Claude Code (complex multi-file, new subsystem)
→ Claude Code implements with Stripe + Supabase
→ Hermes runs connect-supabase to apply new migrations
→ Hermes deploys, verifies health, notifies with URL
```

---

## Deployment defaults

| Layer | Default | Alternative |
|---|---|---|
| Frontend / full-stack | Vercel | Railway, Render |
| Database | Supabase PostgreSQL | PlanetScale, Neon |
| Auth | Supabase Auth | Clerk, Auth.js |
| Storage | Supabase Storage | Cloudflare R2 |
| Error tracking | Sentry | LogRocket |
| Uptime monitoring | Uptime Kuma (self-hosted) | Better Uptime |
| Notifications | Slack webhook | Email (SendGrid) |

All defaults are pluggable. Each skill documents where to change the default.

---

## Architecture

See [docs/architecture.md](docs/architecture.md) for the full architecture guide.

```
oh-my-hermes/
├── skills/          ← Load into Hermes (~/.hermes/skills/)
├── workflows/       ← Composite multi-skill workflows
├── templates/       ← AGENTS.md template, .env example, health endpoints
├── examples/        ← Starter app (Next.js + Supabase + Vercel)
├── scripts/         ← bootstrap.sh, verify.sh
└── docs/            ← Full documentation
```

---

## Improvements to Hermes

This project tracks proposed improvements to Hermes itself. See [docs/improvements-to-hermes.md](docs/improvements-to-hermes.md) for a documented list of concrete proposals, classified by whether they belong in Hermes core, Hermes docs, or this extension layer.

---

## Requirements

- Hermes Agent v0.9+ (tested on v0.13)
- Writable `~/.hermes/skills/` directory
- For deployment skills: Vercel account + Vercel CLI
- For database skills: Supabase account + Supabase CLI
- For notification skills: Slack webhook URL

Claude Code and Codex are optional but recommended for implementation engine skills.

---

## What this is not

- Not a replacement for Hermes
- Not a custom agent runtime or daemon
- Not a no-code tool
- Not Claude Design (there is no Claude Design API)
- Not a dashboard product

---

## Roadmap

**V1 — current**
12 lifecycle skills, AGENTS.md conventions, Vercel + Supabase integration, bootstrap scripts, full docs, example starter app.

**V2 — in progress**
Cron-based health monitoring, incident creation skill, post-deploy automated tests, staging → production promotion.

**V3 — planned**
Multi-service orchestration, rollback skill, more example apps (SaaS, API-only, edge functions).

---

## Contributing

Read [docs/architecture.md](docs/architecture.md) before proposing features — it explains what belongs here versus in Hermes core. Open issues for wrong or missing skills, bugs in scripts, or proposed improvements to Hermes itself.

---

## License

MIT
