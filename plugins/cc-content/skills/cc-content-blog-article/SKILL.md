---
name: cc-content-blog-article
description: >
  Use this skill when the owner wants to write, draft, or generate a blog
  article. Invoke when the user says "write a blog article", "draft a blog
  post", "create a blog article", "generate a blog post", "write a how-to
  article", "draft a thought leadership piece", "write a pillar page", or
  similar requests for long-form web content.
allowed-tools: Read, Write, Bash
argument-hint: "[optional: path to campaign briefing file]"
---

@./format-guidelines.md **Read when:** starting this skill
@../\_shared/storytelling-frameworks.md **Read when:** selecting a narrative framework in Step 5
@../\_shared/persuasion-principles.md **Read when:** selecting persuasion principles in Step 6

# Blog Article Skill

You are helping the owner produce a complete, publishable blog article. The
article must comply with the format guidelines in this skill folder, reflect
the company's brand voice, address the right audience for the right goal at
the right funnel stage, and — if a campaign briefing is present — serve the
briefing's goals.

This skill is **language-, industry-, and audience-neutral**. It works for any
output language and any combination of B2B / B2C, goal, funnel stage, and
expertise level. Calibration happens explicitly in Step 3 by inferring values
from the loaded context and confirming them with the owner.

## Step 0: Recall learnings

If `.claude/learnings.md` exists, read it silently. Apply all entries relevant
to this run — both `[cc-content:*]`-tagged entries and entries from other
plugins that inform content quality or project constraints. Do not announce
this step. If the file is absent, continue normally.

## Step 1: Load context

Check whether CLAUDE.md contains a `## Context files` table:

```bash
grep -A 100 '## Context files' CLAUDE.md 2>/dev/null || echo "(no context table)"
```

For each of the following categories, find the matching row in the table
(match on the **Category** column) and Read the file listed in the **File**
column:

| Category                  | What it covers                                               | Required?   |
| ------------------------- | ------------------------------------------------------------ | ----------- |
| **writing-style**         | Tone, vocabulary, phrases to use or avoid, sentence patterns | Required    |
| **organization-identity** | What the brand does, products, services, positioning         | Required    |
| **target-audience**       | Who the reader is, their goals, challenges, and motivations  | Recommended |
| **content-defaults**      | Default output language and other project-level settings     | Recommended |

CLAUDE.md files may exist at multiple hierarchy levels (workspace root,
project root, sub-directory). The harness already loads all applicable
CLAUDE.md files into your context window — read the **most specific** context
table that applies (sub-directory beats project root beats workspace).
If multiple tables exist and disagree on a category's file, the most specific
one wins.

**Also look for brand-specific blog rules.** Many projects extend the universal
format-guidelines with their own blog-article rules — mandatory sections,
author-bio blocks, SEO conventions, link policies, disclosure footers, image
sourcing rules. These typically live in a file referenced from CLAUDE.md (for
example under a `blog-rules` or `content-rules` category, or embedded inside
`writing-style`). If you find any such file or section, read it and treat its
rules as **additional mandatory gates** layered on top of `format-guidelines.md`.

If the context table is absent entirely, or if a **Required** category has no
row in the table, ask once:

> "I don't see any **[category name]** context. Is this intentional, or should
> I pause while you run `/cc-content:cc-content-onboarding`?"

- If the owner says it's **intentional**: note the gap and continue. Label the
  final output `⚠ DEGRADED OUTPUT` and list the missing categories.
- If the owner says to **pause**: say "Run `/cc-content:cc-content-onboarding`
  to set up your context files, then invoke this skill again." and stop.

For **Recommended** categories that are absent: note silently and continue.

After loading all available files, proceed to Step 2.

## Step 2: Check for campaign briefing

Determine the briefing path:

1. If the owner passed a file path as an argument (`$ARGUMENTS`), use that path.
2. Otherwise, check for `brief.md` in the current working directory:

```bash
ls brief.md 2>/dev/null && echo "found" || echo "missing"
```

- **Found** (either via argument or `brief.md`): read the file and note its
  key messages, goals, constraints, target keyword (if any), and required
  CTAs. Confirm: "✓ Campaign briefing loaded from `<path>`."
- **Missing**: note "No campaign briefing found — generating from company
  context only." and continue.

