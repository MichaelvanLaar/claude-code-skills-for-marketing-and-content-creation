---
name: onboarding
description: >
  Use this skill when setting up a new marketing project with Claude Code, populating
  company-level context files, or initializing the .claude/context/ folder.
  Invoke when the user asks to "onboard a new client", "set up context files",
  "create company profile", "populate .claude/context", "initialize marketing project",
  or "set up brand context". Also use when context files are missing and the user
  wants to create them through an interview.
allowed-tools: Read, Write, Edit, Bash, Glob
argument-hint: "[optional: name of context file to regenerate, e.g. buyer-personas.md]"
---

@.claude/context/company-profile.md **Read when:** regenerating or verifying this file
@.claude/context/buyer-personas.md **Read when:** regenerating or verifying this file
@.claude/context/brand-voice.md **Read when:** regenerating or verifying this file
@.claude/context/storytelling-frameworks.md **Read when:** regenerating or verifying this file

# Onboarding Skill

You are setting up the company-level context for a marketing project. Your goal is to
populate `.claude/context/` with structured Markdown files that all future skills will
read — without overwriting anything already present from external tools.

## Step 1: Pre-flight check

Before asking a single question, audit what context files already exist.

Run:

```bash
ls .claude/context/ 2>/dev/null || echo "(empty)"
```

For each of the four standard context files, note its status:

| File                         | Status            |
| ---------------------------- | ----------------- |
| `company-profile.md`         | present / missing |
| `buyer-personas.md`          | present / missing |
| `brand-voice.md`             | present / missing |
| `storytelling-frameworks.md` | present / missing |

Show the owner the table. For each file marked **present**, say:

> "`<filename>`: already present — will skip unless you ask me to regenerate it."

If `$ARGUMENTS` names a specific file to regenerate (e.g., `buyer-personas.md`), treat
that file as **missing** regardless of whether it exists (regeneration mode).

## Step 2: Company profile interview

If `company-profile.md` is **missing**, ask these questions — one at a time, wait for each answer:

1. "What is the company's name and one-sentence description of what it does?"
2. "What are the main products or services? (List them briefly.)"
3. "What is the company's mission or core purpose?"
4. "What makes this company different from competitors? (Key differentiators.)"
5. "Are there any values or principles the company is known for?"

If the owner skips a question, use a `TODO: [question text]` placeholder for that field.

After collecting answers, write `.claude/context/company-profile.md`:

```markdown
# Company Profile

## Name

<answer>

## Description

<answer>

## Products & Services

<answer>

## Mission

<answer>

## Differentiators

<answer>

## Values

<answer>
```

Confirm: "✓ Created `company-profile.md`."

## Step 3: Buyer personas interview

If `buyer-personas.md` is **missing**, ask:

1. "How many distinct buyer personas does this company target? (1–4 recommended.)"

For each persona, ask:

- "What is this persona's role or title?"
- "What are their primary goals or motivations?"
- "What are their biggest challenges or frustrations?"
- "What objections do they typically raise?"
- "What content formats or channels do they prefer?"

Write `.claude/context/buyer-personas.md` with one section per persona:

```markdown
# Buyer Personas

## Persona: <role/title>

**Goals:** <answer>
**Challenges:** <answer>
**Objections:** <answer>
**Preferred channels:** <answer>
```

Confirm: "✓ Created `buyer-personas.md`."

## Step 4: Brand voice

If `brand-voice.md` is **missing**:

> "I don't see a `brand-voice.md`. This is typically produced by the n8n brand voice
> pipeline. Would you like me to create a basic version through a short interview, or
> will you add it separately later?"

If the owner wants to create it, ask:

1. "How would you describe the brand's tone? (e.g., authoritative, conversational, witty)"
2. "What words or phrases does the brand use frequently?"
3. "What words or phrases should the brand never use?"
4. "Is there a specific reading level or vocabulary level to target?"

