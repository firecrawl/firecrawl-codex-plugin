#!/usr/bin/env bash
# Re-vendor skills from a local firecrawl/cli checkout.
# Usage: CLI_SKILLS_ROOT=/path/to/cli/skills ./scripts/sync-skills-from-cli.sh
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
SRC="${CLI_SKILLS_ROOT:-}"
if [[ -z "$SRC" || ! -d "$SRC" ]]; then
  echo "Set CLI_SKILLS_ROOT to the cli/skills directory (e.g. ../cli/skills)." >&2
  exit 1
fi
rm -rf "$ROOT/skills"
mkdir -p "$ROOT/skills"
cp -R "$SRC"/* "$ROOT/skills/"
echo "Copied skills from $SRC into $ROOT/skills"
echo "Re-apply Codex edits: strip allowed-tools, neutralize Claude-only copy, fix firecrawl-cli build-skill notes (see git history)."
