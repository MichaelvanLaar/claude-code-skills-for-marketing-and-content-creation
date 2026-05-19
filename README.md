# cc-content

A [Claude Code](https://claude.ai/code) plugin that provides a suite of content creation skills for marketing projects — brand onboarding, LinkedIn posts, blog articles, sample curation, and session management.

---

## Plugin: `cc-content`

| Skill                                     | What it does                                                                                                                                                                                      |
| ----------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `/cc-content:cc-content-onboarding`       | Interviews you about your brand, voice, and audience, then populates `context/` with structured context files that all other skills can read                                                      |
| `/cc-content:cc-content-linkedin-post`    | Drafts LinkedIn posts that match your brand voice, format guidelines, and audience — with a built-in feedback step                                                                                |
| `/cc-content:cc-content-blog-article`     | Drafts blog articles calibrated to your audience type (B2B / B2C), content goal, funnel stage, and reader expertise — works in any language and reads brand-specific blog rules from CLAUDE.md    |
| `/cc-content:cc-content-samples-curation` | Saves gold-standard content examples with annotations to `context/samples.md` so skills can use them as reference material                                                                        |
| `/cc-content:cc-content-session-wrap`     | Reviews session deliverables, logs feedback and corrections, detects recurring patterns, and commits your work                                                                                    |
| `/cc-content:cc-content-new-skill`        | Turns research notes into a complete content-production skill for a new output format. Use it to build project-local custom skills, or add `--plugin` to create a pre-built skill for the plugin. |

---

## Installation

Open Claude Code in any project and run:

```
/plugin marketplace add MichaelvanLaar/cc-plugins
/plugin install cc-content@cc-content
```

This makes all skills immediately available.

### Keeping Skills Current

Auto-update is disabled by default for third-party marketplaces. To enable it:

1. Run `/plugin` in Claude Code
2. Go to the **Marketplaces** tab
3. Toggle auto-update for `MichaelvanLaar/cc-plugins`

Once enabled, skills update automatically on startup when new versions are available.

---

## Getting Started

**Step 1 — Run onboarding**

Open your marketing project in Claude Code and run the onboarding skill:

```
/cc-content:cc-content-onboarding
```

This populates `context/` with your brand voice, company profile, and buyer personas. The other skills read this context automatically.

**Step 2 — Create content**

Run any output skill:

```
/cc-content:cc-content-linkedin-post
```

**Step 3 — Curate good examples**

When a piece of content lands well, save it as a reference sample:

```
/cc-content:cc-content-samples-curation
```

**Step 4 — Wrap your session**

At the end of each working session, commit your work and log any corrections:

```
/cc-content:cc-content-session-wrap
```

---

## Extending with Custom Content Skills

The plugin ships with LinkedIn post and blog article support today, and more pre-built formats are planned. If you need a content format that isn't covered yet, you can build a project-local skill using `cc-content-new-skill` — no plugin contribution required.

**Workflow:**

1. Run `/cc-content:cc-content-new-skill <format-name>` without any research files. The skill will guide you to a research brief template that tells you what to gather about your target format.
2. Fill in the brief, then re-run `/cc-content:cc-content-new-skill <format-name>` with your research files attached. The skill interviews you about coverage gaps, synthesizes a `format-guidelines.md`, and generates a `SKILL.md` skeleton.
3. Open the generated `SKILL.md` and fill in the `[TODO: ...]` placeholders to tailor the skill to your exact needs.
4. The finished skill lives in `.claude/skills/<format-name>/` and is ready to invoke from there.

If the new format turns out to be broadly useful and you'd like to contribute it back, re-run the skill with `--plugin` to produce a version structured for the plugin repository.

---

## Context Architecture

Skills follow a three-level context model:

| Level              | Location                                  | What goes here                                                                      |
| ------------------ | ----------------------------------------- | ----------------------------------------------------------------------------------- |
| **Company scope**  | `context/`                                | Brand voice, buyer personas, company profile — applies to all work for this company |
| **Format scope**   | Inside the plugin                         | Structure rules, length limits, tone calibrations for one output type               |
| **Campaign scope** | Project subfolders (e.g. `campaigns/q3/`) | Campaign briefings, key messages, one-off constraints                               |

Load company-scope context by importing it from your project-level `CLAUDE.md`:

```markdown
@context/brand-voice.md **Read when:** producing any written content
@context/company-profile.md **Read when:** working on any deliverable
@context/buyer-personas.md **Read when:** targeting content at a specific audience segment
```

---

## License

[MIT](LICENSE) — Copyright (c) 2026 Michael van Laar
