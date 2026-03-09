# Supabase Feature Map

## Core surface areas

- Database: managed Postgres, SQL editor, extensions, replication/publications, RLS.
- Auth: JWT-backed authentication + authorization integration with RLS.
- Realtime: low-latency channels via Broadcast, Presence, Postgres Changes.
- Edge Functions: globally distributed Deno TypeScript runtime for HTTP/webhook/server-side workflows.
- Storage: files, analytics, and vector bucket types; CDN and transforms.
- CLI + local stack: `supabase init/start/link`, migration and deploy workflows.

## Fast routing

- Need mode decision for Realtime: open [realtime-modes.md](realtime-modes.md).
- Need function execution/deploy model: open [edge-functions.md](edge-functions.md).
- Need auth architecture and token/RLS model: open [auth.md](auth.md).
- Need file/object storage architecture: open [storage.md](storage.md).
- Need Postgres/API/RLS/publication behavior: open [database-api.md](database-api.md).
- Need local dev or CI bootstrap: open [cli-local-dev.md](cli-local-dev.md).

## Upstream search patterns

Run from `references/upstream/supabase-docs-markdown`:

```bash
rg -n "^title:|^id:" guides/realtime guides/functions guides/auth guides/storage guides/database guides/local-development guides/api
rg -n "publication|supabase_realtime|postgres_changes|broadcast|presence" guides/realtime guides/database
rg -n "verify-jwt|no-verify-jwt|deploy|serve|supabase functions" guides/functions
rg -n "row level security|RLS|policy|jwt" guides/auth guides/database guides/realtime
```

## Canonical docs location

- Snapshot manifest: [upstream/supabase-docs-manifest.md](upstream/supabase-docs-manifest.md)
- Markdown mirror root: `upstream/supabase-docs-markdown`
