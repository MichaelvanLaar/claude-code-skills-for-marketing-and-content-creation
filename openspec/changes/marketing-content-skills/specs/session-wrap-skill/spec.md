## ADDED Requirements

### Requirement: Review deliverables produced during the session

The session-wrap skill SHALL summarize files changed or created during the current session by reading git status and listing modified files grouped by type (context files, deliverables, skill files, other).

#### Scenario: Session produced deliverables

- **WHEN** the owner invokes the session-wrap skill after producing content
- **THEN** the skill lists all modified or untracked files, grouped by type, before soliciting feedback

#### Scenario: No changes detected

- **WHEN** git status reports no changes
- **THEN** the skill notes "no changes detected" and asks whether to proceed with feedback collection anyway

### Requirement: Collect feedback for each skill used during the session

The session-wrap skill SHALL ask the owner which output-format skills were used during the session and, for each, prompt for feedback (did the output meet expectations? any corrections?).

For each correction provided, the skill SHALL append a tagged, dated entry to `.claude/learnings.md`:

```
[<skill-name>] <correction summary> — <YYYY-MM-DD>
```

#### Scenario: Owner reports a correction for one skill

- **WHEN** the owner identifies a skill used during the session and describes a correction
- **THEN** the skill appends `[<skill-name>] <correction> — <YYYY-MM-DD>` to `.claude/learnings.md`

#### Scenario: Owner reports no corrections

- **WHEN** the owner indicates all skills performed acceptably
- **THEN** no entries are appended to `.claude/learnings.md` and the skill proceeds to the commit step

### Requirement: Surface recurring correction patterns

The session-wrap skill SHALL read `.claude/learnings.md` and group entries by skill tag. When three or more entries with the same skill tag express similar corrections, the skill SHALL surface them grouped and ask whether to promote the pattern.

Similarity SHALL be determined by semantic grouping, not exact string match.

Promotion means: the owner is shown the grouped entries and asked whether to (a) add a rule to the skill's format guidelines, (b) add a rule to the project `CLAUDE.md`, or (c) dismiss the group.

#### Scenario: Recurring pattern detected

- **WHEN** `.claude/learnings.md` contains three or more entries tagged `[linkedin-post-skill]` with semantically similar corrections
- **THEN** the skill surfaces them as a group and asks the owner to promote, add to CLAUDE.md, or dismiss

#### Scenario: No recurring patterns

- **WHEN** no skill tag has three or more similar entries
- **THEN** the skill skips the pattern-surfacing step and proceeds to commit

### Requirement: Create a git commit following Conventional Commits with gitmoji

After feedback collection, the session-wrap skill SHALL propose a git commit covering all staged and unstaged changes. The commit message SHALL follow the Conventional Commits format and include a gitmoji.

The skill SHALL stage files explicitly (not `git add -A`) and SHALL show the proposed commit message to the owner before committing.

#### Scenario: Owner approves proposed commit

- **WHEN** the skill proposes a commit message and the owner confirms
- **THEN** the skill stages the relevant files, creates the commit with the proposed message, and confirms the commit hash

#### Scenario: Owner requests a different commit message

- **WHEN** the owner rejects the proposed message and provides an alternative
- **THEN** the skill uses the owner's message and creates the commit

#### Scenario: No changes to commit

- **WHEN** git status shows nothing to commit after feedback collection
- **THEN** the skill skips the commit step and closes with a session summary
