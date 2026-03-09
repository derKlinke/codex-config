# Edge Functions

## Execution model

- Runtime: Supabase Edge Runtime (Deno-compatible, TypeScript-first).
- Request path: gateway/relay -> auth/policy handling -> edge runtime execution -> response + logs/metrics.
- Deployment: globally distributed by Supabase edge network.

## Use cases

- Webhooks, signed callbacks, third-party integrations.
- Low-latency authenticated endpoints.
- Lightweight orchestration (e.g., storage/auth/db + external APIs).
- Background offloading patterns where request path must stay short.

## Local-to-prod workflow

1. `supabase init`
2. `supabase functions new <name>`
3. `supabase start` + `supabase functions serve <name>`
4. Test locally via `http://localhost:54321/functions/v1/<name>`
5. `supabase link --project-ref <project_ref>`
6. `supabase functions deploy [name]`

## Security and correctness notes

- JWT verification enabled by default on deployment.
- `--no-verify-jwt` only for explicit public/webhook flows with compensating controls.
- Keep functions idempotent and short-lived; account for cold starts.
- Keep secrets in project secrets; do not hardcode.

## Primary upstream docs

- `guides/functions.md`
- `guides/functions/quickstart.md`
- `guides/functions/deploy.md`
- `guides/functions/auth.md`
- `guides/functions/error-handling.md`
- `guides/functions/logging.md`
- `guides/functions/background-tasks.md`
- `guides/functions/function-configuration.md`
