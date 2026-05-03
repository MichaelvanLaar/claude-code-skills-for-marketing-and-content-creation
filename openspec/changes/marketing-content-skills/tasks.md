## 1. Repository Foundation

- [x] 1.1 Document the three-level context architecture (company / format / campaign scope) and the hierarchical CLAUDE.md pattern in the project's `CLAUDE.md` or a new `CLAUDE.md` section (FR-007, NFR-012)
- [x] 1.2 Add skill authoring conventions to `CLAUDE.md` so new skills can be created without reviewing existing ones (NFR-012)
- [x] 1.3 Create the skill directory stubs: `onboarding-skill/`, `samples-curation-skill/`, `linkedin-post-skill/`, `session-wrap-skill/` under `.claude/skills/`

## 2. install.sh

- [x] 2.1 Create `install.sh` at repository root with positional skill-name argument parsing and `--all` flag
- [x] 2.2 Add `--target <path>` flag; default to current working directory
- [x] 2.3 Implement skip logic: do not overwrite existing skill folders unless `--update` is passed
- [x] 2.4 Implement installation summary output (installed / updated / already installed — skipped / failed: reason) and non-zero exit on any failure
- [x] 2.5 Ensure `install.sh` does not read or copy files matching `.env`, `.env.*`, or `secrets/` patterns

## 3. onboarding-skill

- [x] 3.1 Write `SKILL.md` frontmatter: name, description (routing key), allowed-tools, argument-hint
- [x] 3.2 Add progressive disclosure `@`-import declarations for any context files the skill itself reads (e.g., existing `company-profile.md` if present)
- [x] 3.3 Implement pre-flight check: detect each target context file before the interview and mark existing ones as "already present — skipped" in the final summary
- [x] 3.4 Implement company interview flow producing `company-profile.md` (company name, products/services, mission, differentiators)
- [x] 3.5 Implement buyer personas interview flow producing `buyer-personas.md`
- [x] 3.6 Implement brand-voice detection: skip `brand-voice.md` if present (n8n integration); offer a basic interview if absent
- [x] 3.7 Implement `storytelling-frameworks.md` creation step (ask owner or skip with TODO)
- [x] 3.8 Implement `.claude/context/README.md` creation: list all files with one-line descriptions and explain the three scope levels; skip if file exists
- [x] 3.9 Implement root `CLAUDE.md` guidance: propose `@`-import entries for all new context files; do not overwrite existing `CLAUDE.md` without confirmation

## 4. samples-curation-skill

- [x] 4.1 Write `SKILL.md` frontmatter: name, description, allowed-tools
- [x] 4.2 Implement content identification step: prompt owner to paste content inline or provide a file path; read file if path given
- [x] 4.3 Implement annotation interview: output type, key qualities, caveats; allow skipping individual fields
- [x] 4.4 Implement preview and explicit confirmation step before any file write (NFR-040)
- [x] 4.5 Implement append to `.claude/context/samples.md`; create file with header if absent; never overwrite existing entries
- [x] 4.6 Implement loop: after each saved entry, ask whether to curate another example

## 5. linkedin-post-skill

- [x] 5.1 Write `SKILL.md` frontmatter: name, description, allowed-tools, argument-hint for optional briefing path
- [x] 5.2 Add progressive disclosure `@`-imports for `brand-voice.md`, `buyer-personas.md`, `company-profile.md`, `samples.md` (optional)
- [x] 5.3 Create `format-guidelines.md` inside the skill folder covering: character limit, hook / body / CTA structure, hashtag conventions, tone calibrations specific to LinkedIn
- [x] 5.4 Implement missing-context notification: before generating output, check each required context file; if absent, name the file, explain its purpose, suggest creation path, then either halt or label output as degraded
- [x] 5.5 Implement campaign briefing detection: look for `brief.md` in current working directory, or accept a path argument; note absence and proceed without it if not found
- [x] 5.6 Implement post generation combining company context, format guidelines, and optional briefing
- [x] 5.7 Implement feedback step: prompt owner after output; if correction given, append `[linkedin-post-skill] <correction> — <YYYY-MM-DD>` to `.claude/learnings.md`

## 6. session-wrap-skill

- [x] 6.1 Write `SKILL.md` frontmatter: name, description, allowed-tools
- [x] 6.2 Implement session summary: run `git status`, list modified/untracked files grouped by type (context, deliverables, skill files, other)
- [x] 6.3 Implement per-skill feedback loop: ask which output-format skills were used, prompt for corrections on each
- [x] 6.4 Implement learnings append: for each correction, write `[<skill-name>] <correction> — <YYYY-MM-DD>` to `.claude/learnings.md`
- [x] 6.5 Implement recurring pattern detection: read `.claude/learnings.md`, group entries by skill tag, surface any tag with 3+ semantically similar entries
- [x] 6.6 Implement promotion flow: for each surfaced pattern, offer to add a rule to the skill's format guidelines, add to `CLAUDE.md`, or dismiss
- [x] 6.7 Implement commit step: stage files explicitly (not `git add -A`), propose a Conventional Commits + gitmoji message, show to owner, commit after confirmation

## 7. Quality & Verification

- [x] 7.1 Verify all `SKILL.md` files have complete frontmatter (name, description, allowed-tools) and no absolute filesystem paths
- [x] 7.2 Verify every skill declares its context file dependencies via `@`-imports in the SKILL.md (FR-010)
- [x] 7.3 Verify no skill folder contains a copy of content that belongs in `.claude/context/` (FR-012)
- [x] 7.4 Verify `install.sh` exits with non-zero on failure and does not touch `.env` or `secrets/` patterns
- [x] 7.5 Update the Key Config Files table in `CLAUDE.md` to include the four new skill directories
