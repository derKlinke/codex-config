---
name: infra-supabase-master
description: Use when a task involves Supabase architecture, implementation, operations, or debugging across Edge Functions, Realtime, Postgres, Auth, Storage, CLI, and platform configuration.
---

# Supabase Master (Infra)

## Scope

Unified Supabase entrypoint skill. Routes requests to focused local references and full upstream docs snapshot.

## Workflow

1. Open [references/feature-map.md](references/feature-map.md) first.
2. Select domain reference from the routing table below.
3. For implementation/details, query upstream markdown mirror with `rg` under:
   - `references/upstream/supabase-docs-markdown`
4. For SQL/postgres optimization tasks, also load:
   - `/Users/fabianklinke/.codex/skills/supabase-postgres-best-practices/SKILL.md`

## Routing

| Task shape | Read first | Then load |
| --- | --- | --- |
| Realtime architecture, channel design, mode selection | [references/realtime-modes.md](references/realtime-modes.md) | `guides/realtime/*.md` in upstream mirror |
| Edge Functions design, local dev, deploy, JWT behavior | [references/edge-functions.md](references/edge-functions.md) | `guides/functions/*.md` in upstream mirror |
| Auth strategy (JWT/RLS coupling, provider choice, session model) | [references/auth.md](references/auth.md) | `guides/auth/*.md` in upstream mirror |
| Storage architecture (bucket types, serving, security, uploads) | [references/storage.md](references/storage.md) | `guides/storage/*.md` in upstream mirror |
| Database + API (schema, RLS, publications, PostgREST) | [references/database-api.md](references/database-api.md) | `guides/database/*.md`, `guides/api/*.md` |
| Local dev/CI pipelines with Supabase CLI | [references/cli-local-dev.md](references/cli-local-dev.md) | `guides/local-development/**/*.md` |
| Project-level navigation across all Supabase features | [references/feature-map.md](references/feature-map.md) | [references/upstream/supabase-docs-manifest.md](references/upstream/supabase-docs-manifest.md) |

## Upstream docs snapshot

- Mirror root: `references/upstream/supabase-docs-markdown`
- Provenance + counts: [references/upstream/supabase-docs-manifest.md](references/upstream/supabase-docs-manifest.md)

## Refresh docs snapshot

Run:

```bash
bash /Users/fabianklinke/.codex/skills/infra-supabase-master/scripts/sync-upstream-docs.sh
```

This updates `supabase-docs-src`, rebuilds markdown mirror, and regenerates the manifest.
