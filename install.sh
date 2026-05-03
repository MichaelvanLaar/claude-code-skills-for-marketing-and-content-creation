#!/usr/bin/env bash
# install.sh — Copies Claude Code marketing skills into a target project.
# Requires: Bash 3.2+, cp, ls
#
# Usage:
#   bash install.sh [--all] [--update] [--target <path>] [skill-name ...]
#
# Options:
#   --all           Install every skill in this repository's .claude/skills/
#   --update        Overwrite skills that are already installed in the target
#   --target <path> Target project root (default: current working directory)
#
# Examples:
#   bash install.sh linkedin-post
#   bash install.sh --all --target ~/projects/acme-marketing
#   bash install.sh --update onboarding session-wrap

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SOURCE_SKILLS_DIR="$SCRIPT_DIR/.claude/skills"

TARGET_DIR="$(pwd)"
UPDATE=false
INSTALL_ALL=false
SKILL_NAMES=()
EXIT_CODE=0

# ── Argument parsing ─────────────────────────────────────────────────────────

while [[ $# -gt 0 ]]; do
  case "$1" in
    --all)
      INSTALL_ALL=true
      shift
      ;;
    --update)
      UPDATE=true
      shift
      ;;
    --target)
      if [[ -z "${2:-}" ]]; then
        echo "error: --target requires a path argument" >&2
        exit 1
      fi
      TARGET_DIR="$2"
      shift 2
      ;;
    --*)
      echo "error: unknown option '$1'" >&2
      exit 1
      ;;
    *)
      SKILL_NAMES+=("$1")
      shift
      ;;
  esac
done

# ── Validate source ───────────────────────────────────────────────────────────

if [[ ! -d "$SOURCE_SKILLS_DIR" ]]; then
  echo "error: source skills directory not found: $SOURCE_SKILLS_DIR" >&2
  exit 1
fi

# ── Resolve skill list ────────────────────────────────────────────────────────

if $INSTALL_ALL; then
  while IFS= read -r -d '' dir; do
    skill_name="$(basename "$dir")"
    SKILL_NAMES+=("$skill_name")
  done < <(find "$SOURCE_SKILLS_DIR" -mindepth 1 -maxdepth 1 -type d -print0 | sort -z)
fi

if [[ ${#SKILL_NAMES[@]} -eq 0 ]]; then
  echo "error: no skills specified. Use --all or pass skill names as arguments." >&2
  exit 1
fi

# ── Install ───────────────────────────────────────────────────────────────────

TARGET_SKILLS_DIR="$TARGET_DIR/.claude/skills"
mkdir -p "$TARGET_SKILLS_DIR"

declare -A RESULTS

for skill in "${SKILL_NAMES[@]}"; do
  # Guard against .env / secrets/ patterns in skill names
  if [[ "$skill" == .env* ]] || [[ "$skill" == secrets* ]]; then
    RESULTS["$skill"]="failed: refusing to install — name matches a sensitive pattern"
    EXIT_CODE=1
    continue
  fi

  src="$SOURCE_SKILLS_DIR/$skill"
  dest="$TARGET_SKILLS_DIR/$skill"

  if [[ ! -d "$src" ]]; then
    RESULTS["$skill"]="failed: skill not found in source repository"
    EXIT_CODE=1
    continue
  fi

  if [[ -d "$dest" ]] && ! $UPDATE; then
    RESULTS["$skill"]="already installed — skipped"
    continue
  fi

  if cp -r "$src" "$TARGET_SKILLS_DIR/" 2>/dev/null; then
    if [[ -d "$dest" ]] && $UPDATE; then
      RESULTS["$skill"]="updated"
    else
      RESULTS["$skill"]="installed"
    fi
  else
    RESULTS["$skill"]="failed: could not copy to $dest"
    EXIT_CODE=1
  fi
done

# ── Summary ───────────────────────────────────────────────────────────────────

echo ""
echo "Installation summary"
echo "────────────────────"
for skill in "${SKILL_NAMES[@]}"; do
  printf "  %-40s %s\n" "$skill" "${RESULTS[$skill]:-unknown}"
done
echo ""

if [[ $EXIT_CODE -ne 0 ]]; then
  echo "One or more skills failed to install." >&2
fi

exit $EXIT_CODE
