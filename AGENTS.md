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
- Strong default: assign subagents for research tasks and code exploration before implementation.
- Parent-agent responsibilities: decomposition, acceptance criteria, integration, final verification.
- Child-agent prompt must specify: file ownership, done condition, required test command, expected output artifact.
- Recursive delegation allowed: child may spawn child when complexity warrants; keep protocol invariant.
- Depth bound: default `d_max = 2`; raise to `d_max = 3` only for large refactor/research spikes.
- Iterative loop: `plan -> assign -> execute -> verify -> review -> reassign`.
- Evidence gate each loop: repro (if bug) -> failing test -> fix -> passing test -> reviewer findings cleared.
- Merge safety: single-writer per file per loop; resolve conflicts before next loop.
- Completion gate: when implementation done, run review with 2 fresh-eye subagents; fix all findings; rerun 2-subagent review; repeat until no issues found.
- Escalation: `--dangerously-bypass-approvals-and-sandbox` only in externally sandboxed environments.

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
- `agent-browser` — Automates browser interactions for web testing, form filling, screenshots, and data extraction. Use when the user needs to navigate websites, interact with web pages, fill forms, take screenshots, test web applications, or extract information from web pages.
- `algorithmic-art` — Creating algorithmic art using p5.js with seeded randomness and interactive parameter exploration. Use this when users request creating art using code, generative art, algorithmic art, flow fields, or particle systems. Create original algorithmic art rather than copying existing artists' work to avoid copyright violations.
- `api-design-principles` — Master REST and GraphQL API design principles to build intuitive, scalable, and maintainable APIs that delight developers. Use when designing new APIs, reviewing API specifications, or establishing API design standards.
- `architecture-patterns` — Implement proven backend architecture patterns including Clean Architecture, Hexagonal Architecture, and Domain-Driven Design. Use when architecting complex backend systems or refactoring existing applications for better maintainability.
- `atlas` — macOS-only AppleScript control for the ChatGPT Atlas desktop app. Use only when the user explicitly asks to control Atlas tabs/bookmarks/history on macOS and the "ChatGPT Atlas" app is installed; do not trigger for general browser tasks or non-macOS environments.
- `aws-cdk-development` — AWS Cloud Development Kit (CDK) expert for building cloud infrastructure with TypeScript/Python. Use when creating CDK stacks, defining CDK constructs, implementing infrastructure as code, or when the user mentions CDK, CloudFormation, IaC, cdk synth, cdk deploy, or wants to define AWS infrastructure programmatically. Covers CDK app structure, construct patterns, stack composition, and deployment workflows.
- `aws-solution-architect` — Design AWS architectures for startups using serverless patterns and IaC templates. Use when asked to design serverless architecture, create CloudFormation templates, optimize AWS costs, set up CI/CD pipelines, or migrate to AWS. Covers Lambda, API Gateway, DynamoDB, ECS, Aurora, and cost optimization.
- `build-things` — Generate a Codex Super Bowl merch redemption URL (tokenized) and open it. Use when a user asks to redeem Super Bowl/Codex merch, needs a redemption token, or wants the merch redemption link.
- `cloudflare-deploy` — Deploy applications and infrastructure to Cloudflare using Workers, Pages, and related platform services. Use when the user asks to deploy, host, publish, or set up a project on Cloudflare.
- `commit-conventions` — Create conventional commit messages and plan commits. Use when a user asks to commit changes, write commit messages, or organize commits. Enforce repo-specific git/commit rules from AGENTS.md and split multiple logical changes into separate, digestible commits.
- `copy-editing` — When the user wants to edit, review, or improve existing marketing copy. Also use when the user mentions 'edit this copy,' 'review my copy,' 'copy feedback,' 'proofread,' 'polish this,' 'make this better,' or 'copy sweep.' This skill provides a systematic approach to editing marketing copy through multiple focused passes.
- `copywriting` — When the user wants to write, rewrite, or improve marketing copy for any page — including homepage, landing pages, pricing pages, feature pages, about pages, or product pages. Also use when the user says "write copy for," "improve this copy," "rewrite this page," "marketing copy," "headline help," or "CTA copy." For email copy, see email-sequence. For popup copy, see popup-cro.
- `data-storytelling` — Transform data into compelling narratives using visualization, context, and persuasive structure. Use when presenting analytics to stakeholders, creating data reports, or building executive presentations.
- `deployment-pipeline-design` — Design multi-stage CI/CD pipelines with approval gates, security checks, and deployment orchestration. Use when architecting deployment workflows, setting up continuous delivery, or implementing GitOps practices.
- `design-system-doc` — Maintain and enforce a repo-root DESIGN.md as living, platform-agnostic design system documentation. Use for UI/design implementation or review tasks across web and Apple platforms (iOS/macOS) to keep tokens, component rules, and design decisions consistent.
- `emotional-design-norman` — Apply Don Norman's Emotional Design framework (visceral, behavioral, reflective) for UX/UI critique, product concepting, and experience polish. Use when asked to make products feel delightful, engaging, meaningful, or to balance aesthetics with usability; or when emotional design / visceral / behavioral / reflective is mentioned.
- `figma` — Use the Figma MCP server to fetch design context, screenshots, variables, and assets from Figma, and to translate Figma nodes into production code. Trigger when a task involves Figma URLs, node IDs, design-to-code implementation, or Figma MCP setup and troubleshooting.
- `figma-implement-design` — Translate Figma nodes into production-ready code with 1:1 visual fidelity using the Figma MCP workflow (design context, screenshots, assets, and project-convention translation). Trigger when the user provides Figma URLs or node IDs, or asks to implement designs or components that must match Figma specs. Requires a working Figma MCP server connection.
- `form-cro` — When the user wants to optimize any form that is NOT signup/registration — including lead capture forms, contact forms, demo request forms, application forms, survey forms, or checkout forms. Also use when the user mentions "form optimization," "lead form conversions," "form friction," "form fields," "form completion rate," or "contact form." For signup/registration forms, see signup-flow-cro. For popups containing forms, see popup-cro.
- `frontend-design` — Create distinctive, production-grade frontend interfaces with high design quality. Use this skill when the user asks to build web components, pages, or applications. Generates creative, polished code that avoids generic AI aesthetics.
- `gh-fix-ci` — Use when a user asks to debug or fix failing GitHub PR checks that run in GitHub Actions; use `gh` to inspect checks and logs, summarize failure context, draft a fix plan, and implement only after explicit approval. Treat external providers (for example Buildkite) as out of scope and report only the details URL.
- `imagegen` — Use when the user asks to generate or edit images via the OpenAI Image API (for example: generate image, edit/inpaint/mask, background removal or replacement, transparent background, product shots, concept art, covers, or batch variants); run the bundled CLI (`scripts/image_gen.py`) and require `OPENAI_API_KEY` for live calls.
- `interface-design` — This skill is for interface design — dashboards, admin panels, apps, tools, and interactive products. NOT for marketing design (landing pages, marketing sites, campaigns).
- `ios-avfoundation-ref` — Reference — AVFoundation audio APIs, AVAudioSession categories/modes, AVAudioEngine pipelines, bit-perfect DAC output, iOS 26+ spatial audio capture, ASAF/APAC, Audio Mix with Cinematic framework
- `ios-background-processing` — Use when implementing BGTaskScheduler, debugging background tasks that never run, understanding why tasks terminate early, or testing background execution - systematic task lifecycle management with proper registration, expiration handling, and Swift 6 cancellation patterns
- `ios-camera-capture` — AVCaptureSession, camera preview, photo capture, video recording, RotationCoordinator, session interruptions, deferred processing, capture responsiveness, zero-shutter-lag, photoQualityPrioritization, front camera mirroring
- `ios-cloud-sync` — Use when choosing between CloudKit vs iCloud Drive, implementing reliable sync, handling offline-first patterns, or designing sync architecture - prevents common sync mistakes that cause data loss
- `ios-core-location` — Use for Core Location implementation patterns - authorization strategy, monitoring strategy, accuracy selection, background location
- `ios-deep-link-debugging` — Use when adding debug-only deep links for testing, enabling simulator navigation to specific screens, or integrating with automated testing workflows - enables closed-loop debugging without production deep link implementation
- `ios-energy` — Use when app drains battery, device gets hot, users report energy issues, or auditing power consumption - systematic Power Profiler diagnosis, subsystem identification (CPU/GPU/Network/Location/Display), anti-pattern fixes for iOS/iPadOS
- `ios-haptics` — Use when implementing haptic feedback, Core Haptics patterns, audio-haptic synchronization, or debugging haptic issues - covers UIFeedbackGenerator, CHHapticEngine, AHAP patterns, and Apple's Causality-Harmony-Utility design principles from WWDC 2021
- `ios-hig` — Use when making design decisions, reviewing UI for HIG compliance, choosing colors/backgrounds/typography, or defending design choices - quick decision frameworks and checklists for Apple Human Interface Guidelines
- `ios-networking` — Use when implementing Network.framework connections, debugging connection failures, migrating from sockets/URLSession streams, or adopting structured concurrency networking patterns - prevents deprecated API usage, reachability anti-patterns, and thread-safety violations with iOS 12-26+ APIs
- `ios-photo-library` — PHPicker, PhotosPicker, photo selection, limited library access, presentLimitedLibraryPicker, save to camera roll, PHPhotoLibrary, PHAssetCreationRequest, Transferable, PhotosPickerItem, photo permissions
- `ios-privacy-ux` — Use when implementing privacy manifests, requesting permissions, App Tracking Transparency UX, or preparing Privacy Nutrition Labels - covers just-in-time permission requests, tracking domain management, and Required Reason APIs from WWDC 2023
- `ios-storekit-ref` — Reference — Complete StoreKit 2 API guide covering Product, Transaction, AppTransaction, RenewalInfo, SubscriptionStatus, StoreKit Views, purchase options, server APIs, and all iOS 18.4 enhancements with WWDC 2025 code examples
- `ios-swift-concurrency-expert` — Swift Concurrency review and remediation for Swift 6.2+. Use when asked to review Swift Concurrency usage, improve concurrency compliance, or fix Swift concurrency compiler errors in a feature or file.
- `ios-swift-performance` — Use when optimizing Swift code performance, reducing memory usage, improving runtime efficiency, dealing with COW, ARC overhead, generics specialization, or collection optimization
- `ios-swift-testing` — Use when writing unit tests, adopting Swift Testing framework, making tests run faster without simulator, architecting code for testability, testing async code reliably, or migrating from XCTest - covers @Test/@Suite macros,
- `ios-swiftdata` — Use when working with SwiftData - @Model definitions, @Query in SwiftUI, @Relationship macros, ModelContext patterns, CloudKit integration, iOS 26+ features, and Swift 6 concurrency with @MainActor — Apple's native persistence framework
- `ios-swiftui-26-ref` — Use when implementing iOS 26 SwiftUI features - covers Liquid Glass design system, performance improvements, @Animatable macro, 3D spatial layout, scene bridging, WebView/WebPage, AttributedString rich text editing, drag and drop enhancements, and visionOS integration for iOS 26+
- `ios-swiftui-animation-ref` — Use when implementing SwiftUI animations, understanding VectorArithmetic, using @Animatable macro, zoom transitions, UIKit/AppKit animation bridging, choosing between spring and timing curve animations, or debugging animation behavior - comprehensive animation reference from iOS 13 through iOS 26
- `ios-swiftui-gestures` — Use when implementing SwiftUI gestures (tap, drag, long press, magnification, rotation), composing gestures, managing gesture state, or debugging gesture conflicts - comprehensive patterns for gesture recognition, composition, accessibility, and cross-platform support
- `ios-swiftui-liquid-glass` — Implement, review, or improve SwiftUI features using the iOS 26+ Liquid Glass API. Use when asked to adopt Liquid Glass in new SwiftUI UI, refactor an existing feature to Liquid Glass, or review Liquid Glass usage for correctness, performance, and design alignment.
- `ios-swiftui-nav` — Use when implementing navigation patterns, choosing between NavigationStack and NavigationSplitView, handling deep links, adopting coordinator patterns, or requesting code review of navigation implementation - prevents navigation state corruption, deep link failures, and state restoration bugs for iOS 18+
- `ios-swiftui-performance` — Use when UI is slow, scrolling lags, animations stutter, or when asking 'why is my SwiftUI view slow', 'how do I optimize List performance', 'my app drops frames', 'view body is called too often', 'List is laggy' - SwiftUI performance optimization with Instruments 26 and WWDC 2025 patterns
- `ios-swiftui-view-refactor` — Refactor and review SwiftUI view files for consistent structure, dependency injection, and Observation usage. Use when asked to clean up a SwiftUI view’s layout/ordering, handle view models safely (non-optional when possible), or standardize how dependencies and @Observable state are initialized and passed.
- `ios-synchronization` — Use when needing thread-safe primitives for performance-critical code. Covers Mutex (iOS 18+), OSAllocatedUnfairLock (iOS 16+), Atomic types, when to use locks vs actors, deadlock prevention with Swift Concurrency.
- `ios-textkit-ref` — TextKit 2 complete reference (architecture, migration, Writing Tools, SwiftUI TextEditor) through iOS 26
- `ios-typography-ref` — Apple platform typography reference (San Francisco fonts, text styles, Dynamic Type, tracking, leading, internationalization) through iOS 26
- `ios-ui-testing` — Use when writing UI tests, recording interactions, tests have race conditions, timing dependencies, inconsistent pass/fail behavior, or XCTest UI tests are flaky - covers Recording UI Automation (WWDC 2025), condition-based waiting, network conditioning, multi-factor testing, crash debugging, and accessibility-first testing patterns
- `ios-ux-design` — Activate this skill when analyzing iOS app UI/UX, evaluating iOS design patterns, proposing iOS interface improvements, or creating iOS implementation specifications. Provides deep expertise in Apple Human Interface Guidelines, SwiftUI patterns, native iOS components, accessibility standards, and iOS-specific interaction paradigms.
- `jupyter-notebook` — Use when the user asks to create, scaffold, or edit Jupyter notebooks (`.ipynb`) for experiments, explorations, or tutorials; prefer the bundled templates and run the helper script `new_notebook.py` to generate a clean starting notebook.
- `justfile-authoring` — Create, edit, or review justfiles for the just command runner. Use when adding or modifying recipes, parameters, dependencies, settings, attributes, aliases, or shebang scripts; fixing invocation or working-directory behavior; or documenting tasks for `just --list` output.
- `linear` — Manage issues, projects & team workflows in Linear. Use when the user wants to read, create or updates tickets in Linear.
- `marketing-psychology` — When the user wants to apply psychological principles, mental models, or behavioral science to marketing. Also use when the user mentions 'psychology,' 'mental models,' 'cognitive bias,' 'persuasion,' 'behavioral science,' 'why people buy,' 'decision-making,' or 'consumer behavior.' This skill provides 70+ mental models organized for marketing application.
- `microservices-patterns` — Design microservices architectures with service boundaries, event-driven communication, and resilience patterns. Use when building distributed systems, decomposing monoliths, or implementing microservices.
- `motion` — Use when adding animations with Motion Vue (motion-v) - provides motion component API, gesture animations, scroll-linked effects, layout transitions, and composables for Vue 3/Nuxt
- `next-best-practices` — Next.js best practices - file conventions, RSC boundaries, data patterns, async APIs, metadata, error handling, route handlers, image/font optimization, bundling
- `notes-knowledge-graph` — Create, revise, and curate Markdown notes as an Obsidian-style knowledge graph, including wikilinks, citations, math, and explanatory visuals. Use `matplotlib` for quantitative graphs and PlantUML for conceptual/system diagrams when visuals are needed. Trigger on note taking, note maintenance, research notes, content/notes/, Obsidian, knowledge graph, concept pages, literature summaries, or durable knowledge capture from coding/research work.
- `pdf` — Use when tasks involve reading, creating, or reviewing PDF files where rendering and layout matter; prefer visual checks by rendering pages (Poppler) and use Python tools such as `reportlab`, `pdfplumber`, and `pypdf` for generation and extraction.
- `plantuml-graphs` — Create and edit PlantUML diagrams and render them to PNG files using the PlantUML CLI. Use when users ask for UML or system diagrams in `.puml` format and want CLI-exported PNG outputs.
- `security-best-practices` — Perform language and framework specific security best-practice reviews and suggest improvements. Trigger only when the user explicitly requests security best practices guidance, a security review/report, or secure-by-default coding help. Trigger only for supported languages (python, javascript/typescript, go). Do not trigger for general code review, debugging, or non-security tasks.
- `security-threat-model` — Repository-grounded threat modeling that enumerates trust boundaries, assets, attacker capabilities, abuse paths, and mitigations, and writes a concise Markdown threat model. Trigger only when the user explicitly asks to threat model a codebase or path, enumerate threats/abuse paths, or perform AppSec threat modeling. Do not trigger for general architecture summaries, code review, or non-security design work.
- `sentry` — Use when the user asks to inspect Sentry issues or events, summarize recent production errors, or pull basic Sentry health data via the Sentry API; perform read-only queries with the bundled script and require `SENTRY_AUTH_TOKEN`.
- `seo-audit` — When the user wants to audit, review, or diagnose SEO issues on their site. Also use when the user mentions "SEO audit," "technical SEO," "why am I not ranking," "SEO issues," "on-page SEO," "meta tags review," or "SEO health check." For building pages at scale to target keywords, see programmatic-seo. For adding structured data, see schema-markup.
- `sora` — Use when the user asks to generate, remix, poll, list, download, or delete Sora videos via OpenAI’s video API using the bundled CLI (`scripts/sora.py`), including requests like “generate AI video,” “Sora,” “video remix,” “download video/thumbnail/spritesheet,” and batch video generation; requires `OPENAI_API_KEY` and Sora API access.
- `spreadsheet` — Use when tasks involve creating, editing, analyzing, or formatting spreadsheets (`.xlsx`, `.csv`, `.tsv`) using Python (`openpyxl`, `pandas`), especially when formulas, references, and formatting need to be preserved and verified.
- `supabase-postgres-best-practices` — Postgres performance optimization and best practices from Supabase. Use this skill when writing, reviewing, or optimizing Postgres queries, schema designs, or database configurations.
- `swiftui-expert-skill` — Write, review, or improve SwiftUI code following best practices for state management, view composition, performance, modern APIs, Swift concurrency, and iOS 26+ Liquid Glass adoption. Use when building new SwiftUI features, refactoring existing views, reviewing code quality, or adopting modern SwiftUI patterns.
- `terraform-module-library` — Build reusable Terraform modules for AWS, Azure, and GCP infrastructure following infrastructure-as-code best practices. Use when creating infrastructure modules, standardizing cloud provisioning, or implementing reusable IaC components.
- `transcribe` — Transcribe audio files to text with optional diarization and known-speaker hints. Use when a user asks to transcribe speech from audio/video, extract text from recordings, or label speakers in interviews or meetings.
- `tuist-best-practices` — Best practices for Tuist manifests, ProjectDescriptionHelpers, caching, and iOS project workflows.
- `ui-ux-pro-max` — UI/UX design intelligence. 50 styles, 21 palettes, 50 font pairings, 20 charts, 9 stacks (React, Next.js, Vue, Svelte, SwiftUI, React Native, Flutter, Tailwind, shadcn/ui). Actions: plan, build, create, design, implement, review, fix, improve, optimize, enhance, refactor, check UI/UX code. Projects: website, landing page, dashboard, admin panel, e-commerce, SaaS, portfolio, blog, mobile app, .html, .tsx, .vue, .svelte. Elements: button, modal, navbar, sidebar, card, table, form, chart. Styles: glassmorphism, claymorphism, minimalism, brutalism, neumorphism, bento grid, dark mode, responsive, skeuomorphism, flat design. Topics: color palette, accessibility, animation, layout, typography, font pairing, spacing, hover, shadow, gradient. Integrations: shadcn/ui MCP for component search and examples.
- `vercel-composition-patterns` — React composition patterns that scale. Use when refactoring components with boolean prop proliferation, building flexible component libraries, or designing reusable APIs. Triggers on tasks involving compound components, render props, context providers, or component architecture. Includes React 19 API changes.
- `vercel-deploy` — Deploy applications and websites to Vercel. Use this skill when the user requests deployment actions such as "Deploy my app", "Deploy this to production", "Create a preview deployment", "Deploy and give me the link", or "Push this live". No authentication required - returns preview URL and claimable deployment link.
- `vercel-react-best-practices` — React and Next.js performance optimization guidelines from Vercel Engineering. This skill should be used when writing, reviewing, or refactoring React/Next.js code to ensure optimal performance patterns. Triggers on tasks involving React components, Next.js pages, data fetching, bundle optimization, or performance improvements.
- `web-design-guidelines` — Review UI code for Web Interface Guidelines compliance. Use when asked to "review my UI", "check accessibility", "audit design", "review UX", or "check my site against best practices".
- `yeet` — Use only when the user explicitly asks to stage, commit, push, and open a GitHub pull request in one flow using the GitHub CLI (`gh`).
