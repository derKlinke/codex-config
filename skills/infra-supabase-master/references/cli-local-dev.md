# CLI + Local Development

## Baseline lifecycle

1. `supabase init`
2. `supabase start`
3. `supabase status`
4. Develop/test locally
5. `supabase link --project-ref <id>`
6. Deploy relevant assets (functions, migrations, config)

## Environment assumptions

- Local stack runs in Docker-compatible runtime.
- First boot is image-pull heavy.
- Local credentials/URLs are emitted by `supabase start` and `supabase status`.

## CI/CD implications

- CLI supports local stack in CI for integration tests.
- Keep version pinning explicit in CI to avoid drift.
- For upgrades, stop stack and handle local backups/dumps before reset.

## Primary upstream docs

- `guides/local-development/cli/getting-started.md`
- `guides/local-development/cli/testing-and-linting.md`
- `guides/local-development/seeding-your-database.md`
- `guides/local-development/declarative-database-schemas.md`
