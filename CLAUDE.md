# Claude Code Skills: Marketing & Content Creation

Reusable Claude Code skills for setting up and maintaining marketing/content creation projects. Each skill is a single `SKILL.md` file. Users install skills into their own projects via a curl install script (like the pattern at `MichaelvanLaar/claude-code-config-skills`).

## Key Config Files

| File | Purpose |
|------|---------|
| `.claude/settings.json` | Permissions, hooks, environment variables            |
| `.claude/skills/cc-init/SKILL.md` | Bootstrap Claude Code configuration skill            |
| `.claude/skills/cc-optimize/SKILL.md` | Audit and optimize Claude Code configuration skill   |
| `.claude/skills/cc-update/SKILL.md` | Update skills to latest versions skill               |
| `.claude/skills/linkedin-post/SKILL.md` | Draft and publish LinkedIn posts                     |
| `.claude/skills/onboarding/SKILL.md` | Populate .claude/context/ via interview              |
| `.claude/skills/openspec-apply-change/SKILL.md` | Implement tasks from an OpenSpec change              |
| `.claude/skills/openspec-archive-change/SKILL.md` | Archive a completed OpenSpec change                  |
| `.claude/skills/openspec-explore/SKILL.md` | Explore and think through proposed changes           |
| `.claude/skills/openspec-propose/SKILL.md` | Propose a new change with all artifacts              |
| `.claude/skills/samples-curation/SKILL.md` | Save and annotate gold-standard content examples     |
| `.claude/skills/session-wrap/SKILL.md` | Review session, collect feedback, commit work        |
| `.githooks/pre-commit` | Runs sync-config-table.sh before each commit         |
| `.gitignore` | Git ignore patterns                                  |
| `CLAUDE.md` | Project instructions, loaded every message           |
| `scripts/sync-config-table.sh` | Keeps Key Config Files table in CLAUDE.md in sync    |

## Structure

```
.claude/skills/[skill-name]/SKILL.md   one directory per skill
install.sh                              Distributes skills to target projects
```

## SKILL.md Frontmatter

Every skill must have this YAML frontmatter:

```yaml
---
name: skill-name
description: When to invoke (routing key — Claude reads this to decide when to trigger the skill)
allowed-tools: Read, Write, Edit, Bash, Grep, Glob
argument-hint: "[optional: describe expected args]"
---
```

- `description` is the routing key — write it as specific trigger statements, not a generic summary
- `allowed-tools` lists only the tools the skill actually needs; don't over-grant
- `argument-hint` is optional; omit if the skill takes no arguments

## Commands

- `bash install.sh [--all] [--update] [--target <path>] [skill-name ...]` — installs skills into a target project
- No build or test commands yet; validate SKILL.md frontmatter by inspection

## Context Architecture

Marketing skills follow a three-level context architecture:

| Level              | Location                                           | What goes here                                                                                                                |
| ------------------ | -------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------- |
| **Company scope**  | `.claude/context/`                                 | Brand voice, buyer personas, company profile, storytelling frameworks, curated samples — applies to all work for this company |
| **Format scope**   | `.claude/skills/<skill-name>/`                     | Structure rules, length limits, tone calibrations specific to one output type                                                 |
| **Campaign scope** | Regular project subfolders (e.g., `campaigns/q3/`) | Campaign briefings, key messages, one-off constraints for a specific initiative                                               |

### Hierarchical CLAUDE.md Pattern

For a marketing monorepo with campaign subfolders, place a `CLAUDE.md` at each directory level. Claude Code reads CLAUDE.md files up the directory tree, so a session in any subfolder automatically inherits all relevant context.

```
my-marketing-project/
├── CLAUDE.md                   ← @-imports all .claude/context/ files
├── .claude/
│   ├── context/
│   │   ├── company-profile.md
│   │   ├── brand-voice.md
│   │   └── buyer-personas.md
│   └── skills/
│       └── linkedin-post/
│           └── SKILL.md
└── campaigns/
    └── q3-product-launch/
        ├── CLAUDE.md           ← @-imports campaign-specific files
        └── brief.md
```

**Root CLAUDE.md** (project level) — imports company-scope context:

```markdown
@.claude/context/company-profile.md **Read when:** working on any deliverable for this company
@.claude/context/brand-voice.md **Read when:** producing any written content
@.claude/context/buyer-personas.md **Read when:** targeting content at a specific audience segment
```

**Campaign CLAUDE.md** (campaign subfolder) — imports campaign-scope context:

```markdown
@brief.md **Read when:** creating content for this campaign
@key-messages.md **Read when:** writing copy or posts for this initiative
```

## Authoring a New Skill

To add a new marketing skill:

1. Create `.claude/skills/<skill-name>/SKILL.md` with the frontmatter template below
2. Optionally add format-scope reference files inside the skill folder; @-import them from SKILL.md
3. Embed a semantic context check as Step 1 — see `.claude/skills/_shared/context-categories.md` for the taxonomy

### SKILL.md Template for Marketing Skills

```yaml
---
name: my-skill-name
description: >
  Use this skill when [specific trigger]. Invoke when the user asks to [action].
  Also triggered by [alternative phrasings].
allowed-tools: Read, Write, Edit, Bash
argument-hint: "[describe expected args, e.g., path to campaign brief]"
---
```

If the skill has format-scope reference files (e.g., `format-guidelines.md`), @-import
them from within the skill folder:

```markdown
@.claude/skills/my-skill-name/format-guidelines.md **Read when:** starting this skill
```

Do not @-import project context files (brand voice, company profile, personas, etc.) —
those are loaded exclusively via the target project's CLAUDE.md hierarchy.

### Required in every output-format skill

- **Semantic context check** (Step 1): assess whether required context categories are
  covered by the loaded context — match on meaning, not filename; ask once per missing
  required category; allow intentional omission; label output `⚠ DEGRADED OUTPUT` if
  proceeding without required categories. See `.claude/skills/_shared/context-categories.md`
  for the canonical taxonomy.
- Campaign briefing detection: look for `brief.md` in cwd or accept a path argument (FR-022)
- Feedback step at the end that logs corrections to `.claude/learnings.md` tagged with the skill name (FR-023)

### Authoring rules

- List only tools the skill actually uses in `allowed-tools` — never over-grant
- Format-scope guidelines go inside the skill folder, never in `.claude/context/`
- No absolute filesystem paths anywhere in the SKILL.md
- No company-specific content in the skill — that belongs in `.claude/context/` of the target project
- Do not @-import project context files from a skill — those are loaded via the target project's CLAUDE.md hierarchy

## Don't

- Don't commit secrets or credentials to git
- Don't use `--force` flags — fix the underlying issue instead
- Don't add company-specific context here — that belongs in the target project's `.claude/context/`
- Don't embed target-project knowledge (brand voice, personas, etc.) in skill definitions

## Learnings

When the user corrects a mistake or points out a recurring issue, append a one-line summary to `.claude/learnings.md`. Don't modify CLAUDE.md directly.

## Compact Instructions

When compacting, preserve: list of modified files, open TODOs, and key decisions made.
