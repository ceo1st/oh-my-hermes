# Oh My Hermes Starter App

A minimal Next.js + Supabase + Vercel starter that demonstrates the oh-my-hermes workflow.

## What this demonstrates

- Health endpoint at `/api/health`
- AGENTS.md conventions for AI agents
- `.env.example` with all required variables
- Ready for deployment to Vercel and connection to Supabase

## Use this as a starting point

1. Install Oh My Hermes: `bash /path/to/oh-my-hermes/install.sh`
2. Copy this directory to your new project location
3. Run `npm install`
4. Fill in `.env.example` → `.env.local`
5. Tell Hermes: "run the idea-to-deploy workflow"

## Health endpoint

`GET /api/health` returns:

```json
{
  "status": "ok",
  "version": "1.0.0",
  "timestamp": "2026-05-09T10:00:00.000Z"
}
```

## Docs

Full documentation at the [oh-my-hermes repo](https://github.com/Salomondiei08/oh-my-hermes).