## Step 3: Infer and confirm audience, goal, funnel stage, and expertise

This is the calibration step. The blog-article format covers an unusually wide
range of valid configurations, and the most common cause of underperforming
content is mixing incompatible values (e.g., TOFU awareness post with a BOFU
"Book a demo" CTA). Calibrate explicitly before drafting.

1. Read the loaded target-audience context and the campaign brief (if any).
2. Infer four values:
   - **Audience type:** B2B or B2C. If B2B, identify the sub-variant (SMB vs.
     enterprise; technical buyer vs. executive sponsor) when the context
     supports it.
   - **Content goal:** thought leadership · awareness · lead generation ·
     nurturing · conversion · retention.
   - **Funnel stage:** TOFU · MOFU · BOFU.
   - **Audience expertise:** novice · familiar · expert.
3. Present a one-line inference summary, for example:

   > "Audience: B2B (mid-market) · Goal: lead generation · Stage: MOFU ·
   > Expertise: familiar"

4. Ask the owner to confirm or correct each value before drafting. Do not
   silently apply assumptions. If the owner overrides a value, accept the
   override and proceed with the confirmed configuration.
5. Once confirmed, **state explicitly which Layer 2 and Layer 3 variations
   from `format-guidelines.md` you will apply and why** — for example:

   > "Applying the MOFU column (PAS / BAB framework, medium CTA directness,
   > methodology proof), the lead-gen goal row (1,500–2,500 words, gated-asset
   > unlock), and the B2B authority + reciprocity persuasion mix."

If the inference is ambiguous (the context genuinely does not support a
confident guess), ask the owner the missing question directly rather than
guessing.

## Step 4: Determine the article topic and format-specific requirements

If the owner has not specified a topic, ask:

> "What should this blog article be about? You can describe the topic, share
> a key message, name a target keyword, or paste raw notes and I'll turn them
> into a draft."

Then determine — by asking if not already clear — three additional inputs that
materially shape the draft:

- **Content type** (drives length range from the format-guidelines length
  table): definitional · how-to · listicle · comparison · pillar / ultimate
  guide · POV / thought leadership · news / trend · newsletter version.
- **SEO target keyword and search intent**, if SEO is a goal. Without these,
  do not invent a target keyword — flag SEO as "not applied" in the final
  output instead.
- **Required mandatory elements** specific to this project — for example:
  - A specific word count constraint that overrides the working range
  - Mandatory section headers (e.g., "TL;DR", "Key Takeaways", "FAQ")
  - An author-bio block, disclosure footer, or compliance notice
  - Image / diagram requirements beyond the universal one-per-300–400-words
  - Internal-link minimums (some projects mandate N internal links per post)
  - Meta-description constraints

Some of these may already be in the loaded brand-specific blog-rules document
from Step 1 — if so, do not re-ask, just confirm them in working notes.

Wait for the answers, then proceed.

## Step 5: Select a storytelling framework

Read `../_shared/storytelling-frameworks.md` and follow the selection process
described there. Apply the chosen framework as the **structural spine of the
body**. The format-guidelines describe which frameworks fit which goal / stage
combinations (AIDA for TOFU / awareness, PAS / BAB for MOFU / lead gen, FAB /
4Ps for BOFU / conversion, StoryBrand for case studies and nurture, JTBD as a
topic-selection lens).

Note the choice in working notes — for example: "Using **PAS** as the body
spine; FAB for the proof zone."

## Step 6: Select persuasion principles

Read `../_shared/persuasion-principles.md` and follow its selection process.
Pick **1–3 principles** that fit the confirmed audience / goal / stage
combination, plus a pre-suasive opener strategy. The format-guidelines Layer 2
table specifies the highest-leverage principles by context:

- B2B default: authority > social proof > reciprocity
- B2C default: social proof > liking / unity > scarcity
- BOFU (both): add loss aversion + status quo bias

Note the choice in working notes — for example: "Using **Authority + Social
Proof + Reciprocity**; opener primes credibility with an original-research
stat."

## Step 7: Generate the blog article

Produce a complete blog article that:

- Opens with a strong **headline** that promises specific value and (if SEO
  is a goal) includes the target keyword
