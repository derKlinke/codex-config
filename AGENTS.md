# AGENTS.MD
My name is Fabian S. Klinke. I have a masters in Audio Technology and have a couple of years of experience in iOS/macOS development. So be precise and scientific and use proper terminology and mathematical notation where applicable.
Work style: telegraph; noun-phrases ok; drop grammar; min tokens.

## Agent Protocol
- PRs: use `gh pr view/diff` (no URLs).
- “Make a note” => edit AGENTS.md (shortcut; not a blocker). Ignore `CLAUDE.md`.
- AGENTS.md is living memory. Always update any AGENTS.md when repo facts change or new constraints learned.
- Design memory: every project should have a repo-root `DESIGN.md` as living design system documentation (platform-agnostic; web + iOS/macOS where applicable).
- Design workflow: read `DESIGN.md` before any design/UI implementation or review (web + native); update it in the same task whenever design decisions or tokens/components change.
- If `DESIGN.md` is missing in a project with UI/design work, create it from the `design-system-doc` skill template.
- Memory hierarchy:
- `~/.codex/AGENTS.md`: global operating protocol + stable preferences.
- `~/.codex/memory.md`: cross-project memory ledger (bugs, preferred code patterns, workflows, tool choices, reusable findings).
- Project-specific memory: keep in that project’s `AGENTS.md` and local memory markdowns.
- Long-term knowledge/research notes: Obsidian vault at `/Users/fabianklinke/Developer/klinke/klinke.studio/content/notes`; strong default = use proactively.
- If a repo provides root `NOTES.md`, treat it as the fast note lookup index; refresh via that repo’s generator command before major note maintenance.
- Note authoring/maintenance is governed by skill `notes-knowledge-graph` at `/Users/fabianklinke/.codex/skills/notes-knowledge-graph/SKILL.md`.
- Treat that skill as single source of truth for note workflow, style, citations, visuals, language, and transparency footer; do not duplicate those rules in AGENTS files.
- For note edits from outside `klinke.studio`, still read `/Users/fabianklinke/Developer/klinke/klinke.studio/AGENTS.md` for repo-specific constraints.
- When working on Linear issues: set status to In Progress at start.
- Need upstream file: stage in `/tmp/`, then cherry-pick; never overwrite tracked.
- Bug report: first write failing repro test. Then subagents fix; prove via passing test.
- Keep files <~500 LOC; split/refactor as needed.
- Commits: Conventional Commits (`feat|fix|refactor|build|ci|chore|docs|style|perf|test`).
- CI: `gh run list/view` (rerun/fix til green).
- New deps: quick health check (recent releases/commits, adoption).
- Slash cmds: `~/.codex/prompts/`.
- Web: search early; quote exact errors; prefer 2024–2026 sources; fallback Firecrawl / `mcporter`.
- Comments: allow/encourage concise why-comments in hard-to-reason code (DSP/RT/concurrency/math). Avoid what-comments.

## Subagent Orchestration
- Bias: use subagents by default for non-trivial work; parallel lanes = `dev`, `test`, `research`, `review`.
- Parent-agent responsibilities: decomposition, acceptance criteria, integration, final verification.
- Child-agent prompt must specify: file ownership, done condition, required test command, expected output artifact.
- Recursive delegation allowed: child may spawn child when complexity warrants; keep protocol invariant.
- Depth bound: default `d_max = 2`; raise to `d_max = 3` only for large refactor/research spikes.
- Iterative loop: `plan -> assign -> execute -> verify -> review -> reassign`.
- Evidence gate each loop: repro (if bug) -> failing test -> fix -> passing test -> reviewer findings cleared.
- Merge safety: single-writer per file per loop; resolve conflicts before next loop.
- Escalation: `--dangerously-bypass-approvals-and-sandbox` only in externally sandboxed environments.
- Codex CLI orchestrator template:
```bash
codex -C /path/to/repo exec --full-auto \
  "Orchestrator mode. Spawn subagents for dev/test/research/review. Recursive delegation allowed up to depth=2. Require artifacts: patch diff, test logs, risk notes. Run iterative loop until acceptance criteria pass."
```
- Codex CLI focused agents:
```bash
codex -C /path/to/repo exec "Research root cause for <issue>. Return hypotheses, experiments, recommendation."
codex -C /path/to/repo exec "Write failing repro test for <bug>. Stop after red test + command output."
codex -C /path/to/repo exec "Implement minimal fix for <bug>. Run tests. Return diff + rationale."
codex -C /path/to/repo exec review --uncommitted "Prioritize regressions, missing tests, risk."
```

## Flow & Runtime
- Use repo’s package manager/runtime; no swaps w/o approval. Prefer bun.
- New iOS projects: use Tuist.
- Use Codex background for long jobs; tmux only for interactive/persistent (debugger/server).

