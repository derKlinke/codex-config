# Database + API

## Core model

- Supabase projects run managed Postgres with first-class SQL access.
- API layer (PostgREST) reflects schema + role/JWT/RLS constraints.
- Realtime Postgres Changes depends on publication wiring (`supabase_realtime`).

## Design directives

- Make RLS policies explicit early; treat as primary authorization boundary.
- Keep publication membership intentional for change-stream scope.
- Use SQL migrations as canonical schema evolution path.

## Troubleshooting cues

- Missing realtime events: validate publication + schema/table filters.
- Data API auth mismatch: inspect JWT role/claims and RLS predicates.
- Performance path: delegate deep SQL tuning to `supabase-postgres-best-practices` skill.

## Primary upstream docs

- `guides/database/overview.md`
- `guides/database/postgres/row-level-security.md`
- `guides/database/extensions.md`
- `guides/database/replication.md`
- `guides/api/rest/client-libs.md`
- `guides/api/rest/postgrest-error-codes.md`
