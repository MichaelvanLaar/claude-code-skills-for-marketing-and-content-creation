# Requirements Document: Marketing & Business Skills Repository

**Version**: 1.0  
**Date**: 2026-05-02  
**Status**: Draft

---

## 1. Document Purpose

This document captures the requirements for a Claude Code skills repository dedicated to
marketing and content creation workflows. It describes what the skill collection must do
and what quality properties it must exhibit. It intentionally does not prescribe
implementation decisions — those belong in the design and planning phase.

This document is the recommended input for Claude Code plan mode and for OpenSpec.

---

## 2. Business Context

### 2.1 Problem Statement

The owner uses Claude Code for both software development and marketing/content work, but
no organized skill library exists for the latter. Marketing projects involve a rich,
multi-layered context — company profiles, buyer personas, brand voice guidelines,
reference books, storytelling frameworks, output format rules, and campaign briefings —
that is currently managed through ad-hoc files and external tools. Without a structured
skill library, this context cannot be reliably loaded, shared, or compounded across
sessions, forcing repeated manual setup and producing inconsistent output quality.

### 2.2 Business Goals

- **BG-01**: Reduce the time required to produce on-brand, high-quality marketing
  deliverables by making all relevant context automatically available when Claude Code
  starts a session in any project folder.
- **BG-02**: Eliminate copy-pasting of context files across projects by establishing a
  single-source-of-truth architecture that all skills read from.
- **BG-03**: Create a reusable, extensible skill library that grows alongside the owner's
  marketing practice without requiring structural changes to existing skills.
