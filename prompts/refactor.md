---
description: Refactor and simplify code with DRY/KISS focus, scoped to unstaged changes, branch diff vs main, or highest-value codebase targets
---

Refactor and simplify this codebase with a strong DRY + KISS bias.

Scope selection:
1. If there are unstaged changes, refactor only the unstaged code.
2. Else, if the current branch differs from `main`, refactor only the diff against `main`.
3. Else, inspect the broader codebase and choose the highest-value refactor targets.

Primary goals:
- Reduce unnecessary complexity.
- Make code easier to read, reason about, and maintain.
- Write extremely easy-to-consume code; optimize for readability first.
- Make the code skimmable.
- Prefer explicit, straightforward control flow over cleverness.
- Remove duplication and converge similar behavior onto shared implementations.
- Improve API clarity, consistency, and ergonomics.
- Make code safer by simplifying state flow, making invariants clearer, and reducing hidden behavior.
- Remove hacks, odd fallbacks, compatibility glue, speculative branches, and overcautious error handling unless concrete evidence shows they are required.
- Engineer code to the right level: neither over-engineered nor under-engineered.

Refactoring principles:
- DRY: eliminate repeated logic, repeated branching patterns, repeated data-shaping, repeated UI/component structure, and duplicated validation where the similarity is real and durable.
- KISS: prefer the simplest design that fully solves the problem.
- Prefer one canonical path over multiple subtly different paths.
- Prefer clear invariants, direct data flow, and obvious ownership.
- Prefer early returns over nested conditionals when behavior is unchanged.
- Prefer composition and small focused helpers over tangled conditionals.
- Extract shared helpers, classes, hooks, utilities, or components only when the abstraction is meaningful, stable, and improves clarity.
- Do not over-abstract. Avoid generic frameworks, indirection layers, or configurability that are not justified by real reuse.
- Where code looks or behaves nearly the same, unify it so future changes stay consistent.
- Collapse special cases that do not need to exist.
- Remove dead code, obsolete branches, unused parameters, stale comments, and redundant types/interfaces where safe.
- Tighten naming so responsibilities and behavior are obvious.
- Keep module boundaries clean and put logic in the right layer.
- Favor narrow state surfaces and local reasoning.
- Replace broad defensive code with stronger contracts and clearer assumptions when those assumptions are valid.
- Fail fast rather than silently recovering from impossible or unsupported states.
- Preserve behavior unless a change is clearly a bug fix or a justified cleanup.

Engineering standards:
- Prefer deleting code over adding code when deletion improves clarity.
- Prefer fewer concepts, fewer paths, fewer moving parts, and fewer hidden rules.
- Keep abstractions proportional to actual complexity.
- Enforce consistency in naming, structure, and error semantics inside the touched scope.
- Fix root causes rather than masking symptoms.
- Avoid premature abstraction and speculative future-proofing.
- Avoid legacy fallbacks, migration shims, compact adapters, dual behavior, and compatibility bridges unless explicitly required.
- Improve locality: related logic should live together; unrelated concerns should be separated.
- Favor deterministic behavior and explicit state transitions.
- Reduce boolean/control-flag complexity where possible.
- When duplication is semantically the same or should intentionally become the same, extract shared code so future edits stay aligned.

Quality bar:
- The result should feel calmer, smaller, and more coherent.
- APIs should become more predictable and easier to use correctly.
- Similar inputs should flow through similar code paths.
- Error handling should be intentional, proportionate, and easy to follow.
- Abstractions should earn their existence.
- The code should read like it was designed on purpose, not accumulated by accident.

Guardrails:
- Do not remove functionality without explicit justification.
- Do not introduce compatibility shims, migration glue, dual paths, or fallback chains unless explicitly required.
- Do not mask root causes.
- Do not add speculative abstractions for hypothetical future use.
- Do not preserve awkward patterns just because they already exist.
- Keep diffs as small as possible while still solving the underlying design issue.
- If touched code contains nearby low-risk cleanup opportunities, include them when they materially improve the area.
- Keep comments minimal and focused on why, not what.
- Add or update tests when behavior, bugs, or important control flow are affected.

Execution:
1. Determine scope using the rules above and state which scope was chosen.
2. Identify the main sources of duplication, complexity, weak abstraction boundaries, and unnecessary defensive code.
3. Prioritize changes that simplify the mental model, not just line count.
4. Implement the refactor directly.
5. Briefly explain the key simplifications, what duplication was removed, what abstractions were introduced or removed, and any behavior-preservation assumptions.
6. Call out any larger cleanup that should be handled separately.
