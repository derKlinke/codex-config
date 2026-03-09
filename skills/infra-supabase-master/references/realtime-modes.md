# Realtime Modes

## Modes

- Broadcast: low-latency arbitrary event transport over channels.
- Presence: synchronized per-client state on channels (`sync`/`join`/`leave`).
- Postgres Changes: logical replication stream from DB changes to clients.

## Decision matrix

- Use Broadcast when the source-of-truth is app-layer event streams.
- Use Presence when user/session state must be converged across clients.
- Use Postgres Changes when source-of-truth is table mutations and consumers need row-change events.

## Operational model

- Channel is the primitive for all three modes.
- Private channels + Realtime Authorization require policies on `realtime.messages`.
- Public/private access can be globally constrained in Realtime Settings.
- Realtime creates and uses dedicated DB pools, replication slots, and `realtime` schema resources.

## Critical constraints

- For Postgres Changes, table must be in publication `supabase_realtime`.
- RLS complexity in Realtime Authorization can increase join latency.
- Realtime setting changes disconnect connected clients.

## Primary upstream docs

- `guides/realtime.md`
- `guides/realtime/concepts.md`
- `guides/realtime/broadcast.md`
- `guides/realtime/presence.md`
- `guides/realtime/postgres-changes.md`
- `guides/realtime/authorization.md`
- `guides/realtime/settings.md`
- `guides/realtime/limits.md`
