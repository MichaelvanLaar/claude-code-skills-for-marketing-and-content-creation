# Claude Code Skills: Marketing & Content Creation

Reusable [Claude Code](https://claude.ai/code) skills for marketing and content creation projects. Install one skill or the full set into any project with a single command.

---

## Available Skills

| Skill                | What it does                                                                                                                                         |
| -------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------- |
| **onboarding**       | Interviews you about your brand, voice, and audience, then populates `.claude/context/` with structured context files that all other skills can read |
| **linkedin-post**    | Drafts LinkedIn posts that match your brand voice, format guidelines, and audience — with a built-in feedback step                                   |
| **samples-curation** | Saves gold-standard content examples with annotations to `.claude/context/samples.md` so skills can use them as reference material                   |
| **session-wrap**     | Reviews session deliverables, logs feedback and corrections, detects recurring patterns, and commits your work                                       |

---

## Installation

### Option A — Install script (recommended)

From the root of your project, run:

```bash
# Install a single skill
bash <(curl -fsSL https://raw.githubusercontent.com/MichaelvanLaar/claude-code-skills-for-marketing-and-content-creation/main/install.sh) onboarding

# Install all skills at once
bash <(curl -fsSL https://raw.githubusercontent.com/MichaelvanLaar/claude-code-skills-for-marketing-and-content-creation/main/install.sh) --all

# Update already-installed skills
bash <(curl -fsSL https://raw.githubusercontent.com/MichaelvanLaar/claude-code-skills-for-marketing-and-content-creation/main/install.sh) --update --all

# Install into a specific directory
bash <(curl -fsSL https://raw.githubusercontent.com/MichaelvanLaar/claude-code-skills-for-marketing-and-content-creation/main/install.sh) --target ~/projects/my-marketing-project --all
```

Or clone first and run locally:

```bash
git clone https://github.com/MichaelvanLaar/claude-code-skills-for-marketing-and-content-creation.git
cd claude-code-skills-for-marketing-and-content-creation
bash install.sh --all --target ~/projects/my-marketing-project
```

### Option B — Manual copy

Copy any skill folder from `.claude/skills/<skill-name>/` into `.claude/skills/` of your target project:

```
your-project/
└── .claude/
    └── skills/
        └── linkedin-post/
            └── SKILL.md
```

---

## Getting Started

**Step 1 — Run onboarding**

After installing, open your project in Claude Code and run the onboarding skill:

```
/onboarding
```

This populates `.claude/context/` with your brand voice, company profile, and buyer personas. The other skills read this context automatically.

**Step 2 — Create content**

Run any output skill:

```
/linkedin-post
```

**Step 3 — Curate good examples**

When a piece of content lands well, save it as a reference sample:

```
/samples-curation
```

**Step 4 — Wrap your session**

At the end of each working session, commit your work and log any corrections:

```
/session-wrap
```

---

## Context Architecture

Skills follow a three-level context model:

| Level              | Location                                  | What goes here                                                                      |
| ------------------ | ----------------------------------------- | ----------------------------------------------------------------------------------- |
| **Company scope**  | `.claude/context/`                        | Brand voice, buyer personas, company profile — applies to all work for this company |
| **Format scope**   | `.claude/skills/<skill-name>/`            | Structure rules, length limits, tone calibrations for one output type               |
| **Campaign scope** | Project subfolders (e.g. `campaigns/q3/`) | Campaign briefings, key messages, one-off constraints                               |

Load company-scope context by importing it from your project-level `CLAUDE.md`:

```markdown
@.claude/context/brand-voice.md **Read when:** producing any written content
@.claude/context/company-profile.md **Read when:** working on any deliverable
@.claude/context/buyer-personas.md **Read when:** targeting content at a specific audience segment
```

---

## License

[MIT](LICENSE) — Copyright (c) 2026 Michael van Laar
