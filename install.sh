#!/usr/bin/env bash
set -e

HERMES_DIR="$HOME/.hermes"
SKILLS_DIR="$HERMES_DIR/skills"
WORKFLOWS_DIR="$HERMES_DIR/workflows"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "Oh My Hermes — installer"
echo "========================"

# Check Hermes is installed
if [ ! -d "$HERMES_DIR" ]; then
  echo ""
  echo "[ERROR] ~/.hermes not found. Install Hermes Agent first:"
  echo "  curl -fsSL https://raw.githubusercontent.com/NousResearch/hermes-agent/main/scripts/install.sh | bash"
  echo "  Then run: hermes"
  exit 1
fi

mkdir -p "$SKILLS_DIR"
mkdir -p "$WORKFLOWS_DIR"

# Install skills
SKILLS_INSTALLED=0
if [ -d "$SCRIPT_DIR/skills" ]; then
  for skill in "$SCRIPT_DIR/skills"/*.md; do
    [ -f "$skill" ] || continue
    cp "$skill" "$SKILLS_DIR/"
    SKILLS_INSTALLED=$((SKILLS_INSTALLED + 1))
  done
fi

# Install workflows
WORKFLOWS_INSTALLED=0
if [ -d "$SCRIPT_DIR/workflows" ]; then
  for workflow in "$SCRIPT_DIR/workflows"/*.md; do
    [ -f "$workflow" ] || continue
    cp "$workflow" "$WORKFLOWS_DIR/"
    WORKFLOWS_INSTALLED=$((WORKFLOWS_INSTALLED + 1))
  done
fi

echo ""
echo "[OK] Skills installed:    $SKILLS_INSTALLED → $SKILLS_DIR"
echo "[OK] Workflows installed: $WORKFLOWS_INSTALLED → $WORKFLOWS_DIR"
echo ""
echo "Next steps:"
echo "  1. cd into your project directory"
echo "  2. bash $SCRIPT_DIR/scripts/bootstrap.sh"
echo "  3. Fill in AGENTS.md and .env.example"
echo "  4. Tell Hermes: 'start a new app'"
echo ""
echo "Verify: bash $SCRIPT_DIR/scripts/verify.sh"
