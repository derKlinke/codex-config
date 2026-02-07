# memory.md

Cross-project memory ledger. Durable findings only.

## 2026-02-07
- Memory policy updated.
- `~/.codex/AGENTS.md`: protocol + stable preferences.
- `~/.codex/memory.md`: cross-project findings (bugs, language patterns, workflows, tool preferences).
- Project-specific memory stays in each repo (`AGENTS.md` + local memory markdowns).
- Long-term research notes live in Obsidian vault: `/Users/fabianklinke/Developer/klinke/klinke.studio/content/notes`.
- For research/design insights worth long-term retention: add note in vault using existing style (wiki-links, LaTeX math where useful, images when useful).
- Priority raised: research tasks should proactively consult notes vault first (targeted scan), then external sources if needed.
- Write-back expectation: durable research outputs should be captured in vault notes.
- Screen Time API boundary reliability: `DeviceActivitySchedule` callbacks are boundary-driven but not real-time; use monitor-extension callbacks as source of truth; enforce schedulable window `>= 15 min`; use `BGAppRefreshTask` as reconciliation watchdog; track boundary jitter via `Δt = t_actual - t_expected`.