## Tools
- `peekaboo`: UI automation + screenshots. `peekaboo image` / `capture`; `peekaboo list` / `permissions`.
- `gh`: GitHub CLI. PRs `gh pr view/diff`; Actions `gh run list/view`; issues `gh issue`.
- `tuist`: Xcode project tooling. Prefer `just` if available; else `tuist generate/test/run`.
- `bun`: JS runtime/PM. `bun install/add/remove`, `bun run`, `bun test`, `bunx`.
- `prek`: pre-commit hooks. `prek install`, `prek run`, `prek run -a`, `prek auto-update`.
- `trash`: safe delete to system Trash. `trash <files>`.

## Build / Test
- Formatter bootstrap: always run `npx @derklinke/miedinger --force` to install formatter config, commit hooks, justfiles, workflow dispatch sync.
- Every repo exposes core commands (build, test, generate, format) via justfile.
- CI red: `gh run list/view`, rerun, fix, push, repeat til green.
- When working on webprojects, use agent-browser for inspecting UI, network, console logs.
- Always use bun as runtime for JavaScript/TypeScript projects unless repo specifies otherwise.

## Git
- Safe by default: `git status/diff/log`. Push only when user asks.
- `git checkout` ok for PR review / explicit request.
- Branch changes require user consent.
- Ignore automation runtime logs: `automations/**/memory.md` stays untracked.
- Destructive ops forbidden unless explicit (`reset --hard`, `clean`, `restore`, `rm`, …).
- Remotes under `~/Developer`: prefer HTTPS; flip SSH->HTTPS before pull/push.
- Safe default: `git pull --rebase` before push (assumed ok).
- Don’t delete/rename unexpected stuff; stop + ask.
- Avoid manual `git stash`; if Git auto-stashes during pull/rebase, that’s fine (hint, not hard guardrail).
- If user types a command (“pull and push”), that’s consent for that command.
- Multi-agent: check `git status/diff` before edits; ship small commits.

## Critical Thinking
- Fix root cause (not band-aid).
- Unsure: read more code; if still stuck, ask w/ short options.
- Conflicts: call out; pick safer path.
- Unrecognized changes: assume other agent; keep going; focus your changes. If it causes issues, stop + ask user.
- Unrelated changes: assume Fabian or another Codex instance; ignore unless clearly weird/unintended.
- Leave breadcrumb notes in thread.

## Frontend Aesthetics
Avoid “AI slop” UI. Be opinionated + distinctive.

Do:
- Typography: use system fonts or Helvetica Neue; only use other fonts with strong purpose.
- Theme: commit to a palette; use CSS vars; bold accents > timid gradients.
- Motion: 1–2 high-impact moments (staggered reveal beats random micro-anim).
- Native: use platform native components/styles where possible, only customize purposefully.
- Focus on clarity, hierarchy, whitespace.
- Use emotional design principles.
Avoid: purple-on-white clichés, generic component grids, predictable layouts. Avoid gradients and shadows unless purposeful.

