## ADDED Requirements

### Requirement: Walk owner through identifying a content example

The samples-curation skill SHALL prompt the owner to provide or identify a piece of content they consider gold-standard for a particular output type. The owner SHALL be able to paste content directly or provide a file path.

#### Scenario: Owner pastes content inline

- **WHEN** the owner invokes the samples-curation skill and pastes a piece of content when prompted
- **THEN** the skill acknowledges the content and proceeds to the annotation step

#### Scenario: Owner provides a file path

- **WHEN** the owner provides a path to a Markdown or plain-text file
- **THEN** the skill reads the file and proceeds to the annotation step with that content

### Requirement: Guide annotation of the content example

Before saving, the samples-curation skill SHALL guide the owner through annotating the example with:

- Output type (e.g., "LinkedIn post", "blog article intro")
- What makes this example good (key qualities the owner identifies)
- Any caveats or context (e.g., "works for B2B audience, not B2C")

#### Scenario: Owner completes annotation

- **WHEN** the owner answers the annotation questions
- **THEN** the skill presents a formatted preview of the entry (content + annotation) before asking for confirmation

#### Scenario: Owner skips an annotation field

- **WHEN** the owner declines to answer an annotation question
- **THEN** that field is omitted from the entry rather than filled with a placeholder

### Requirement: Append confirmed entry to samples context file

Only after explicit owner confirmation, the samples-curation skill SHALL append the annotated example to `.claude/context/samples.md`.

If `.claude/context/samples.md` does not exist, the skill SHALL create it with an appropriate header before appending.

The skill SHALL never overwrite existing entries — it SHALL only append.

#### Scenario: Owner confirms and samples.md exists

- **WHEN** the owner confirms the annotated example and `.claude/context/samples.md` already exists
- **THEN** the entry is appended to the end of the file and the skill confirms the file path and entry count

#### Scenario: Owner confirms and samples.md does not exist

- **WHEN** the owner confirms and `.claude/context/samples.md` does not exist
- **THEN** the skill creates the file with a header and appends the entry

#### Scenario: Owner declines to save

- **WHEN** the owner reviews the preview and says "no" or "cancel"
- **THEN** no file is written or modified and the skill offers to start over or exit

### Requirement: Allow curating multiple examples in one session

The samples-curation skill SHALL ask the owner after each saved entry whether they want to curate another example. The skill SHALL loop until the owner declines.

#### Scenario: Owner curates two examples in sequence

- **WHEN** after the first entry is saved the owner says "yes, add another"
- **THEN** the skill restarts the identification and annotation steps for a new example
- **THEN** both entries are present in `.claude/context/samples.md` after the session ends
