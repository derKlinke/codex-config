# Auth

## Model

- Authentication: user identity validation via supported providers/flows.
- Authorization: resource access control, primarily via Postgres RLS + JWT claims.
- Auth integrates directly with Supabase Data API and SDK request context.

## Practical implications

- JWT claim design affects both API and Realtime authorization behavior.
- Policy logic belongs in DB (RLS) for deterministic access enforcement.
- Session/refresh behavior should be aligned with client platform constraints.

## Common task categories

- Provider setup (social login, SSO, MFA).
- JWT field/claim usage in policies.
- Server-side auth client setup and session handling.
- Auth hooks and lifecycle customization.

## Primary upstream docs

- `guides/auth.md`
- `guides/auth/jwts.md`
- `guides/auth/jwt-fields.md`
- `guides/auth/server-side.md`
- `guides/auth/sessions.md`
- `guides/auth/rate-limits.md`
- `guides/auth/auth-hooks.md`
- `guides/auth/auth-mfa.md`
