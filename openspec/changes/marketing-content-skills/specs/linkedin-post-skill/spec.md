## ADDED Requirements

### Requirement: Declare and load company-level context via progressive disclosure

The linkedin-post-skill SHALL declare all company-level context files it reads using `@path **Read when:** [trigger]` syntax in its SKILL.md frontmatter/body. It SHALL read at minimum: `brand-voice.md`, `buyer-personas.md`, and `company-profile.md` from `.claude/context/`.

Format-specific guidelines (post length, structure, tone calibration) SHALL reside inside the skill's own folder, not in `.claude/context/`.

#### Scenario: Context files present at invocation

- **WHEN** all declared context files exist in `.claude/context/` and the skill is invoked
- **THEN** the skill loads each context file before generating output and the generated post demonstrably reflects brand voice and persona constraints

#### Scenario: Required context file absent

- **WHEN** a required context file (e.g., `brand-voice.md`) is absent
- **THEN** the skill notifies the owner by name and path before producing any output, and either halts or proceeds with an explicit degraded-output label

### Requirement: Accept optional campaign briefing

The linkedin-post-skill SHALL accept an optional campaign briefing document. The owner MAY pass a file path as an argument, or the skill SHALL look for a `brief.md` in the current working directory if no argument is given.

If no briefing is found, the skill SHALL proceed without it and note the absence.

#### Scenario: Briefing found in current working directory

- **WHEN** the owner invokes the skill from a campaign folder containing `brief.md`
- **THEN** the generated post reflects the briefing's stated goals, key messages, and constraints

#### Scenario: Briefing path passed as argument

- **WHEN** the owner invokes the skill with an explicit briefing file path
- **THEN** the skill reads that file and incorporates it into the post

#### Scenario: No briefing present

- **WHEN** no `brief.md` exists and no path is supplied
- **THEN** the skill notes "no campaign briefing found — generating from company context only" and proceeds

### Requirement: Produce a complete, publishable LinkedIn post

The skill SHALL produce a LinkedIn post that:

- Complies with format-scope guidelines stored in the skill folder (character limits, hook structure, CTA conventions, hashtag rules)
- Reflects the brand voice from context
- Is presented ready to copy-paste, with no further editing required for format compliance

#### Scenario: Post meets format guidelines

- **WHEN** the skill generates a LinkedIn post
- **THEN** the output fits within the LinkedIn character limit defined in the skill's format-guidelines file
- **THEN** the post includes a hook, body, and CTA as defined in the skill's structure rules

#### Scenario: Post reflects brand voice

- **WHEN** `brand-voice.md` is present and the post is generated
- **THEN** tone, vocabulary, and style are consistent with the guidelines in that file

### Requirement: End with explicit feedback step

After presenting the generated post, the linkedin-post-skill SHALL prompt the owner whether the output met expectations.

If the owner provides a correction, the skill SHALL append a tagged entry to `.claude/learnings.md`:

```
[linkedin-post-skill] <correction summary> — <YYYY-MM-DD>
```

If the owner confirms the output is acceptable, nothing is logged.

The feedback prompt SHALL be skippable — if the owner dismisses it without a correction, the skill exits cleanly.

#### Scenario: Owner provides a correction

- **WHEN** the owner responds to the feedback prompt with a correction
- **THEN** the skill appends a tagged, dated entry to `.claude/learnings.md` before closing

#### Scenario: Owner confirms quality

- **WHEN** the owner responds positively or dismisses the prompt
- **THEN** no entry is appended to `.claude/learnings.md` and the skill exits with a confirmation message
