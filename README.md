<img src="banner.png" alt="Oh My Hermes" width="100%" />

# Oh My Hermes

[![Stars](https://img.shields.io/github/stars/salomondiei08/oh-my-hermes?style=flat-square)](https://github.com/salomondiei08/oh-my-hermes/stargazers)
[![License](https://img.shields.io/badge/license-MIT-blue?style=flat-square)](LICENSE)
[![Hermes](https://img.shields.io/badge/Hermes-v0.13%2B-orange?style=flat-square)](https://hermes-agent.nousresearch.com)
[![Skills](https://img.shields.io/badge/skills-23-brightgreen?style=flat-square)](#skills)
[![Agents](https://img.shields.io/badge/agents-6-blue?style=flat-square)](#agents)

**An opinionated workflow layer for building, shipping, and operating apps — delivered directly to Hermes.**

Like Oh My Zsh is to Zsh. You install it once and Hermes becomes genuinely useful for real software projects. Not a chatbot wrapper. Not a prompt pack. A curated set of skills that Hermes loads and runs autonomously — on your VPS, on your laptop, wherever Hermes lives.

> **AI agent?** See [INSTALL_FOR_AGENTS.md](INSTALL_FOR_AGENTS.md) for the one-command install protocol.

---

## The core idea

Hermes is the operator. It talks to you. It remembers. It builds. It deploys. It monitors. It notifies.

You describe what you want in plain language — on Telegram, Slack, Discord, your terminal, wherever you have Hermes configured. Hermes loads the right skill and runs the workflow. Claude Code and Codex are optional engines Hermes can invoke when a task needs deep file editing — but Hermes handles the orchestration, the ops, the memory, and the lifecycle on its own.

**Hermes does not need Claude Code or Codex to be useful.** Those are optional. Hermes itself has a terminal backend and can write, edit, and run code directly.

---

## How it all fits together

```
┌─────────────────────────────────────────────────────────────────┐
│                        YOU (founder)                            │
│         Telegram · Slack · Discord · WhatsApp · terminal        │
└──────────────────────────┬──────────────────────────────────────┘
                           │  plain-language messages
                           ▼
┌─────────────────────────────────────────────────────────────────┐
│                   HERMES  (VPS / local, 24/7)                   │
│                                                                 │
│  ┌──────────┐   routes to   ┌─────────────────────────────────┐ │
│  │ Gateway  │ ────────────▶ │        CTO Agent                │ │
│  │(Telegram │               │  monitors kanban, orchestrates  │ │
│  │ /Slack…) │               └───────────┬─────────────────────┘ │
│  └──────────┘                           │  spawns sub-agents    │
│                      ┌──────────────────┼──────────────┐        │
│                      ▼                  ▼              ▼        │
│               ┌────────────┐  ┌──────────────┐  ┌──────────┐   │
│               │  PM · Dev  │  │ QA · Security│  │   Ops    │   │
│               │ triage     │  │ review · scan│  │ deploy   │   │
│               │ implement  │  │ approve      │  │ monitor  │   │
│               └─────┬──────┘  └──────┬───────┘  └────┬─────┘   │
│                     │                │               │          │
│              ┌──────▼────────────────▼───────────────▼──────┐   │
│              │              Hermes Kanban                    │   │
│              │   Backlog → In Progress → Review → Done       │   │
│              └───────────────────────────────────────────────┘   │
│                                                                 │
│  Persistent memory · 23 skills · 5 workflows · cron jobs        │
└──────┬──────────────────────────────────────────────────────────┘
       │
       ├──▶  Claude Code  (complex multi-file coding)
       ├──▶  Codex        (quick single-file fixes)
       ├──▶  Vercel       (hosting + preview URLs)
       ├──▶  Supabase     (database + auth + migrations)
       ├──▶  GitHub       (issues, PRs, merge)
       └──▶  Sentry / Uptime Kuma  (monitoring)
```

---

## Full project lifecycle

From idea to running production app, Hermes handles each stage:

```
IDEA
  ↓  onboarding            ← Bot asks everything in chat, configures the loop
  ↓  clarify-requirements  ← Hermes asks 7 questions, saves answers to memory
  ↓  product-brief         ← Writes PRODUCT_BRIEF.md from requirements
  ↓  design-handoff        ← Converts your design notes to an implementation spec
  ↓  choose-engine         ← Decides: Hermes / Claude Code / Codex
  ↓  implement             ← Builds it — surgical changes, no secrets committed
  ↓  deploy-to-vercel      ← Pre-deploy checks → deploy → captures URL
  ↓  connect-supabase      ← Links DB, pushes migrations, sets env vars
  ↓  setup-monitoring      ← Sentry + Uptime Kuma
  ↓  post-deploy-followup  ← Health check → log → notify you
  ↓
RUNNING APP
  ↓  auto-issue-triage     ← Every hour: scores issues, picks top priority
  ↓  implement + PR        ← Dev Agent builds, Security Agent reviews
  ↓  await-merge-approval  ← Sends you YES/NO message
  ↓  YOU reply YES         ← Merges, deploys, health-checks, confirms
  ↓
REPEAT — Hermes watches it, you approve changes
```

---

## The autonomous CTO loop

Once configured, this runs every hour without you touching anything:

```
GitHub issue opens
       ↓
  PM Agent scores & triages  →  kanban: Backlog
       ↓
  Dev Agent implements  →  kanban: In Progress
       ↓
  Security Agent: secret scan + OWASP check + CVE check
       ↓
  QA Agent: build check + health check + plain-English summary
       ↓
  YOU get a message on Telegram:
  ────────────────────────────────────────
  PR #12 — Fix login redirect

  What changed: Users who hadn't verified their email were
  sent to a broken page. They now see "Check your inbox."

  Build: passing  |  Preview: healthy (180ms)  |  No secrets found
  Preview: https://myapp-fix-login.vercel.app

  Reply YES to ship. Reply NO and tell me why.
  ────────────────────────────────────────
       ↓
  YES → merges, deploys, health-checks, confirms live URL to you
  NO  → Dev Agent iterates on your feedback
```

---

## Get started

**Step 1 — Install Hermes Agent**

Follow the [Hermes quickstart](https://hermes-agent.nousresearch.com/docs/getting-started/quickstart). At the end you have a bot you can message on Telegram (or Slack, Discord, WhatsApp).

**Step 2 — Install Oh My Hermes**

```bash
curl -fsSL https://raw.githubusercontent.com/salomondiei08/oh-my-hermes/main/install.sh | bash
```

**Step 3 — Message your bot**

```
set up the CTO loop
```

The bot will ask for your GitHub repo, walk you through creating a token step by step, ask for your production URL, and configure everything. No terminal needed after Step 2.

**What you unlock at each step:**

| Step | What to do | What you get |
|---|---|---|
| 1 | Install Hermes + connect Telegram | A bot you can message |
| 2 | Run install.sh | 23 skills and 5 workflows loaded |
| 3 | Message: "set up the CTO loop" | Bot guides the full setup in chat |
| 4 | Bot asks for GitHub token | Issues monitored, PRs managed |
| 5 | Bot asks for production URL | Health checks every 15 min |
| 6 | `/goal` command | Agent stays focused across long sessions |
| — | Autonomous from here | Hourly triage, daily report, weekly security scan |

---

## Skills

| Skill | What Hermes does |
|---|---|
| `onboarding` | Guides full setup in chat — no terminal, no manual config |
| `clarify-requirements` | Asks 7 structured questions, saves answers to memory |
| `product-brief` | Generates a product brief, writes PRODUCT_BRIEF.md |
| `design-handoff` | Converts design notes to an implementation spec |
| `create-skill` | Creates a new skill in the correct format (meta-skill) |
| `choose-engine` | Routes tasks to Hermes, Claude Code, or Codex |
| `implement-with-claude-code` | Scaffolds Claude Code with full context + scope constraints |
| `implement-with-codex` | Scaffolds Codex for targeted single-file fixes |
| `deploy-to-vercel` | Pre-deploy checks → deploy → capture URL |
| `connect-supabase` | Links Supabase, pushes migrations, sets Vercel env vars |
| `setup-monitoring` | Configures Sentry + Uptime Kuma |
| `health-check` | Calls `/api/health`, validates response, checks Supabase + Vercel logs |
| `send-notification` | Sends Slack webhook with deployment or status info |
| `post-deploy-followup` | Health check + deployment log + notification + summary |
| `manage-github-issues` | Triage, create, label, assign, and close GitHub issues |
| `create-github-pr` | Creates PR with secret scan before opening |
| `auto-issue-triage` | Hourly: scores open issues, picks top priority, starts work |
| `review-github-pr` | Reviews PR diff, runs checks, writes plain-English summary |
| `security-review` | Secret scan + OWASP check + CVE audit + weekly supply chain |
| `await-merge-approval` | Sends YES/NO message to founder, merges or iterates |
| `kanban-task` | Creates and updates Hermes kanban cards at every stage |
| `cto-status-report` | Daily morning report: what's in progress, done, blocked |
| `backup-hermes-data` | Tarballs `~/.hermes/` to S3, Dropbox, or local |

---

## Agents

| Agent | Role | Kanban ownership |
|---|---|---|
| **CTO** | Orchestrates all agents, monitors kanban, reports to you daily | All columns |
| **PM** | Triages GitHub issues, writes tickets, prioritizes backlog | Backlog |
| **Dev** | Implements tickets, picks the right engine, creates PRs | In Progress |
| **Security** | Scans every PR for secrets, OWASP issues, and CVEs | Between Dev and QA |
| **QA** | Reviews PRs, runs health checks, writes founder summary | Review |
| **Ops** | Deploys, monitors production, handles incidents | Done + monitoring |

Role definitions live in `agents/`. Running `scripts/setup-cto.sh` (or messaging "set up the CTO loop") creates the actual Hermes profiles and makes the agents active.

---

## Workflow examples

**Start a new project:**
```
you: start a new app
hermes: What problem does this solve? Who experiences it?
you: [answer]
hermes: [6 more questions…]
hermes: Requirements saved. Generating product brief…
hermes: Brief written to PRODUCT_BRIEF.md. Ready to implement or do design first?
```

**Deploy after implementing:**
```
you: deploy this to Vercel
hermes: Running pre-deploy checklist…
hermes: Deploying… done. URL: https://myapp.vercel.app
hermes: Health check: PASS (200ms)
hermes: Notification sent to Slack.
```

**Quick fix:**
```
you: fix the auth redirect bug in src/middleware.ts
hermes: Loading context… routing to Codex (single-file fix)
hermes: Done. Typecheck passes. Creating PR…
hermes: PR #14 ready — reply YES to ship.
```

**Steer mid-session (Hermes v0.13+):**
```
you: /steer prioritize the payment bug above everything else
hermes: Understood. Switching Dev Agent to issue #38.
```

---

## Default stack

| Layer | Default | Alternative |
|---|---|---|
| Frontend / full-stack | Vercel | Railway, Render |
| Database | Supabase PostgreSQL | PlanetScale, Neon |
| Auth | Supabase Auth | Clerk, Auth.js |
| Error tracking | Sentry | LogRocket |
| Uptime monitoring | Uptime Kuma | Better Uptime |
| Notifications | Slack webhook | Telegram, Email |

All pluggable. Each skill documents how to substitute.

---

## Running on a VPS

The intended setup for production use — Hermes runs 24/7, crons fire automatically, you interact from your phone:

```bash
# On a $5/month VPS (Ubuntu 22.04+)
curl -fsSL https://raw.githubusercontent.com/NousResearch/hermes-agent/main/scripts/install.sh | bash
hermes model        # choose your provider (Anthropic, OpenAI, etc.)
hermes gateway setup && hermes gateway start   # connect Telegram or Slack

# Then install Oh My Hermes
curl -fsSL https://raw.githubusercontent.com/salomondiei08/oh-my-hermes/main/install.sh | bash

# Message your bot: "set up the CTO loop"
```

For Docker:
```bash
docker run -d --restart=always \
  -v hermes-data:/root/.hermes \
  nousresearch/hermes-agent
```

---

## Installation scripts

| Script | What it does |
|---|---|
| `install.sh` | Installs all skills, workflows, and agent definitions |
| `scripts/bootstrap.sh` | Creates `AGENTS.md`, `.env.example`, health endpoint in a project |
| `scripts/setup-cto.sh` | Creates profiles, initializes kanban, schedules crons |
| `scripts/verify.sh` | Checks everything is installed correctly |
| `scripts/uninstall.sh` | Removes all Oh My Hermes files from `~/.hermes/` |

---

## Optional: GBrain memory backbone

[GBrain](https://github.com/garrytan/gbrain) gives Hermes a richer, self-updating knowledge graph — people, companies, decisions, deployment history — queryable across sessions.

```bash
git clone https://github.com/garrytan/gbrain.git ~/gbrain && cd ~/gbrain
curl -fsSL https://bun.sh/install | bash && export PATH="$HOME/.bun/bin:$PATH"
bun install && bun link && gbrain init
```

Do not use `npm install -g gbrain` — a squatter package exists on npm under that name.

---

## Architecture

```
oh-my-hermes/
├── skills/          ← 23 skill files → ~/.hermes/skills/
├── workflows/       ← 5 workflow files → ~/.hermes/workflows/
├── agents/          ← 6 agent role definitions → ~/.hermes/agents/
├── templates/       ← AGENTS.md template, .env example, health endpoint
├── scripts/         ← install, bootstrap, verify, setup-cto, uninstall
└── docs/            ← Full documentation
```

See [docs/architecture.md](docs/architecture.md) for detail.

---

## Roadmap

**V1 — current**
23 skills, 6 agents, 5 workflows, chat-guided onboarding, security agent, Karpathy code principles, one-command CTO setup, Vercel + Supabase + GitHub ops.

**V2 — planned**
Rollback skill, staging → production promotion workflow, incident creation, post-deploy automated tests.

**V3 — planned**
Multi-service orchestration, more example apps, hosted setup wizard.

---

## Star history

[![Star History Chart](https://api.star-history.com/svg?repos=salomondiei08/oh-my-hermes&type=Date)](https://star-history.com/#salomondiei08/oh-my-hermes&Date)

---

## Contributing

Read [docs/architecture.md](docs/architecture.md) before proposing features. Open issues for wrong or missing skills, bugs in scripts, or Hermes improvement proposals.

---

## License

MIT
