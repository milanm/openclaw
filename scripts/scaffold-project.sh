#!/usr/bin/env bash
# Create a new project from the OpenClaw scaffolding template
# Usage: ./scripts/scaffold-project.sh [--lang <language>] <project-name> [directory]

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TEMPLATE_BASE_DIR="$(cd "$SCRIPT_DIR/../templates" && pwd)"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

usage() {
  cat << EOF
Usage: $0 [--lang <language>] <project-name> [directory]

Create a new project from OpenClaw scaffolding template.

Options:
  --lang <language>   Choose language template (default: typescript)
                      Available: typescript, csharp, ruby, python, base

Arguments:
  project-name        Name of the new project (required)
  directory           Target directory (default: ./project-name)

Examples:
  $0 my-awesome-project
  $0 --lang typescript my-api
  $0 --lang csharp MyDotNetApp
  $0 --lang ruby my-ruby-app
  $0 --lang python my-python-app
  $0 --lang base my-custom-project

EOF
  exit 1
}

LANGUAGE="typescript"

while [[ $# -gt 0 ]]; do
  case $1 in
    --lang) LANGUAGE="$2"; shift 2 ;;
    --help|-h) usage ;;
    -*) echo -e "${RED}Unknown option: $1${NC}" >&2; usage ;;
    *) break ;;
  esac
done

[ $# -lt 1 ] && usage

PROJECT_NAME="$1"
TARGET_DIR="${2:-./$PROJECT_NAME}"
TEMPLATE_DIR="$TEMPLATE_BASE_DIR/$LANGUAGE"

[ ! -d "$TEMPLATE_DIR" ] && echo -e "${RED}Error: Language '$LANGUAGE' not found${NC}" >&2 && exit 1
[[ ! "$PROJECT_NAME" =~ ^[a-zA-Z0-9_-]+$ ]] && echo -e "${RED}Error: Invalid project name${NC}" >&2 && exit 1
[ -d "$TARGET_DIR" ] && echo -e "${RED}Error: Directory exists: $TARGET_DIR${NC}" >&2 && exit 1

echo -e "${GREEN}🦞 Creating new $LANGUAGE project: $PROJECT_NAME${NC}"
mkdir -p "$TARGET_DIR"
cp -r "$TEMPLATE_DIR"/. "$TARGET_DIR/"

if [ "$LANGUAGE" != "base" ]; then
  for file in "$TEMPLATE_BASE_DIR/base"/*; do
    filename=$(basename "$file")
    [ ! -e "$TARGET_DIR/$filename" ] && cp -r "$file" "$TARGET_DIR/"
  done
fi

cd "$TARGET_DIR"
[ -f "package.json" ] && sed -i.bak "s/\"name\": \"my-project\"/\"name\": \"$PROJECT_NAME\"/" package.json && rm -f package.json.bak

echo -e "${GREEN}✅ Project created: $TARGET_DIR${NC}"
