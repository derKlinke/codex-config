# Storage

## Bucket taxonomy

- Files buckets: general media/file hosting with CDN and transforms.
- Analytics buckets: analytical/table-format workloads (Iceberg-oriented).
- Vector buckets: embedding/vector use cases and similarity search.

## Design choices

- Select bucket type from query/access pattern, not object type alone.
- Apply RLS and signed/public access intentionally per bucket.
- Plan upload path: direct, resumable (TUS), or S3-compatible ingestion.

## Operational concerns

- Serving strategy: CDN behavior, cache policy, transformations.
- Security strategy: policy-first; avoid broad public exposure by default.
- Debugging: storage logs/error codes in storage debugging docs.

## Primary upstream docs

- `guides/storage.md`
- `guides/storage/quickstart.md`
- `guides/storage/security/access-control.md`
- `guides/storage/uploads/resumable-uploads.md`
- `guides/storage/serving/downloads.md`
- `guides/storage/cdn/smart-cdn.md`
- `guides/storage/debugging/error-codes.md`
