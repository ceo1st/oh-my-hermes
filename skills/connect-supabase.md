---
name: connect-supabase
description: Wire a Supabase project to the app, set up migrations, and add environment variables to Vercel
version: 1.0.0
tags: [supabase, database, setup, ops]
---

## When to Use

When connecting a Supabase project for the first time, or when pushing new migrations to the live database.

## Prerequisites

- Supabase account and project created at supabase.com
- Supabase CLI: `npm install -g supabase`
- Logged in: `supabase login`
- Project ref from Supabase dashboard → Project Settings → General

## Procedure

**Initial setup:**
```bash
supabase init                               # initialize if not already done
supabase link --project-ref [project-ref]   # link to your project
```

Add to `.env.local` (values from Supabase dashboard → Settings → API):
```
SUPABASE_URL=https://[ref].supabase.co
SUPABASE_ANON_KEY=[anon-key]
SUPABASE_SERVICE_KEY=[service-role-key]
DATABASE_URL=postgresql://postgres:[password]@db.[ref].supabase.co:5432/postgres
```

Add vars to Vercel:
```bash
vercel env add SUPABASE_URL production
vercel env add SUPABASE_ANON_KEY production
vercel env add SUPABASE_SERVICE_KEY production
vercel env add DATABASE_URL production
```

Push existing migrations:
```bash
supabase db push
```

Save to Hermes memory: key `supabase-config`, value `{ projectRef, url }`.

**Adding new migrations:**
```bash
supabase migration new [migration-name]
# edit the generated file
supabase db push
```

## Pitfalls

- SUPABASE_SERVICE_KEY has full DB access — never expose to client or prefix with NEXT_PUBLIC_.
- `supabase db push` is irreversible for destructive changes. Review migration files before pushing.
- Always commit migration files to git — they are the source of truth for the schema.

## Verification

- `supabase status` shows linked and correct project
- All 4 vars in `.env.local` and Vercel dashboard
- `supabase db diff` shows no pending changes
