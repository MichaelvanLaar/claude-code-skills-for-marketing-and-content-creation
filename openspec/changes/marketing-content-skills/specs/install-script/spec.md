## ADDED Requirements

### Requirement: Copy selected skills to target project

`install.sh` SHALL copy one or more skill folders from this repository into the `.claude/skills/` directory of a target marketing project.

The script SHALL accept skill names as positional arguments. When invoked with `--all`, it SHALL copy every skill folder under `.claude/skills/` in the source repository.

The target project root SHALL default to the current working directory. The owner MAY override it by passing `--target <path>`.

#### Scenario: Install a single named skill

- **WHEN** the owner runs `bash install.sh linkedin-post-skill` from the repository root inside a target project directory
- **THEN** `.claude/skills/linkedin-post-skill/` appears in the target project with all files from the source repository's `.claude/skills/linkedin-post-skill/`

#### Scenario: Install all skills

- **WHEN** the owner runs `bash install.sh --all`
- **THEN** every skill folder under `.claude/skills/` in the source repository is copied to the target project's `.claude/skills/`

#### Scenario: Install with explicit target path

- **WHEN** the owner runs `bash install.sh --target /path/to/project onboarding-skill`
- **THEN** `.claude/skills/onboarding-skill/` appears under `/path/to/project/.claude/skills/`

### Requirement: Skip existing skills unless update flag is given

`install.sh` SHALL not overwrite an already-installed skill folder unless the `--update` flag is supplied.

When a skill is skipped, the script SHALL report it as "already installed — skipped" in its output summary.

#### Scenario: Skill already installed without update flag

- **WHEN** the owner runs `bash install.sh linkedin-post-skill` and `.claude/skills/linkedin-post-skill/` already exists in the target
- **THEN** the existing folder is not modified and the summary reads "linkedin-post-skill: already installed — skipped"

#### Scenario: Skill already installed with update flag

- **WHEN** the owner runs `bash install.sh --update linkedin-post-skill` and the skill already exists
- **THEN** the skill folder is replaced with the source version and the summary reads "linkedin-post-skill: updated"

### Requirement: Report installation summary

After all operations, `install.sh` SHALL print a summary listing each skill with one of: `installed`, `updated`, `already installed — skipped`, or `failed: <reason>`.

The script SHALL exit with a non-zero status code if any skill failed to install.

#### Scenario: Mixed result summary

- **WHEN** `install.sh --all` processes three skills and one write operation fails
- **THEN** the summary lists each skill with its status and the script exits with code 1

#### Scenario: All skills installed successfully

- **WHEN** all requested skills are copied without error
- **THEN** the script exits with code 0 and every listed skill shows `installed` or `updated`
