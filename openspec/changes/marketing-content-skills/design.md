## Context

This repository provides reusable Claude Code skills for marketing and content creation. The primary user is a solo operator who manages both engineering and marketing projects and already uses `cc-init` / `cc-update` / `cc-optimize` from [MichaelvanLaar/claude-code-config-skills](https://github.com/MichaelvanLaar/claude-code-config-skills). An external n8n workflow may already have produced a `brand-voice.md` in `.claude/context/` before any skill from this repo runs.

The repository currently has `cc-init`, `cc-optimize`, and `cc-update` skills checked in under `.claude/skills/`. Everything else (install script, marketing skills) is new.

## Goals / Non-Goals

**Goals:**

- Define a three-level context architecture (company / format / campaign) that all marketing skills follow
- Design an install mechanism consistent with the cc-init pattern
- Specify how skills declare and load context files via progressive disclosure
- Design a feedback + learnings loop embedded in every output-format skill
- Ensure each skill is independently installable and does not break others

**Non-Goals:**

- Replacing cc-init, cc-optimize, or cc-update functionality
- Auto-publishing content to any platform
- GUI or dashboard tooling
- Multi-user access control
- Duplicating the n8n brand voice extraction workflow

## Decisions

### D-01: SKILL.md is the single instruction file per skill

Each skill lives entirely within `.claude/skills/<skill-name>/SKILL.md`. Format-specific reference material (e.g., LinkedIn post length rules, tone calibration notes) is stored as additional files inside the same skill folder and referenced via `@` imports from the SKILL.md.

**Alternatives considered:**

- Splitting instruction and reference into separate files at the top level — rejected because it breaks the portability contract (NFR-020); removing one skill folder should leave everything else untouched.

### D-02: Three-level context separation enforced by file location

| Level          | Location                                   | Examples                                                    |
| -------------- | ------------------------------------------ | ----------------------------------------------------------- |
| Company scope  | `.claude/context/`                         | `brand-voice.md`, `buyer-personas.md`, `company-profile.md` |
| Format scope   | `.claude/skills/<skill-name>/`             | `format-guidelines.md`, `post-templates.md`                 |
| Campaign scope | Campaign subfolder (e.g., `campaigns/q3/`) | `brief.md`, `key-messages.md`                               |

Skills read company scope and campaign scope at runtime via `@`-imports. Format scope is embedded in the skill folder and loaded with the skill.

**Alternatives considered:**

- Merging format-scope files into `.claude/context/` — rejected because it breaks the independent-install property (NFR-010); a format guideline file in `.claude/context/` cannot be removed without risk of breaking other skills that scan that folder.

### D-03: Progressive disclosure `@`-imports for all context references

Skills declare context files using Claude Code's `@path **Read when:** [trigger]` syntax within the SKILL.md. This defers large file loads until the model actually needs them, reducing baseline token use for sessions that do not invoke the skill.

```markdown
@.claude/context/brand-voice.md **Read when:** producing any written content
@.claude/context/buyer-personas.md **Read when:** targeting content at a specific audience segment
```

**Alternatives considered:**

- Inlining context content directly into SKILL.md — rejected because large reference files (brand voice, storytelling frameworks) would make skills unwieldy and inflate token use for every session.

### D-04: install.sh copies skill folders; no registry or manifest required

`install.sh` is a Bash script at repository root. It accepts a list of skill names (or `--all`) and copies `.claude/skills/<skill-name>/` from this repository into the target project's `.claude/skills/` directory. Target path defaults to the current working directory.

For updates: re-running `install.sh` with `--update` replaces existing skill files. The user is shown which skills were updated, skipped (already present and unchanged), or failed (write error).

**Alternatives considered:**

- A dedicated `marketing-update-skill` SKILL.md — considered, but an update skill cannot easily copy its own files from the source repo without network access at runtime (CON-006). A shell script run by the human before the session is simpler and more reliable.
- A package manager (npm/pip manifest) — overkill for a directory-copy operation; introduces unnecessary dependencies.

### D-05: Feedback step is mandatory in every output-format skill

Every output-format skill ends with an explicit prompt:

> "Did this output meet your expectations? If not, please describe the correction — I'll log it to `.claude/learnings.md`."

On a correction, the skill appends a tagged line to `.claude/learnings.md`:

```
[linkedin-post-skill] <correction summary> — <date>
```

This is defined in the skills themselves, not in shared infrastructure. Each skill owns its feedback step to stay self-contained (FR-021).

### D-06: Onboarding skill skips existing context files by default

Before creating any context file, the onboarding skill checks whether that file already exists in `.claude/context/`. If it does, the file is listed as "already present — skipped" in the summary. The owner can request regeneration explicitly.

This directly supports integration with the n8n brand voice pipeline (CON-003, FR-004).

### D-07: Session-wrap skill surfaces recurring learnings from `.claude/learnings.md`

The session-wrap skill reads `.claude/learnings.md`, groups entries by skill tag, and surfaces any skill where three or more entries share similar corrections. It asks the owner whether to promote the pattern into that skill's format guidelines or into `CLAUDE.md`.

The "similarity" check is performed by Claude (semantic grouping), not by exact string match.

## Risks / Trade-offs

- **`@`-import syntax changes** → Skills fail to load context silently. Mitigation: each skill's first action is to verify at least one context file loaded; if not, it notifies the owner.
- **Missing context files** → All skills handle this with an explicit notification (FR-011). Output-format skills proceed with degraded output and label it as such; the onboarding skill halts and explains what to create.
- **install.sh requires Bash** → Acceptable given the stated constraints (solo operator, macOS/Linux dev environment). Mitigation: note the Bash dependency in the script header and `README.md`.
- **Feedback step fatigue** → Mandatory feedback step at the end of every output-format skill could feel burdensome for frequent use. Mitigation: the prompt is designed to be skippable — if the owner types "good" or dismisses it, nothing is logged and no error occurs.
- **Learnings file grows unbounded** → `.claude/learnings.md` accumulates entries over time with no expiry. Mitigation: the session-wrap skill surfaces clustering and encourages promotion; explicit pruning is out of scope for this release.

## Open Questions

- **OQ-001**: Which output-format skill(s) beyond `linkedin-post-skill` should be in scope for the initial release? (Candidates: blog article, whitepaper, newsletter, webinar outline.)
- **OQ-002**: Should the repository be public? This affects how strongly NFR-030 (frontmatter-only discoverability) must be enforced and whether onboarding documentation needs to be self-contained.
- **OQ-003**: Should `install.sh` support a `--list` flag to show available skills without installing? (Nice-to-have for usability.)
