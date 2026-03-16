---
name: plan-tdd
description: Use when implementing bug fixes or important behavior that should ship with automated tests
---

# Testing

Use tests for bug fixes and important behavior. Prefer meaningful coverage over blanket TDD.

**Default:** Bug fixes need a reproducer/regression test. Important or risky behavior should ship with focused tests. Small low-risk changes may skip new tests when no meaningful test exists.

**Test-first:** Preferred for bugs, risky behavior, and unclear design. Write a minimal test, ideally see it fail, then implement the minimal fix. Strict red/green for every tiny change is optional.

**Running tests:** Optional in-session. If you do not run them, say so and give the exact command for the next round. Never claim tests pass if you did not run them.

**Good tests:** Exercise real behavior, keep mocks minimal, keep assertions focused, cover edge cases where they matter. If testing feels hard, simplify the design or reduce coupling.

See @testing-anti-patterns.md for mock and test-utility pitfalls.
