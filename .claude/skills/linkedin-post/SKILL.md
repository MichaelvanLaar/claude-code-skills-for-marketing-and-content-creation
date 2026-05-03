---
name: linkedin-post
description: >
  Use this skill when the owner wants to write, draft, or generate a LinkedIn post.
  Invoke when the user says "write a LinkedIn post", "draft a post for LinkedIn",
  "create a LinkedIn update", "generate a LinkedIn post", or "post on LinkedIn".
allowed-tools: Read, Write, Bash
argument-hint: "[optional: path to campaign briefing file]"
---

@.claude/context/brand-voice.md **Read when:** generating any written post content
@.claude/context/buyer-personas.md **Read when:** targeting a specific audience segment
@.claude/context/company-profile.md **Read when:** reflecting company positioning in the post
@.claude/context/samples.md **Read when:** samples file is present and owner requests on-brand examples

# LinkedIn Post Skill

You are helping the owner produce a complete, publishable LinkedIn post. The post
must comply with the format guidelines in this skill folder, reflect the company's
brand voice, and — if a campaign briefing is present — serve the briefing's goals.

## Step 1: Check required context files

Before generating anything, verify that the three required context files exist.

Run:

```bash
ls .claude/context/brand-voice.md .claude/context/buyer-personas.md .claude/context/company-profile.md 2>/dev/null
```

For each file that is **absent**, report:

> "⚠ Required context file missing: `.claude/context/<filename>`
> This file provides [purpose]. Without it, the generated post will lack [impact].
> To create it, run the onboarding skill (`/onboarding`)."

After reporting all missing files, ask:

> "Shall I proceed and generate a degraded draft (labelled ⚠ DEGRADED OUTPUT), or
> would you prefer to run the onboarding skill first?"

- If the owner chooses to **proceed**: label the final output `⚠ DEGRADED OUTPUT —
one or more required context files were missing during generation.`
- If the owner chooses to **onboard first**: say "Please run the onboarding skill,
  then invoke this skill again." and stop.

If **all three files exist**, proceed silently to Step 2.

## Step 2: Check for campaign briefing

Determine the briefing path:

1. If the owner passed a file path as an argument (`$ARGUMENTS`), use that path.
2. Otherwise, check for `brief.md` in the current working directory:

```bash
ls brief.md 2>/dev/null && echo "found" || echo "missing"
```

- **Found** (either via argument or `brief.md`): read the file and note its key
  messages, goals, and constraints. Confirm: "✓ Campaign briefing loaded from
  `<path>`."
- **Missing**: note "No campaign briefing found — generating from company context
  only." and continue.

## Step 3: Load context files

Read each file that exists:

- `.claude/context/brand-voice.md`
- `.claude/context/buyer-personas.md`
- `.claude/context/company-profile.md`
- `.claude/context/samples.md` (read only if the file exists and the owner has
  not explicitly opted out of using samples as reference)

Also read the format guidelines for this skill:

```bash
cat .claude/skills/linkedin-post/format-guidelines.md
```

## Step 4: Ask for the post topic (if not already provided)

If the owner has not specified a topic or goal for the post, ask:

> "What should this post be about? You can describe the topic, share a key message
> you want to convey, or paste raw notes and I'll turn them into a post."

Wait for the answer, then proceed.

## Step 5: Generate the post

Produce a complete LinkedIn post that:

- Opens with a strong hook in the first 1–2 lines (visible before the "see more" fold)
- Includes a body delivering the substance the hook promises
- Ends with a specific, singular CTA
- Includes 3–5 hashtags after the CTA (CamelCase, separated from body by a blank line)
- Stays within the recommended character target (1,200–1,800 characters)
- Reflects tone and vocabulary from `brand-voice.md`
- Addresses the audience segment(s) from `buyer-personas.md`
- Does NOT embed a link in the post body (reference "first comment" if a link is needed)

Internally verify against the quality checklist in `format-guidelines.md` before
presenting the output.

If the briefing is present, the post must serve its stated goals and key messages.

Present the post in a clear block:

```
─────────────────────────────────────────────
LinkedIn post draft
─────────────────────────────────────────────
<post content>
─────────────────────────────────────────────
Character count: <N> / 3,000
```

If the output is degraded (missing context files), prepend:

```
⚠ DEGRADED OUTPUT — generated without: <list of missing files>
```

## Step 6: Feedback

After presenting the post, ask:

> "Did this post meet expectations? If you have any corrections or notes for
> future posts, share them here — or press Enter to finish."

- If the owner **provides a correction**: append a tagged, dated entry to
  `.claude/learnings.md`:

  ```
  [linkedin-post] <correction summary> — <YYYY-MM-DD>
  ```

  Check whether `.claude/learnings.md` exists:

  ```bash
  ls .claude/learnings.md 2>/dev/null && echo "exists" || echo "missing"
  ```

  If missing, create it with a header before appending:

  ```markdown
  # Learnings

  Corrections and feedback collected during content sessions.
  Entries are tagged by skill and dated.

  ---
  ```

  After appending, confirm: "✓ Feedback saved to `.claude/learnings.md`."

- If the owner **confirms quality or skips**: say "Great — the post is ready to
  publish. Copy it above and paste directly into LinkedIn." and exit.
