---
name: marketing-update
description: >
  Use this skill to update installed marketing and content creation skills to
  their latest versions from the source repository. Invoke when the user says
  "update marketing skills", "update content skills", "update skills", or
  "marketing update".
allowed-tools: Read, Bash
---

# Marketing Update Skill

You are updating the installed marketing and content creation skills to their
latest versions from the source repository.

## Step 1: Detect installed skills

Check which skills from this repository are installed in the current project:

```bash
for skill in onboarding linkedin-post session-wrap samples-curation marketing-update; do
  if [ -d ".claude/skills/$skill" ]; then echo "$skill installed"; else echo "$skill missing"; fi
done
```

Present the results:

```
Installed skills       Status
────────────────────────────────
onboarding             ✓ installed
linkedin-post          ✓ installed
session-wrap           ✓ installed
samples-curation       ✗ not installed
marketing-update       ✓ installed
────────────────────────────────
```

If **no known skills are installed**, say:

> "No marketing skills from this repository were found in `.claude/skills/`.
> To install them, run:
> `curl -fsSL https://raw.githubusercontent.com/MichaelvanLaar/claude-code-skills-for-marketing-and-content-creation/main/install.sh | bash -s -- --all`"

Then exit.

## Step 2: Confirm update

List the installed skills and ask:

> "I'll fetch the latest versions of these skills from the source repository:
>
> <bulleted list of installed skills>
>
> Any local edits to these skill files will be overwritten. Shall I proceed?
> (yes / no)"

- **No**: say "Update cancelled." and exit.
- **Yes**: proceed to Step 3.

## Step 3: Run the update

Build the argument list from the installed skills detected in Step 1, then run:

```bash
curl -fsSL https://raw.githubusercontent.com/MichaelvanLaar/claude-code-skills-for-marketing-and-content-creation/main/install.sh \
  | bash -s -- --update <space-separated list of installed skill names>
```

If `curl` or `bash` is unavailable, say:

> "Update requires `curl` and `bash`. Please run the install script manually:
> `curl -fsSL https://raw.githubusercontent.com/MichaelvanLaar/claude-code-skills-for-marketing-and-content-creation/main/install.sh | bash -s -- --update <skills>`"

Then exit.

## Step 4: Report results

Show the summary output from the install script verbatim. Then say:

> "Update complete. Run `/marketing-update` again any time you want to pull
> the latest versions."
