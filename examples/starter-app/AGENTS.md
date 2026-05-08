# AGENTS — Oh My Hermes Starter App

This is the example starter app from the oh-my-hermes repo.

## Build Commands

```bash
npm install
npm run dev
npm run build
npm run typecheck
```

## Architecture

- Framework: Next.js App Router
- Database: Supabase PostgreSQL with RLS
- Auth: Supabase Auth
- Deployment: Vercel

## Security Baseline

Standard Oh My Hermes security requirements apply. See templates/AGENTS.md.template.

## Engine Guidance

- New features → Claude Code
- Small fixes → Codex
- Deploy/monitor → Hermes

## Monitoring

- Health: GET /api/health
- Uptime: Uptime Kuma polling /api/health