Write `.claude/context/brand-voice.md`:

```markdown
# Brand Voice

## Tone

<answer>

## Signature phrases & vocabulary

<answer>

## Words & phrases to avoid

<answer>

## Reading level

<answer>
```

Confirm: "✓ Created `brand-voice.md`."

If the owner says they'll add it separately, note it in the summary as
"`brand-voice.md`: deferred — will be added separately."

## Step 5: Storytelling frameworks

If `storytelling-frameworks.md` is **missing**, ask:

> "Do you use any named storytelling or persuasion frameworks in your content?
> (Examples: problem–agitate–solve, hero's journey, Cialdini's principles, StoryBrand.)
> I can document these as a reference, or you can add them later."

If the owner provides frameworks, document them. If they skip, create the file with:

```markdown
# Storytelling Frameworks

TODO: Document the frameworks this company uses for marketing content.
Examples: Problem–Agitate–Solve, StoryBrand, Cialdini's principles.
```

Confirm: "✓ Created `storytelling-frameworks.md`."

## Step 6: Context README

Check whether `.claude/context/README.md` already exists:

```bash
ls .claude/context/README.md 2>/dev/null && echo "exists" || echo "missing"
```

If **missing**, create it:

```markdown
# Context Files

This folder contains company-level context that all Claude Code marketing skills read.

## Files

<list each file in .claude/context/ with a one-line description>

## Three-Level Context Architecture

| Level              | Location                                    | What goes here                                                                      |
| ------------------ | ------------------------------------------- | ----------------------------------------------------------------------------------- |
| **Company scope**  | `.claude/context/`                          | Brand voice, buyer personas, company profile — applies to all work for this company |
| **Format scope**   | `.claude/skills/<skill-name>/`              | Structure rules and guidelines specific to one output type                          |
| **Campaign scope** | Campaign subfolders (e.g., `campaigns/q3/`) | Campaign briefings and one-off constraints for a specific initiative                |

When Claude Code starts a session in any subfolder, it reads CLAUDE.md files up the
directory tree. Add a CLAUDE.md at each level with `@`-imports for the relevant files
so context loads automatically without manual setup.
```

Populate the Files table by listing what is actually present in `.claude/context/`.

Confirm: "✓ Created `.claude/context/README.md`."

## Step 7: Root CLAUDE.md guidance

Check whether a root-level `CLAUDE.md` exists:

```bash
ls CLAUDE.md 2>/dev/null && echo "exists" || echo "missing"
```

**If missing**, create a starter `CLAUDE.md` with `@`-imports for every context file
just created. Use a `**Read when:**` trigger appropriate to each file:

```markdown
# [Company Name]

@.claude/context/company-profile.md **Read when:** working on any deliverable for this company
@.claude/context/brand-voice.md **Read when:** producing any written content
@.claude/context/buyer-personas.md **Read when:** targeting content at a specific audience segment
@.claude/context/storytelling-frameworks.md **Read when:** structuring persuasive content
```

Confirm: "✓ Created root `CLAUDE.md` with context imports."

**If CLAUDE.md already exists**, check whether it contains an `@`-import for each
newly created context file. For any that are missing, propose the addition:

> "Your `CLAUDE.md` doesn't have an `@`-import for `brand-voice.md`. Shall I add:
> `@.claude/context/brand-voice.md **Read when:** producing any written content`?"

Only add entries after the owner confirms.

## Step 8: Summary

Print a final summary table:

```
Onboarding complete
───────────────────
company-profile.md         ✓ created
buyer-personas.md          ✓ created
brand-voice.md             already present — skipped
storytelling-frameworks.md ✓ created
.claude/context/README.md  ✓ created
root CLAUDE.md             ✓ created (or: ✓ updated / already present)
```

Then say:

> "Your marketing project context is ready. Skills like `linkedin-post` and
> `session-wrap` will automatically load these files when invoked."