- **BG-04**: Integrate cleanly with existing external tools (n8n brand voice pipeline,
  requirements-engineering skill, cc-init configuration convention from https://github.com/MichaelvanLaar/claude-code-config-skills) rather than replacing
  them.

### 2.3 Success Criteria

- A session started in any campaign subfolder of a marketing monorepo automatically
  provides Claude Code with all relevant company-level and campaign-level context, without
  any manual setup per session.
- A new output-format skill can be added to the repository without modifying any existing
  skill or shared infrastructure file.
- Skills produce output that demonstrably reflects the company's brand voice, buyer
  personas, and campaign briefing when those context files are present.
- A skill invoked without a required context file notifies the owner of the missing file
  and suggests how to create it, rather than producing generic output silently.

---

## 3. Stakeholders and Users

| Role             | Description                                                                                                           | Primary Needs                                                                                                 |
| ---------------- | --------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------- |
| Content owner    | The primary user; a technically proficient solo operator who manages both coding and marketing projects               | Skills that leverage existing context without manual re-setup; output that is on-brand and immediately usable |
| Future installer | A technically proficient user who installs these skills into their own marketing project (if the repo becomes public) | Clear installation instructions; skills that work with their own context structure without modification       |

---

## 4. Scope

### 4.1 In Scope

- A Claude Code skills repository containing reusable skills for marketing and content
  creation workflows.
- A three-level context architecture (company scope / format scope / campaign scope) that
  skills follow and enforce.
- Foundation skills for onboarding a new marketing project: populating company-level
  context files and establishing the CLAUDE.md hierarchy.
- A samples-curation skill for capturing and maintaining gold-standard content examples.
- Output-format-specific skills, each self-contained with its own format guidelines and
  referencing shared company-level context.
- A session wrap-up skill for structured end-of-session feedback collection and learning
  consolidation.
- An installation and update mechanism consistent with the cc-init/cc-update convention from https://github.com/MichaelvanLaar/claude-code-config-skills .
- Guidance on the hierarchical CLAUDE.md pattern for multi-level marketing monorepos.

### 4.2 Out of Scope

- Brand voice extraction from URLs or documents — this is handled by an existing external
  n8n workflow and shall not be replicated.
- Auto-publishing or direct posting to any platform (LinkedIn, CMS, email) — skills
  produce content for human review; distribution is the owner's responsibility.
- A GUI or web dashboard for managing sessions or tasks (the Command Center concept) —
  the terminal interface is sufficient for the primary user.
- Multi-user access control or role-based permissions — the system serves a solo operator
  or very small team.
- Replacing or duplicating cc-init, cc-optimize, or cc-update functionality from https://github.com/MichaelvanLaar/claude-code-config-skills .
- Analytics or performance tracking of published content.

---

## 5. Functional Requirements

Priorities: **Must** (launch-critical) | **Should** (important, can defer) |
**Could** (nice-to-have) | **Won't** (explicitly excluded this release)

### 5.1 Project Setup and Onboarding

**FR-001** [Must]  
The repository shall provide an installation script that copies selected skills into the
`.claude/skills/` directory of a target marketing project, consistent with the mechanism
used by cc-init from https://github.com/MichaelvanLaar/claude-code-config-skills .  
_Rationale_: BG-03 — the skill set must be portable across different marketing projects
without manual file copying.  
_Fit criterion_: Running the installation script on a clean marketing project results in
all selected skill folders appearing under `.claude/skills/` with no manual file
operations required from the user.

**FR-002** [Must]  
The repository shall provide an update skill that refreshes installed skills from the
source repository, consistent with the cc-update mechanism from https://github.com/MichaelvanLaar/claude-code-config-skills .  
_Rationale_: BG-03 — as skills evolve, existing installations must be updatable without
reinstalling from scratch.  
_Fit criterion_: Running the update skill replaces installed skill files with the latest
versions from the source repository and reports which skills were updated, skipped, or
failed.

**FR-003** [Must]  
The repository shall provide an onboarding skill that interviews the owner about their
company and populates missing company-level context files in `.claude/context/`.  
_Rationale_: BG-01, BG-02 — the context layer must be populated before any execution
skill can produce on-brand output, and the interview approach avoids requiring the owner
to know the exact file structure in advance.  
_Fit criterion_: After running the onboarding skill, `.claude/context/` contains at least
one populated file per context type the owner described, with no `TODO` placeholders
remaining for answers the owner provided during the interview.

**FR-004** [Must]  
The onboarding skill shall detect each type of context file before creating it, and skip
generation for any file that already exists (e.g., a `brand-voice.md` produced by an
external n8n pipeline), unless the owner explicitly requests regeneration.  
_Rationale_: BG-04 — existing tools produce authoritative context files; the skill must
not overwrite them silently.  
_Fit criterion_: Running the onboarding skill on a project that already contains a
`brand-voice.md` does not modify that file, and the skill's summary lists it as "already
present — skipped."

**FR-005** [Must]  
The onboarding skill shall create a `.claude/context/README.md` index listing all context
files present and explaining the three-level context convention (company scope /
format scope / campaign scope), unless such a file already exists.  
_Rationale_: BG-02 — the single-source-of-truth architecture requires that the
convention be documented in the project so all future contributors (human or AI) follow
it.  
_Fit criterion_: After the onboarding skill runs, `.claude/context/README.md` exists,
lists all files in the folder with one-line descriptions, and states what belongs at each
scope level.

**FR-006** [Should]  
The onboarding skill shall guide the owner through creating a root-level `CLAUDE.md` that
@-imports all company-level context files from `.claude/context/`, if a root `CLAUDE.md`
does not already exist.  
_Rationale_: BG-01 — without the root CLAUDE.md, company-level context is not
automatically available to Claude Code sessions.  
_Fit criterion_: After guidance is complete, the root `CLAUDE.md` contains one
`@.claude/context/<file> **Read when:** [trigger]` entry per company-level context file
created during onboarding.

**FR-007** [Should]  
The repository shall provide written guidance (in its own `CLAUDE.md` or `README.md`) on
how to set up hierarchical CLAUDE.md files at each directory level of a marketing
monorepo, so that a session started in any campaign subfolder automatically inherits all
relevant context without requiring skills to contain hard-coded paths to shared files.  
_Rationale_: BG-01 — the hierarchical CLAUDE.md pattern is the mechanism that eliminates
per-session context setup, but it must be actively maintained by the owner as the folder
structure grows.  
_Fit criterion_: The guidance document explains the three levels, provides a concrete
example folder structure, and includes a sample CLAUDE.md for each level.

### 5.2 Context Management

**FR-010** [Must]  
Each skill in the repository shall declare, within its `SKILL.md`, which company-level
context files it reads (from `.claude/context/`) and which format-level files it reads
(from its own skill folder), using progressive disclosure `@`-import syntax.  
_Rationale_: BG-02 — explicit context declarations make the architecture self-documenting
and allow cc-optimize (from https://github.com/MichaelvanLaar/claude-code-config-skills) to audit scope violations.  
_Fit criterion_: Reading any `SKILL.md` in the repository reveals the complete list of
context files that skill will read, without needing to inspect the skill's logic.

**FR-011** [Must]  
Each skill shall gracefully handle missing optional context files by notifying the owner
of which file is absent, explaining what it would contain and how to create it, and then
either proceeding with degraded output or halting cleanly — never producing generic
output silently as if the context were present.  
_Rationale_: BG-01, BG-03 — silent degradation produces low-quality output that
undermines trust in the system; explicit notification preserves output quality and guides
the owner to complete the context layer.  
_Fit criterion_: Invoking a skill when a declared required context file is absent results
in a clear message naming the missing file and suggesting how to create it, before the
skill produces any output.

**FR-012** [Must]  
Company-level context files shall reside exclusively in `.claude/context/`. Skills shall
not maintain private copies of company-level context within their own folders.  
_Rationale_: BG-02 — a single source of truth means one file to update; private copies
drift and produce inconsistent output.  
_Fit criterion_: No file in any skill's subfolder duplicates content that is also present
in `.claude/context/`.

**FR-013** [Must]  
Format-level guidelines (structure rules, length conventions, tone calibrations specific
to one output type) shall reside inside the relevant skill's own folder, not in
`.claude/context/`.  
_Rationale_: BG-03 — keeping format-level knowledge with its skill makes the skill
self-contained and independently installable.  
_Fit criterion_: Removing any single output-format skill's folder from the repository
leaves all other skills and the shared `.claude/context/` folder unmodified.

**FR-014** [Should]  
The repository shall provide a samples-curation skill that helps the owner identify,
annotate, and store gold-standard content examples in a designated context file
(e.g., `.claude/context/samples.md`).  
_Rationale_: BG-01 — real examples of approved output are one of the highest-signal
context inputs for generating on-brand content; without a curation skill, this file is
rarely maintained.  
_Fit criterion_: Running the samples-curation skill results in at least one annotated
example appended to the samples context file, with the owner's explicit confirmation
before saving.

### 5.3 Output Format Skills

**FR-020** [Must]  
The repository shall include at least one fully implemented output-format skill at the
time of initial release.  
_Rationale_: BG-01 — a foundation layer alone does not produce deliverables; at least
one execution skill is required to demonstrate end-to-end value.  
_Fit criterion_: The initial release contains a skill that produces a complete,
publishable marketing deliverable (e.g., a blog article or LinkedIn post) when provided
with the required context.

**FR-021** [Must]  
Each output-format skill shall be self-contained: all format-specific guidelines required
to produce correct output shall be stored within the skill's own folder and shall not
depend on files in `.claude/context/` for format logic.  
_Rationale_: BG-03, FR-013 — self-contained skills can be installed individually;
removing an unneeded skill does not break others.  
_Fit criterion_: An output-format skill installed in isolation (without any other skill
from this repository) produces structurally correct output for its format when provided
with the required context files.

**FR-022** [Must]  
Each output-format skill shall accept an optional campaign-level briefing document as
input, reading it from the current working directory or a path specified by the owner at
invocation time.  
_Rationale_: BG-01 — campaign-specific briefs directly inform the output; a skill that
ignores them requires the owner to manually paste briefing content into each session.  
_Fit criterion_: Invoking an output-format skill from a campaign subfolder that contains
a briefing document results in output that demonstrably reflects the briefing's goals
and constraints.

**FR-023** [Must]  
Each output-format skill shall end with a feedback step that explicitly asks the owner
whether the output met expectations and, if not, logs a one-line correction to
`.claude/learnings.md` tagged with the skill name.  
_Rationale_: BG-01 — for creative work, there is no automated pass/fail signal; the
feedback step makes the learning loop active rather than passive, improving output
quality over time.  
_Fit criterion_: After producing output, every output-format skill presents a prompt
asking for feedback and, upon receiving a correction, appends a tagged entry to
`.claude/learnings.md` before closing.

### 5.4 Session Wrap-up

**FR-030** [Should]  
The repository shall provide a session-wrap skill that guides the owner through an
end-of-session routine: reviewing deliverables produced, collecting any outstanding
feedback for skills used during the session, and committing all work.  
_Rationale_: BG-01 — structured session closure ensures learnings are captured before
context is lost and that deliverables are not left in an uncommitted state.  
_Fit criterion_: Running the session-wrap skill produces a summary of files changed
during the session, solicits feedback for each skill that produced output, appends
feedback to `.claude/learnings.md`, and creates a git commit following the Conventional
Commits with gitmoji convention.

**FR-031** [Should]  
The session-wrap skill shall read `.claude/learnings.md` and surface any recurring
patterns (three or more similar corrections) for the owner to review, flagging them as
candidates for promotion into a skill's format guidelines or the owner's CLAUDE.md.  
_Rationale_: BG-03 — recurring corrections that are not promoted remain noise in the
learnings file and are not compounded into permanent skill improvement.  
_Fit criterion_: When `.claude/learnings.md` contains three or more entries tagged with
the same skill name and expressing similar corrections, the session-wrap skill surfaces
them grouped and asks whether to promote them.

---

## 6. Non-Functional Requirements

NFRs adapted to the context of a Claude Code skills repository, where the "system" is a
set of markdown instruction files executed by an AI agent rather than a deployed
application.

### 6.1 Consistency (equivalent to Reliability)

**NFR-001** [Must]  
All skills in the repository shall follow the same structural conventions: SKILL.md
frontmatter (name, description, allowed-tools, argument-hint), explicit context
declarations, a feedback step, and conformance to the quality rules in cc-init's (from https://github.com/MichaelvanLaar/claude-code-config-skills) skill
guidance.  
_Fit criterion_: cc-optimize (from https://github.com/MichaelvanLaar/claude-code-config-skills), when run on any marketing project that has installed these
skills, reports no structural violations for any installed skill.

**NFR-002** [Must]  
A skill shall produce output in the correct format regardless of whether optional context
files are present — it shall either complete with degraded output and an explicit
notification, or halt cleanly with instructions, but shall never crash or produce an
unformatted error message.  
_Fit criterion_: Invoking any skill with all optional context files absent results in
either a structured degraded-output notification or a clean halt with actionable guidance,
with no raw error text presented to the owner.

### 6.2 Maintainability

**NFR-010** [Must]  
Adding a new output-format skill to the repository shall require no changes to any
existing skill, to the installation script, or to any shared file in `.claude/context/`.  
_Fit criterion_: A new skill folder can be added and installed without touching any
pre-existing file in the repository, verified by checking git diff for unintended
modifications.

**NFR-011** [Must]  
Each skill shall be updatable independently of other skills — installing an updated
version of one skill shall not require updating any other skill.  
_Fit criterion_: The update mechanism can target a single named skill and replace only
that skill's files.

**NFR-012** [Should]  
The repository's own `CLAUDE.md` or `README.md` shall document the authoring conventions
for new skills, so that a new skill added to the repository by the owner follows the same
structural patterns without requiring review of all existing skills.  
_Fit criterion_: Following only the authoring documentation, a new skill can be created
that passes cc-optimize's (from https://github.com/MichaelvanLaar/claude-code-config-skills) skills audit without corrections.

### 6.3 Portability

**NFR-020** [Must]  
Skills shall operate correctly when installed in any marketing project repository that
follows the `.claude/context/` convention established by cc-init (from https://github.com/MichaelvanLaar/claude-code-config-skills), without requiring
modifications specific to that project.  
_Fit criterion_: A skill installed into two different marketing project repositories, each
with their own `.claude/context/` contents, produces structurally correct output in both
without modification to the skill itself.

**NFR-021** [Must]  
Skills shall not depend on absolute file paths. All context file references shall be
relative to the repository root or expressed as progressive disclosure `@`-imports
resolved by Claude Code's path conventions.  
_Fit criterion_: No `SKILL.md` file contains an absolute filesystem path.

### 6.4 Usability

**NFR-030** [Must]  
An owner who has previously used cc-init (from https://github.com/MichaelvanLaar/claude-code-config-skills) shall be able to install and invoke a skill from
this repository without reading the source of the skill — the skill's description in its
frontmatter shall be sufficient to understand when and how to invoke it.  
_Fit criterion_: The skill description field alone (without reading the skill body)
correctly answers: what does this skill do, when should I use it, and what do I need to
provide?

**NFR-031** [Should]  
The onboarding skill shall complete its interview and context file generation in a single
session of under 30 minutes for a user who has their business information readily
available.  
_Fit criterion_: [ASSUMPTION — to be confirmed by first use] A representative run of the
onboarding skill from a blank `.claude/context/` folder to a fully populated state takes
under 30 minutes of interactive dialogue.

### 6.5 Safety and Data Integrity

**NFR-040** [Must]  
No skill shall modify or delete an existing context file without explicit owner
confirmation.  
_Fit criterion_: Any skill action that would overwrite an existing file in `.claude/context/`
presents a confirmation prompt with the current file content and the proposed change
before writing.

**NFR-041** [Must]  
No skill shall commit sensitive information (API keys, personal credentials, client PII
beyond what the owner has already placed in context files) to git.  
_Fit criterion_: Skills do not read files matching `.env`, `.env.*`, or `secrets/`
patterns, and the repository's `.gitignore` excludes those patterns.

---

## 7. Constraints

| ID      | Constraint                                                                                                                                                                                                                             | Source                                                                                         |
| ------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------- |
| CON-001 | Skills must conform to the Claude Code SKILL.md architecture (frontmatter, markdown instruction format) and must be placed in `.claude/skills/<skill-name>/SKILL.md`                                                                   | Claude Code platform requirement                                                               |
| CON-002 | Company-level context must follow the `.claude/context/` folder convention established by cc-init (from https://github.com/MichaelvanLaar/claude-code-config-skills); the marketing skills repo must not define a competing convention | Interoperability with cc-init from https://github.com/MichaelvanLaar/claude-code-config-skills |
| CON-003 | The onboarding skill must not regenerate context files that already exist from external tools (n8n brand voice pipeline, requirements-engineering skill) unless the owner explicitly requests it                                       | Integration constraint — existing tools are authoritative for their outputs                    |
| CON-004 | Any git commits created by skills must use Conventional Commits format with gitmoji, consistent with the owner's established commit convention                                                                                         | Owner workflow convention                                                                      |
| CON-005 | The repository must not duplicate functionality already provided by cc-init, cc-optimize, or cc-update from https://github.com/MichaelvanLaar/claude-code-config-skills                                                                | Scope boundary — the two repos are complementary, not overlapping                              |
| CON-006 | Skills must work without any internet access at runtime — they may not rely on live web fetching unless an MCP server for that purpose is explicitly declared as a dependency in the skill's frontmatter                               | Offline operation requirement                                                                  |

---

## 8. Assumptions

| ID      | Assumption                                                                                                                                                                   | Impact if wrong                                                                                                                                         |
| ------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------- |
| ASS-001 | The owner has Claude Code installed and a project configured via cc-init (or equivalent), so `.claude/context/` and `.claude/settings.json` conventions are already in place | Onboarding skill would need to cover cc-init (from https://github.com/MichaelvanLaar/claude-code-config-skills) setup steps; significant scope increase |
| ASS-002 | Marketing projects are organized as git repositories with a company-level root directory and campaign or project subfolders below it                                         | The hierarchical CLAUDE.md pattern and the session-wrap commit step would not apply; folder guidance would need to be redesigned                        |
| ASS-003 | A brand-voice.md (or equivalent) may already exist in `.claude/context/` for many projects, produced by the owner's n8n pipeline                                             | If this file never pre-exists, the onboarding skill's detection-and-skip logic is unnecessary complexity; can be simplified                             |
| ASS-004 | The primary user is a solo operator or very small team; multi-user collaboration and role-based access to context files are not required                                     | If team collaboration becomes a requirement, file locking, branching strategies, and access control would need to be added                              |
| ASS-005 | Skills produce content for human review before publishing; no automated distribution pipeline connects skill output directly to a publishing platform                        | If auto-publishing is required, significant safeguards (approval gates, rollback, audit log) would become Must requirements                             |
| ASS-006 | The skill set will remain under active development and will expand over time; the initial release intentionally covers only a subset of output formats                       | If the skill set is expected to be feature-complete at release, the MoSCoW priorities and scope would need revisiting                                   |
| ASS-007 | Context files in `.claude/context/` are plain Markdown and do not require encryption or access restriction beyond standard filesystem permissions                            | If client confidentiality requires encryption at rest, a secrets management approach would become a security requirement                                |

---

## 9. Open Questions

| ID     | Question                                                                                                                                                                                                                                               | Owner   | Due                   |
| ------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | ------- | --------------------- |
| OQ-001 | Which specific output formats should be included in the initial release? (Candidates from conversations: blog article, LinkedIn post, whitepaper, webinar outline, newsletter)                                                                         | Michael | Before planning phase |
| OQ-002 | Should the repository be public (like cc-init from https://github.com/MichaelvanLaar/claude-code-config-skills) or remain private? This affects how strongly generic usability and documentation must be requirements.                                 | Michael | Before planning phase |
| OQ-003 | Should the repo include a skill for scaffolding the hierarchical CLAUDE.md structure across campaign subfolders, or is written guidance sufficient?                                                                                                    | Michael | Before planning phase |
| OQ-004 | Should there be a dedicated skill for curating and updating `samples.md` as new gold-standard content is created, or is this handled ad-hoc as part of the session-wrap skill?                                                                         | Michael | Before planning phase |
| OQ-005 | Is one marketing monorepo per company the intended model, or will there be cases where a single skills installation serves multiple clients with isolated context? If the latter, client-specific context isolation becomes a functional requirement.  | Michael | Before planning phase |
| OQ-006 | Should the storytelling frameworks file and reference book content (e.g., Cialdini's Pre-suasion) be included in the skills repo itself (as shared reference material), or should they always be owner-maintained context files in `.claude/context/`? | Michael | Before planning phase |

---

## 10. Glossary

| Term                          | Definition                                                                                                                                                                                                                     |
| ----------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| Campaign scope                | Context specific to one marketing initiative or project, stored in a regular subfolder of the monorepo (not in `.claude/context/`)                                                                                             |
| Company scope                 | Context that applies to all work for a given company or project, stored in `.claude/context/` at the repository root                                                                                                           |
| Context file                  | A Markdown file containing domain knowledge (e.g., brand voice, buyer personas) that skills load via progressive disclosure rather than inlining                                                                               |
| Format scope                  | Guidelines specific to one output type (e.g., whitepaper structure rules), stored inside the skill folder that produces that output type                                                                                       |
| Hierarchical CLAUDE.md        | A pattern in which each directory level of a monorepo has its own `CLAUDE.md` file that @-imports context relevant to that level; Claude Code reads these files up the directory tree when starting a session in any subfolder |
| n8n workflow                  | The owner's existing external automation that extracts brand voice from URLs and text input, producing a `brand-voice.md` (or equivalent) that the onboarding skill shall detect and not overwrite                             |
| Output-format skill           | A self-contained Claude Code skill that produces one type of marketing deliverable (e.g., a blog article), carrying its own format guidelines and referencing shared context via progressive disclosure                        |
| Progressive disclosure        | A CLAUDE.md pattern in which large reference files are not inlined but referenced via `@path **Read when:** [trigger condition]`, so Claude Code loads them only when needed, reducing baseline token consumption              |
| Session wrap-up               | An end-of-session routine (implemented as a skill) that collects feedback, updates the learnings file, and commits work                                                                                                        |
| Three-level context hierarchy | The architectural principle that distinguishes company-scope context (`.claude/context/`), format-scope context (inside skill folders), and campaign-scope context (regular project subfolders)                                |

---

_This document was produced using requirements engineering best practices based on
IEEE/IEC/ISO 29148, IREB CPRE, and BABOK v3. It describes what the system must do,
not how to build it. Implementation decisions belong in the design and planning phase._
