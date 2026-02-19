---
name: engineering-review-framework
description: Structured pre-implementation engineering review for code writing, implementation planning, and architecture decisions. Use when drafting or reviewing plans before code changes, or when the user asks for rigorous analysis of architecture, code quality, testing, and performance with explicit tradeoffs, opinionated recommendations, and user checkpoints.
---

# Engineering Review Framework

## Purpose

Use this framework to review plans before implementation. Keep the process interactive, explicit, and opinionated.

## Preference Defaults

Apply these priorities unless the user overrides them:

1. Flag DRY violations aggressively.
2. Treat strong test coverage as non-negotiable.
3. Aim for "engineered enough" solutions (avoid fragile hacks and premature abstraction).
4. Bias toward thoughtful edge-case handling.
5. Prefer explicit code and reasoning over clever shortcuts.

## Review Workflow

Follow this sequence and pause for user feedback after each section:

1. Architecture review
2. Code quality review
3. Test review
4. Performance review

Use up to 4 highest-impact issues per section unless the user asks for broader coverage.

Do not include review-mode menus or "BIG CHANGE/SMALL CHANGE" gating. Go straight into the methodology.

## Section Requirements

### 1) Architecture Review

Evaluate:

- Overall system design and component boundaries
- Dependency graph and coupling concerns
- Data flow patterns and bottlenecks
- Scaling characteristics and single points of failure
- Security architecture (auth, data access, API boundaries)

### 2) Code Quality Review

Evaluate:

- Code organization and module structure
- DRY violations
- Error handling patterns and missing edge cases
- Technical debt hotspots
- Over-engineering and under-engineering relative to user preferences

### 3) Test Review

Evaluate:

- Coverage gaps (unit, integration, e2e)
- Test quality and assertion strength
- Missing edge-case coverage
- Untested failure modes and error paths

### 4) Performance Review

Evaluate:

- N+1 queries and database access patterns
- Memory usage concerns
- Caching opportunities
- Slow or high-complexity code paths

## Per-Issue Output Format

For every issue:

1. Label the issue with a number (`Issue 1`, `Issue 2`, ...).
2. Describe the problem concretely with file and line references when available.
3. Provide 2-3 options labeled with letters (`A`, `B`, `C`), including "do nothing" when reasonable.
4. For each option, include:
    - Implementation effort
    - Risk level
    - Impact on other code
    - Maintenance burden
5. Put the recommended option first.
6. Explain why the recommendation best matches the user's preferences.
7. End with an explicit confirmation question before proceeding.

Use clear cross-references so option labels map to issue numbers (example: `Issue 2 - Option A`).

## Interaction Rules

1. Do not assume direction without user confirmation.
2. After each review section, ask whether to continue to the next section.
3. If no issues are found in a section, state that explicitly and call out residual risk/testing uncertainty.
4. Keep findings concrete and ranked by severity within each section.
