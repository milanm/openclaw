#!/usr/bin/env bash
# Create a new project from the OpenClaw scaffolding template
# Usage: ./scripts/scaffold-project.sh <project-name> [directory]

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TEMPLATE_DIR="$(cd "$SCRIPT_DIR/../templates/project-scaffolding" && pwd)"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

usage() {
  cat << EOF
Usage: $0 <project-name> [directory]

Create a new TypeScript project from OpenClaw scaffolding template.

Arguments:
  project-name    Name of the new project (required)
  directory       Target directory (default: ./project-name)

Example:
  $0 my-awesome-project
  $0 my-api ./projects/my-api

Features:
  - TypeScript with strict mode
  - Modern tooling (Oxlint, Oxfmt, Vitest)
  - Pre-commit hooks
  - AI assistant ready (AGENTS.md)
  - GitHub Actions CI (optional)
  - VSCode integration

EOF
  exit 1
}

if [ $# -lt 1 ]; then
  usage
fi

PROJECT_NAME="$1"
TARGET_DIR="${2:-./$PROJECT_NAME}"

# Validate project name
if [[ ! "$PROJECT_NAME" =~ ^[a-z0-9-]+$ ]]; then
  echo -e "${RED}Error: Project name must contain only lowercase letters, numbers, and hyphens${NC}" >&2
  exit 1
fi

# Check if target directory already exists
if [ -d "$TARGET_DIR" ]; then
  echo -e "${RED}Error: Directory already exists: $TARGET_DIR${NC}" >&2
  exit 1
fi

echo -e "${GREEN}🦞 Creating new project: $PROJECT_NAME${NC}"
echo ""

# Create target directory
echo "📁 Creating directory: $TARGET_DIR"
mkdir -p "$TARGET_DIR"

# Copy template files
echo "📋 Copying template files..."
cp -r "$TEMPLATE_DIR"/* "$TARGET_DIR/"
cp -r "$TEMPLATE_DIR"/.* "$TARGET_DIR/" 2>/dev/null || true

# Update package.json with project name
echo "📝 Updating package.json..."
cd "$TARGET_DIR"

# Use sed to replace project name
sed -i.bak "s/\"name\": \"my-project\"/\"name\": \"$PROJECT_NAME\"/" package.json
rm package.json.bak

echo ""
echo -e "${GREEN}✅ Project created successfully!${NC}"
echo ""
echo "Next steps:"
echo ""
echo "  cd $TARGET_DIR"
echo "  npm install              # Install dependencies"
echo "  npx prek install         # Install pre-commit hooks"
echo "  git init                 # Initialize git repository (optional)"
echo "  git add .                # Stage all files"
echo "  git commit -m 'Initial commit'"
echo ""
echo "Development commands:"
echo ""
echo "  npm run build            # Build TypeScript"
echo "  npm test                 # Run tests"
echo "  npm run lint             # Check linting"
echo "  npm run format:fix       # Auto-format code"
echo "  npm run check            # Run all quality checks"
echo ""
echo -e "${YELLOW}📖 Don't forget to customize:${NC}"
echo "  - package.json (description, author, license)"
echo "  - AGENTS.md (project-specific guidelines)"
echo "  - README.md (replace template content)"
echo ""
echo -e "${GREEN}Happy coding! 🚀${NC}"
