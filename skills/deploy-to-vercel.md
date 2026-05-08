---
name: deploy-to-vercel
description: Deploy project to Vercel with pre-deploy checks, capture the deployment URL, and verify health
version: 1.0.0
tags: [deployment, vercel, ops]
---

## When to Use

When deploying to Vercel for the first time, or redeploying after changes. Run after implementation is complete and the build passes locally.

## Prerequisites

- Vercel CLI installed: `npm install -g vercel`
- Logged in: `vercel login`
- Git repo initialized with at least one commit
- Project has `/api/health` endpoint

## Procedure

**Pre-deploy checklist (fix before continuing if any fail):**
1. `git status` — clean working tree, no uncommitted changes
2. `.env.local` is in `.gitignore`
3. `AGENTS.md` is committed
4. `/api/health` endpoint exists
5. `npm run build` passes locally

**First-time deploy:**
```bash
vercel        # interactive — link to Vercel project
vercel --prod
```

**Redeployment:**
```bash
vercel --prod
```

Capture the deployment URL from output.

**Set up GitHub auto-deploy (one-time setup):**
```bash
vercel link
# Then: Vercel dashboard → Settings → Git → Connect Repository
```
After connecting, main branch pushes deploy to production automatically. Other branch pushes create preview deployments.

**Post-deploy:**
1. Run `health-check` on the deployed URL
2. Save to Hermes memory: key `last-deployment`, value `{ url, timestamp, status: "deployed" }`
3. Offer to run `send-notification`
4. Offer to run `setup-monitoring` if not yet configured

## Pitfalls

- A successful `vercel --prod` exit code does NOT mean the app is healthy. Always run `health-check` after.
- If build fails on Vercel but passes locally: check Vercel env vars, Node.js version, missing build deps.
- Force fresh build if it seems cached: `vercel --force --prod`

## Verification

- `vercel --prod` exits 0
- Deployment URL captured and saved to Hermes memory
- `health-check` returns HTTP 200 with `{ "status": "ok" }`