## Skills Index
- `agent-browser` — Browser UI automation + screenshots. Use when navigating/testing web UIs or capturing screenshots.
- `algorithmic-art` — Generative p5.js art with seeded randomness. Use when creating algorithmic or generative art.
- `atlas` — AppleScript control of ChatGPT Atlas app. Use only for Atlas tab/bookmark/history control on macOS.
- `cloudflare-deploy` — Deploy Workers/Pages/apps to Cloudflare. Use when publishing to Cloudflare.
- `commit-conventions` — Conventional commits planning/messages. Use when committing or organizing commits.
- `copy-editing` — Marketing copy editing passes. Use when polishing or proofreading existing copy.
- `copywriting` — Marketing copy writing/rewriting. Use when creating or rewriting product/marketing pages.
- `design-system-doc` — Repo-root `DESIGN.md` governance (platform-agnostic: web + iOS/macOS). Use for UI/design tasks to read/update design tokens, typography, style/vibe, component rules, and decision log.
- `emotional-design-norman` — Emotional design framework (visceral/behavioral/reflective). Use when tuning UX affect.
- `figma` — Figma MCP design context/assets. Use when working with Figma URLs/nodes or design-to-code.
- `figma-implement-design` — 1:1 Figma-to-code implementation. Use when implementing a specific Figma node/spec.
- `frontend-design` — Distinctive, high-quality web UI. Use when building frontend pages/components.
- `gh-fix-ci` — Diagnose GitHub Actions failures. Use when fixing failing PR checks; approval required before changes.
- `imagegen` — OpenAI Image API via CLI. Use when generating/editing images.
- `ios-avfoundation-ref` — AVFoundation audio reference. Use for audio session/engine/spatial capture guidance.
- `ios-background-processing` — BGTaskScheduler patterns. Use for background task scheduling/debugging.
- `ios-camera-capture` — AVCapture camera capture patterns. Use for custom camera/photo/video capture issues.
- `ios-cloud-sync` — CloudKit/iCloud sync architecture. Use for sync design and data-loss prevention.
- `ios-core-location` — Core Location authorization/monitoring. Use for location features and background location.
- `ios-deep-link-debugging` — Debug-only deep links. Use for internal deep link testing workflows.
- `ios-energy` — iOS energy diagnostics. Use when addressing battery/thermal issues.
- `ios-haptics` — Haptics patterns. Use for UIFeedback/Core Haptics/audio-haptic sync.
- `ios-hig` — Apple HIG decision support. Use for design compliance checks.
- `ios-networking` — Network.framework patterns. Use for connection/migration/debugging networking.
- `ios-photo-library` — Photos/PHPicker/PhotosPicker. Use for photo selection and permissions.
- `ios-privacy-ux` — Privacy manifests/ATT UX. Use for permission UX and Required Reason APIs.
- `ios-storekit-ref` — StoreKit 2 reference. Use for IAP/subscription implementations.
- `ios-swift-concurrency-expert` — Swift Concurrency remediation. Use for Swift 6 concurrency errors/reviews.
- `ios-swift-performance` — Swift performance optimization. Use for memory/CPU/COW/ARC tuning.
- `ios-swift-testing` — Swift Testing framework. Use for unit tests/migration from XCTest.
- `ios-swiftdata` — SwiftData patterns. Use for models/queries/CloudKit integration.
- `ios-swiftui-26-ref` — iOS 26 SwiftUI reference. Use for Liquid Glass/3D/scene bridging, etc.
- `ios-swiftui-animation-ref` — SwiftUI animation reference. Use for animation APIs/behavior.
- `ios-swiftui-gestures` — SwiftUI gesture patterns. Use for gesture composition/conflicts.
- `ios-swiftui-liquid-glass` — Liquid Glass implementation. Use when adopting/refactoring to Liquid Glass.
- `ios-swiftui-nav` — SwiftUI navigation patterns. Use for NavigationStack/SplitView/deep links.
- `ios-swiftui-performance` — SwiftUI performance optimization. Use for laggy UI/scrolling issues.
- `ios-swiftui-view-refactor` — SwiftUI view refactor patterns. Use for structure/DI/Observation cleanup.
- `ios-synchronization` — Thread-safe primitives. Use for locks/actors/atomic concurrency choices.
- `ios-textkit-ref` — TextKit 2 reference. Use for text system behavior/migration.
- `ios-typography-ref` — Apple typography reference. Use for text styles/Dynamic Type/metrics.
- `ios-ui-testing` — UI testing patterns. Use for flaky UI tests and XCTest UI.
- `ios-ux-design` — iOS UX design review/specs. Use for iOS UI/UX analysis and improvements.
- `jupyter-notebook` — Jupyter notebook scaffolding. Use when creating/editing `.ipynb`.
- `justfile-authoring` — `just` recipe authoring. Use when editing justfiles.
- `linear` — Linear issue/project management. Use when reading/updating Linear tickets.
- `marketing-psychology` — Behavioral science for marketing. Use when applying mental models to marketing.
- `motion` — Motion Vue animations. Use for motion-v animation work in Vue/Nuxt.
- `notes-knowledge-graph` — Obsidian note workflow. Use for knowledge graph note creation/maintenance.
- `pdf` — PDF read/create/review. Use when PDF layout/rendering matters.
- `plantuml-graphs` — PlantUML diagram creation. Use for UML/system diagrams + PNG render.
- `security-best-practices` — Security best-practice review. Use only on explicit security review requests (py/js/go).
- `security-threat-model` — Threat modeling. Use only when explicitly requested to threat model.
- `sentry` — Sentry API queries. Use for Sentry issues/health summaries.
- `seo-audit` — SEO audits. Use for technical/on-page SEO reviews.
- `sora` — OpenAI video (Sora) via CLI. Use when generating/remixing/downloading Sora videos.
- `spreadsheet` — Spreadsheet editing/analysis. Use for `.xlsx/.csv` with formulas/formatting.
- `supabase-postgres-best-practices` — Supabase Postgres optimization. Use for schema/query perf best practices.
- `transcribe` — Audio transcription. Use when transcribing audio/video with diarization.
- `tuist-best-practices` — Tuist project guidance. Use for Tuist manifest/caching workflows.
- `vercel-deploy` — Vercel deployments. Use when deploying to Vercel.
- `vercel-react-best-practices` — React/Next performance patterns. Use for React/Next optimization work.
- `web-design-guidelines` — Web UI guideline review. Use when auditing UI/accessibility/UX.
- `yeet` — Stage/commit/push/PR via gh. Use only when explicitly asked.
