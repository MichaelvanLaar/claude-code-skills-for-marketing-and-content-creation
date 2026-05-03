# Claude Code Skills: Marketing & Content Creation

Reusable Claude Code skills for marketing and content creation projects.
Install skills into a target project via `install.sh` or by copying skill
folders manually.

## Skills in this Repository

| Skill                | File                                       | Purpose                                                    |
| -------------------- | ------------------------------------------ | ---------------------------------------------------------- |
| **onboarding**       | `.claude/skills/onboarding/SKILL.md`       | Populate `.claude/context/` via interview                  |
| **linkedin-post**    | `.claude/skills/linkedin-post/SKILL.md`    | Draft LinkedIn posts                                       |
| **marketing-update** | `.claude/skills/marketing-update/SKILL.md` | Update installed marketing skills to their latest versions |
| **samples-curation** | `.claude/skills/samples-curation/SKILL.md` | Save and annotate gold-standard content examples           |
| **session-wrap**     | `.claude/skills/session-wrap/SKILL.md`     | Review session, collect feedback, commit work              |

## Structure

```
.claude/skills/[skill-name]/SKILL.md   one directory per skill
install.sh                              Distributes skills to target projects
```

## Context Architecture

Marketing skills follow a three-level context architecture:

| Level              | Location                                  | What goes here                                                                      |
| ------------------ | ----------------------------------------- | ----------------------------------------------------------------------------------- |
| **Company scope**  | `.claude/context/`                        | Brand voice, buyer personas, company profile — applies to all work for this company |
| **Format scope**   | `.claude/skills/<skill-name>/`            | Structure rules, length limits, tone calibrations for one output type               |
| **Campaign scope** | Project subfolders (e.g. `campaigns/q3/`) | Campaign briefings, key messages, one-off constraints                               |

### Hierarchical CLAUDE.md Pattern

Place a `CLAUDE.md` at each directory level in your marketing project. Claude Code
reads CLAUDE.md files up the directory tree, so a session in any subfolder
automatically inherits all relevant context.

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

**Root CLAUDE.md** — imports company-scope context:

```markdown
@.claude/context/company-profile.md **Read when:** working on any deliverable for this company
@.claude/context/brand-voice.md **Read when:** producing any written content
@.claude/context/buyer-personas.md **Read when:** targeting content at a specific audience segment
```

**Campaign CLAUDE.md** — imports campaign-scope context:

```markdown
@brief.md **Read when:** creating content for this campaign
@key-messages.md **Read when:** writing copy or posts for this initiative
```
