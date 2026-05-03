## ADDED Requirements

### Requirement: Interview owner and populate company-level context files

The onboarding skill SHALL interview the owner about their company, products, target audience, and communication style, and SHALL create the corresponding Markdown context files in `.claude/context/`.

At minimum the skill SHALL offer to create: `company-profile.md`, `buyer-personas.md`, `brand-voice.md`, `storytelling-frameworks.md`. Additional files MAY be proposed based on the owner's answers.

#### Scenario: Fresh project with no context files

- **WHEN** the owner invokes the onboarding skill in a project with an empty `.claude/context/` directory
- **THEN** the skill conducts an interview and, after confirmation, creates at least one populated file per context type the owner described, with no `TODO` placeholders remaining for answers the owner provided

#### Scenario: Owner declines to answer a question

- **WHEN** the owner skips a question during the interview
- **THEN** the corresponding file is either not created or created with an explicit `TODO: [question text]` placeholder rather than fabricated content

### Requirement: Detect and skip existing context files

Before creating any context file, the onboarding skill SHALL check whether that file already exists in `.claude/context/`. If it exists, the skill SHALL skip creation and include the file in its summary as "already present — skipped".

The skill SHALL only regenerate an existing file if the owner explicitly requests it during the interview.

#### Scenario: brand-voice.md already present

- **WHEN** the owner invokes the onboarding skill and `.claude/context/brand-voice.md` already exists
- **THEN** the skill does not modify `brand-voice.md` and its summary lists "brand-voice.md: already present — skipped"

#### Scenario: Owner requests regeneration of existing file

- **WHEN** the skill detects an existing context file and the owner explicitly says "regenerate it"
- **THEN** the skill presents the current file content, asks for confirmation before overwriting, and only proceeds after the owner confirms

### Requirement: Create context README index

The onboarding skill SHALL create `.claude/context/README.md` listing all context files present in the folder with one-line descriptions, and explaining the three-level context convention (company scope / format scope / campaign scope).

This file SHALL be created only if it does not already exist, unless the owner explicitly requests regeneration.

#### Scenario: README does not exist after onboarding

- **WHEN** the onboarding skill completes on a project where `.claude/context/README.md` did not previously exist
- **THEN** `.claude/context/README.md` exists, lists each file in the folder with a one-line description, and includes a section explaining the three scope levels

#### Scenario: README already exists

- **WHEN** `.claude/context/README.md` already exists at the start of onboarding
- **THEN** the file is not modified unless the owner explicitly requests it

### Requirement: Guide root CLAUDE.md setup

If a root-level `CLAUDE.md` does not already exist, the onboarding skill SHALL guide the owner through creating one that `@`-imports all company-level context files created during onboarding.

If `CLAUDE.md` already exists, the skill SHALL propose additions for any new context files and ask the owner before modifying the file.

#### Scenario: No CLAUDE.md exists

- **WHEN** the onboarding skill completes and no root `CLAUDE.md` existed before
- **THEN** a `CLAUDE.md` exists at the project root containing one `@.claude/context/<file> **Read when:** [trigger]` entry per company-level context file created during onboarding

#### Scenario: CLAUDE.md exists and is missing entries

- **WHEN** the onboarding skill creates a new context file and `CLAUDE.md` does not have an `@`-import for it
- **THEN** the skill proposes the missing `@`-import entry and asks the owner before adding it

### Requirement: Notify owner of missing required context before any output

If a skill requires a context file that is absent, it SHALL display a clear message naming the missing file, explaining what it would contain, and describing how to create it — before producing any output.

#### Scenario: Required context file absent at skill invocation

- **WHEN** any skill that depends on a context file is invoked and that file is absent from `.claude/context/`
- **THEN** the skill outputs a notification identifying the missing file by name and path, describing its purpose, and suggesting how to create it (e.g., "run the onboarding skill" or "copy from your n8n output")
- **THEN** the skill either halts cleanly or proceeds with an explicit degraded-output warning, never producing output as if the context were present
