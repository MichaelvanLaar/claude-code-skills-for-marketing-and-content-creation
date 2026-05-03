## Why

Marketing projects require rich multi-layered context (company profiles, brand voice, buyer personas, storytelling frameworks, output format rules) that is currently managed ad hoc across files and external tools. Without a structured skill library, each Claude Code session requires manual context setup and produces inconsistent, not-necessarily-on-brand output.

## What Changes

- Add `install.sh` that copies selected skills into `.claude/skills/` of a target marketing project
- Add `onboarding-skill` that interviews the owner and populates missing company-level context files in `.claude/context/`, skipping files already present (e.g., from the n8n brand voice pipeline)
- Add `samples-curation-skill` for capturing and annotating gold-standard content examples into a shared context file
- Add `linkedin-post-skill` as the first fully implemented output-format skill, demonstrating the end-to-end pattern (read context → produce deliverable → collect feedback)
- Add `session-wrap-skill` for structured end-of-session feedback collection, learnings logging, and git commit
- Document the three-level context architecture (company / format / campaign scope) and the hierarchical CLAUDE.md pattern in the project's `CLAUDE.md`

## Capabilities

### New Capabilities

- `install-script`: Copies selected skills from this repository into `.claude/skills/` of a target marketing project; consistent with the cc-init install mechanism
- `onboarding-skill`: Interviews the owner about their company, populates missing `.claude/context/` files, skips already-present files, creates `context/README.md`, and guides root `CLAUDE.md` setup
- `samples-curation-skill`: Walks the owner through identifying and annotating gold-standard content examples, appending confirmed entries to `.claude/context/samples.md`
- `linkedin-post-skill`: Produces a LinkedIn post by reading company-level context and an optional campaign briefing; ends with a feedback step that logs corrections to `.claude/learnings.md`
- `session-wrap-skill`: Guides end-of-session routine — reviews deliverables, solicits skill feedback, appends to `.claude/learnings.md`, surfaces recurring patterns, and creates a Conventional Commits + gitmoji commit

### Modified Capabilities

<!-- No existing specs — first change on a new repository -->

## Impact

- New skills added to `.claude/skills/`: `onboarding-skill`, `samples-curation-skill`, `linkedin-post-skill`, `session-wrap-skill`
- New `install.sh` at repository root
- Authoring conventions for new skills documented in `CLAUDE.md` (NFR-012)
- Target project side effects (created by skills at runtime, not committed to this repo): `.claude/context/README.md`, `.claude/context/samples.md`, `.claude/learnings.md`
- No changes to existing skills: `cc-init`, `cc-optimize`, `cc-update`, `openspec-*`