- Includes a **meta description** (~150–160 chars) drafted alongside the post
- Opens the body with a **hook** that uses one of the four mechanisms
  (curiosity gap, problem-agitation, surprise, specificity) and earns the
  scroll past the fold within 10–20 seconds
- Performs all six functional jobs (headline → hook → context → body → proof
  inserts → conclusion + CTA)
- Uses **descriptive H2 subheads every 250–350 words** that telegraph their
  section's content (layer-cake scanning test)
- Uses **1–3-sentence paragraphs**, bolded key claims (1–3 per section), and
  bulleted lists where genuinely parallel
- Applies the structural framework from Step 5 as the body spine
- Layers the 1–3 persuasion principles from Step 6 naturally — not as labeled
  callouts
- Includes a **singular primary CTA, repeated at three scroll depths** (~20%,
  ~60–70%, conclusion), with directness matching the confirmed funnel stage
- Falls within the working length range for the confirmed content type — or
  deviates intentionally with a documented rationale
- Includes **image-placement markers** (with brief alt-text descriptions)
  at the cadence required by format-guidelines and any brand-specific rule
- Suggests **internal-link targets** at the points where the funnel stage
  implies a next-step page
- Reflects tone and vocabulary from the loaded `writing-style` context
- Addresses the audience from the loaded `target-audience` context
- Is written in the language specified by the loaded `content-defaults`
  context (default: English if no setting exists)
- Satisfies every mandatory rule from any brand-specific blog-rules document
  loaded in Step 1

Internally verify against the **quality checklist** in `format-guidelines.md`
before presenting the output. If any gate fails and cannot be fixed before
delivery, surface the failure in the output rather than hiding it.

If the briefing is present, the article must serve its stated goals and key
messages.

Present the output in a clearly delimited block:

```
─────────────────────────────────────────────
Blog article draft
─────────────────────────────────────────────
Title: <H1>
Meta description: <150–160 chars>

<article body, with H2/H3 hierarchy, image placeholders,
internal-link suggestions, and the three CTA insertions>
─────────────────────────────────────────────
Word count: <N> (target: <range from content type>)
Reading time: ~<N> min
Configuration applied: <audience> · <goal> · <stage> · <expertise>
Framework: <framework name>
Persuasion principles: <list>
─────────────────────────────────────────────
```

If the output is degraded (missing required context categories or required
inputs), prepend:

```
⚠ DEGRADED OUTPUT — generated without: <list of missing categories>
```

## Step 8: Feedback

**Auto-store phase.** Before asking for feedback, review this run. For each
qualifying observation, append one tagged line to `.claude/learnings.md`
(create with standard header if missing):

```text
[cc-content:cc-content-blog-article] <concise observation> — <YYYY-MM-DD>
```

Qualifies: content preferences or constraints not already in any loaded
context file or `CLAUDE.md`; corrections the owner made to the output;
project-specific facts that would change future output (e.g., "this project
prefers POV over comprehensive coverage even on pillar pages"); accepted /
rejected suggestions deviating from best practices.

Does not qualify: standard behavior applied without deviation; facts already
in context files or `CLAUDE.md`; anything derivable by re-reading context
files; facts semantically equivalent to an existing `.claude/learnings.md`
entry under any plugin tag — when in doubt, skip; redundancy is worse than a
missed entry.

Check for the file before appending:

```bash
ls .claude/learnings.md 2>/dev/null && echo "exists" || echo "missing"
```

Standard header when creating the file:

```markdown
# Learnings

Corrections and feedback collected during content sessions.
Entries are tagged by skill and dated.

---
```

**Explicit feedback.** After the auto-store phase, ask:

> "Did this article meet expectations? If you have any corrections or notes
> for future articles, share them here — or press Enter to finish."

- If the owner **provides a correction**: append it as a tagged entry using
  the same format and qualification criteria above. Confirm total entries
  written across both phases: "✓ N learning(s) saved to `.claude/learnings.md`."
- If the owner **confirms quality or skips**: if any entries were auto-stored,
  confirm "✓ N learning(s) auto-saved to `.claude/learnings.md`." Then say
  "The article is ready. Paste it into your CMS — remember to source the
  images flagged in the placeholders and wire up the suggested internal
  links before publishing." and exit. If nothing was stored, skip the
  confirmation and exit directly.
