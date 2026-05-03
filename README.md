# claude-code-skills-for-marketing-and-content-creation

Reusable Claude Code skills for setting up and running marketing and content creation projects. Each skill is a self-contained `SKILL.md` file that you install into your own project once and invoke by name from within Claude Code.

**`/onboarding`** populates your project's `.claude/context/` folder through a structured interview — brand voice, company identity, target audience, output language, and more. Run it once when starting a new project.

**`/linkedin-post`** drafts a complete, publish-ready LinkedIn post that reflects your brand voice and company positioning. Picks up campaign briefings automatically. Ends with a feedback step that logs corrections for future sessions.

**`/session-wrap`** closes out a content creation session: reviews what was produced, collects skill feedback, surfaces recurring correction patterns, promotes them into permanent rules if warranted, and commits everything with a clean message.

**`/samples-curation`** saves a gold-standard piece of content to a curated examples file, annotated with what made it work. Skills reference these examples to calibrate output quality over time.

**`/marketing-update`** updates all installed marketing skills to their latest versions from this repository — run it any time you want to pick up improvements or new skills.

## Table of Contents

- [What problem do these skills solve?](#what-problem-do-these-skills-solve)
- [Installation](#installation)
- [Usage](#usage)
  - [`/onboarding` — Set up project context](#onboarding--set-up-project-context)
  - [`/linkedin-post` — Draft a LinkedIn post](#linkedin-post--draft-a-linkedin-post)
  - [`/session-wrap` — Close out a session](#session-wrap--close-out-a-session)
  - [`/samples-curation` — Save a gold-standard example](#samples-curation--save-a-gold-standard-example)
  - [`/marketing-update` — Keep skills current](#marketing-update--keep-skills-current)
  - [Recommended workflow](#recommended-workflow)
- [Context architecture](#context-architecture)
- [What the skills create](#what-the-skills-create)
- [Working in languages other than English](#working-in-languages-other-than-english)
- [Compatibility](#compatibility)
- [Contributing](#contributing)
- [License](#license)

## What problem do these skills solve?

Creating consistent, on-brand content with Claude Code requires the model to know your brand voice, your audience, your product, and your quality bar — every session. Without a structured approach that context either gets re-explained from scratch each time, or it doesn't get loaded at all and you get generic output.

These skills solve that by building a persistent, hierarchical context layer for your project:

- **`/onboarding`** creates the context files once, through a guided interview. After that, Claude Code loads them automatically on every message via `@`-imports in your `CLAUDE.md`.
- **Output-format skills** (starting with `/linkedin-post`) know which context they need, check whether it's present, and refuse to produce degraded output silently — they label it `⚠ DEGRADED OUTPUT` and tell you what's missing.
- **`/session-wrap`** closes the feedback loop: corrections from each session get logged and can be promoted into permanent rules, so quality compounds over time rather than resetting.

## Installation

Run the install script from your project directory:

```bash
curl -fsSL https://raw.githubusercontent.com/MichaelvanLaar/claude-code-skills-for-marketing-and-content-creation/main/install.sh | bash -s -- --all
```

This installs all available skills into `.claude/skills/` in the current directory.

To install specific skills only:

```bash
curl -fsSL https://raw.githubusercontent.com/MichaelvanLaar/claude-code-skills-for-marketing-and-content-creation/main/install.sh | bash -s -- onboarding linkedin-post session-wrap
```

To install into a specific directory:

```bash
curl -fsSL https://raw.githubusercontent.com/MichaelvanLaar/claude-code-skills-for-marketing-and-content-creation/main/install.sh | bash -s -- --all --target ~/projects/my-marketing-project
```

If you prefer to inspect the script before running it:

```bash
curl -fsSL https://raw.githubusercontent.com/MichaelvanLaar/claude-code-skills-for-marketing-and-content-creation/main/install.sh -o install.sh
# Review install.sh, then:
bash install.sh --all
rm install.sh
```

### Directory structure after installation

```
your-project/
└── .claude/
    └── skills/
        ├── linkedin-post/
        │   ├── SKILL.md
        │   └── format-guidelines.md
        ├── marketing-update/
        │   └── SKILL.md
        ├── onboarding/
        │   └── SKILL.md
        ├── samples-curation/
        │   └── SKILL.md
        └── session-wrap/
            └── SKILL.md
```

After running `/onboarding`, additional files are created under `.claude/context/` (see [What the skills create](#what-the-skills-create)).

## Usage

### `/onboarding` — Set up project context

Start Claude Code in your project directory and invoke the skill:

```
/onboarding
```

Or to regenerate a specific context category:

```
/onboarding writing-style
/onboarding target-audience
```

The skill will:

1. **Scan** for existing context files and show a coverage table — which categories are present and which are missing.
2. **Interview** you for missing required categories (`writing-style`, `organization-identity`) and the recommended category (`target-audience`), one category at a time. You can also point to an existing file instead of answering questions.
3. **Collect the default output language** unconditionally — always written to `.claude/context/content-defaults.md` regardless of whether a writing-style file exists or is a non-editable PDF.
4. **Create context files** at paths you specify (defaulting to `.claude/context/<category>.md`).
5. **Wire everything into `CLAUDE.md`** via `@`-imports so all skills load the context automatically on every message.
6. **Summarize** what was created and what was skipped.

### `/linkedin-post` — Draft a LinkedIn post

```
/linkedin-post
```

Or with a campaign briefing file:

```
/linkedin-post campaigns/q3-launch/brief.md
```

The skill will:

1. **Check loaded context** — verify that writing-style and organization-identity context is present. If required context is missing and you haven't intentionally omitted it, it pauses so you can add it to your `CLAUDE.md` before continuing.
2. **Load the campaign briefing** — from the argument path, or from `brief.md` in the current working directory if present.
3. **Ask for the post topic** if you haven't described it yet.
4. **Generate the post** — a complete, publish-ready LinkedIn post with a strong hook, substantive body, specific CTA, and 3–5 hashtags. Character count is shown. Posts without required context are labelled `⚠ DEGRADED OUTPUT`.
5. **Collect feedback** — any corrections are logged to `.claude/learnings.md` for future sessions.

### `/session-wrap` — Close out a session

At the end of any content creation session:

```
/session-wrap
```

The skill will:

1. **Review deliverables** — groups changed files into context updates, content output, skill files, and other.
2. **Collect feedback** per skill used during the session.
3. **Detect recurring patterns** — if three or more corrections point to the same underlying issue, it surfaces them and offers to promote a fix into a skill's format guidelines or into `CLAUDE.md`.
4. **Commit** all session work with a Conventional Commits + gitmoji message.
5. **Summarize** deliverables reviewed, learnings logged, patterns promoted, and the commit hash.

### `/samples-curation` — Save a gold-standard example

When a piece of content hits the quality bar you want to reproduce:

```
/samples-curation
```

The skill walks you through annotating the example — what made it work, what it demonstrates — and appends it to `.claude/context/samples.md`. Output-format skills can reference this file to calibrate future output to your gold standard.

### `/marketing-update` — Keep skills current

After the initial install, run this from within Claude Code any time you want to pull the latest versions:

```
/marketing-update
```

It detects which marketing skills are installed in the current project and updates only those — skills you have not installed are left alone.

### Recommended workflow

```
Day 1:    /onboarding                  ← Set up context files through interview
          /linkedin-post               ← First post — verify quality
          /session-wrap                ← Commit and collect initial feedback

Ongoing:  /linkedin-post               ← Draft posts
          /samples-curation            ← Save strong examples as reference
          /session-wrap                ← Close each session, log corrections

Periodic: /marketing-update            ← After pulling updates from this repo
```

## Context architecture

Marketing skills use a three-level context hierarchy. Each level is a separate folder with its own `CLAUDE.md` `@`-imports, so a session in any subfolder automatically inherits all relevant context.

| Level              | Location                                           | What goes here                                                                                                                      |
| ------------------ | -------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------- |
| **Company scope**  | `.claude/context/`                                 | Brand voice, company identity, audience personas, output language defaults, curated examples — applies to all work for this company |
| **Format scope**   | `.claude/skills/<skill-name>/`                     | Structure rules, length limits, tone calibrations specific to one output format (e.g., LinkedIn post format guidelines)             |
| **Campaign scope** | Regular project subfolders (e.g., `campaigns/q3/`) | Campaign briefings, key messages, one-off constraints for a specific initiative                                                     |

### How it looks in practice

```
my-marketing-project/
├── CLAUDE.md                         ← @-imports all .claude/context/ files
├── .claude/
│   ├── context/
│   │   ├── content-defaults.md       ← Default output language
│   │   ├── writing-style.md          ← Brand voice, tone, vocabulary
│   │   ├── organization-identity.md  ← Company, products, mission
│   │   ├── target-audience.md        ← Personas, goals, pain points
│   │   └── samples.md                ← Gold-standard content examples
│   └── skills/
│       └── linkedin-post/
│           ├── SKILL.md
│           └── format-guidelines.md
└── campaigns/
    └── q3-product-launch/
        ├── CLAUDE.md                 ← @-imports campaign-specific files
        └── brief.md
```

**Root `CLAUDE.md`** — imports company-scope context:

```markdown
@.claude/context/content-defaults.md **Read when:** producing any content for this project
@.claude/context/writing-style.md **Read when:** producing any written content
@.claude/context/organization-identity.md **Read when:** working on any deliverable for this company
@.claude/context/target-audience.md **Read when:** targeting content at a specific audience segment
```

**Campaign `CLAUDE.md`** — imports campaign-scope context:

```markdown
@brief.md **Read when:** creating content for this campaign
@key-messages.md **Read when:** writing copy or posts for this initiative
```

### Context categories

The skills share a common taxonomy of context categories:

| Category                  | Required?           | What it covers                                               |
| ------------------------- | ------------------- | ------------------------------------------------------------ |
| `content-defaults`        | Always created      | Default output language and project-level output settings    |
| `writing-style`           | Required for output | Tone, vocabulary, phrases to use or avoid, sentence patterns |
| `organization-identity`   | Required for output | What the company does, products, mission, differentiators    |
| `target-audience`         | Recommended         | Personas, goals, challenges, preferred channels              |
| `storytelling-frameworks` | Optional            | Named frameworks: PAS, StoryBrand, Cialdini, etc.            |
| `reference-materials`     | Optional            | Books or research that inform the content approach           |
| `reference-samples`       | Optional            | Curated past content examples with quality annotations       |

Skills match context **by meaning, not by filename** — a file called `Schreibstil.md` satisfies the `writing-style` category just as well as `brand-voice.md`.

## What the skills create

| File / Directory                           | Created by                      | Purpose                                                      |
| ------------------------------------------ | ------------------------------- | ------------------------------------------------------------ |
| `.claude/context/content-defaults.md`      | `/onboarding`                   | Default output language and project-level defaults           |
| `.claude/context/writing-style.md`         | `/onboarding`                   | Brand voice, tone, vocabulary (path is user-specified)       |
| `.claude/context/organization-identity.md` | `/onboarding`                   | Company identity, products, mission (path is user-specified) |
| `.claude/context/target-audience.md`       | `/onboarding`                   | Audience personas (path is user-specified)                   |
| `.claude/context/samples.md`               | `/samples-curation`             | Curated gold-standard content examples                       |
| `.claude/learnings.md`                     | output skills + `/session-wrap` | Corrections logged per session, tagged by skill              |
| `CLAUDE.md`                                | `/onboarding`                   | Created or updated with `@`-imports for all context files    |

## Working in languages other than English

All skills work in any language. The interface between you and Claude Code can be in English while the generated content is in any language — the output language is set once during `/onboarding` and stored in `.claude/context/content-defaults.md`. Skills load this file on every invocation and produce content in the specified language automatically.

Context files (brand voice, personas, company profile) can be written in any language. Skills match context by meaning, not filename, so `Schreibstil.md`, `Zielgruppen.md`, and `Unternehmensprofil.md` are recognized correctly.

## Compatibility

- Works with any marketing or content creation project structure.
- Works alongside [`claude-code-config-skills`](https://github.com/MichaelvanLaar/claude-code-config-skills) — the `/marketing-update` skill is named distinctly to avoid conflict with `/cc-update`.
- Requires Claude Code (CLI, VS Code extension, or JetBrains extension).
- The install script requires Bash 3.2+ and `curl`.

## Contributing

Issues and pull requests are welcome. If you have a new output-format skill (blog post, email newsletter, X/Twitter thread, etc.) or improvements to existing ones, please open an issue or PR.

## License

[MIT](LICENSE)
