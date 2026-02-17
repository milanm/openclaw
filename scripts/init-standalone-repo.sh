#!/usr/bin/env bash
# Initialize a standalone template repository from OpenClaw templates
# Usage: ./scripts/init-standalone-repo.sh <target-directory>

set -euo pipefail

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

TARGET_DIR="${1:-.}"

echo -e "${BLUE}🦞 Initializing standalone template repository${NC}"
echo ""

# Check if we're in the OpenClaw repo
if [ ! -d "templates" ]; then
  echo -e "${YELLOW}Warning: templates/ directory not found${NC}"
  echo "Make sure you're running this from the OpenClaw repository root"
  exit 1
fi

# Create target directory if needed
mkdir -p "$TARGET_DIR"
cd "$TARGET_DIR"

echo -e "${GREEN}📁 Setting up directory structure...${NC}"

# Copy templates
cp -r ../templates .

# Create scripts directory
mkdir -p scripts

# Create wrapper script for standalone use
cat > scripts/create-project.sh << 'WRAPPER'
#!/usr/bin/env bash
# Project creation script for standalone template repository
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TEMPLATE_DIR="$SCRIPT_DIR/../templates"

# Check if scaffold script exists in templates
SCAFFOLD_SCRIPT="$SCRIPT_DIR/../templates/base/scripts/scaffold-project.sh"

if [ ! -f "$SCAFFOLD_SCRIPT" ]; then
  # Use inline scaffolding logic
  source "$SCRIPT_DIR/scaffold-standalone.sh"
else
  # Use OpenClaw's scaffold script
  exec "$SCAFFOLD_SCRIPT" "$@"
fi
WRAPPER

chmod +x scripts/create-project.sh

# Create standalone README
cat > README.md << 'README'
# Project Templates

Language-agnostic project scaffolding templates with AI assistant integration.

Based on [OpenClaw](https://github.com/openclaw/openclaw) best practices.

## Quick Start

```bash
# Create a new project
./scripts/create-project.sh my-project

# With specific language
./scripts/create-project.sh --lang typescript my-api
./scripts/create-project.sh --lang csharp MyDotNetApp
./scripts/create-project.sh --lang ruby my-ruby-app
./scripts/create-project.sh --lang python my-python-app
```

## Available Templates

- **TypeScript** - Modern TypeScript with Oxlint, Oxfmt, Vitest
- **C#/.NET** - C#/.NET with modern tooling
- **Ruby** - Ruby with RuboCop, RSpec
- **Python** - Python with Black, Ruff, pytest
- **Base** - Generic template for any language

## Features

All templates include:
- ✅ AI assistant ready (AGENTS.md for Claude Code, Copilot, Cursor)
- ✅ Language-specific best practices
- ✅ Quality gates and testing setup
- ✅ CI/CD configuration
- ✅ VSCode integration

## Documentation

See [templates/README.md](templates/README.md) for detailed documentation.

## Contributing

Contributions welcome! See [CONTRIBUTING.md](CONTRIBUTING.md).

## License

MIT License - see [LICENSE](LICENSE)

---

**Built with patterns from [OpenClaw](https://github.com/openclaw/openclaw)** 🦞
README

# Create CONTRIBUTING guide
cat > CONTRIBUTING.md << 'CONTRIB'
# Contributing to Project Templates

Thank you for your interest in contributing!

## How to Contribute

### Adding a New Language Template

1. Create `templates/<language>/` directory
2. Add `AGENTS.md` with language-specific coding guidelines
3. Create `CLAUDE.md` symlink: `ln -s AGENTS.md CLAUDE.md`
4. Add `README.md` with setup instructions
5. Add example code and configuration files
6. Update `templates/README.md` to list the new language
7. Test with `./scripts/create-project.sh --lang <language> test`

### Improving Existing Templates

1. Fork the repository
2. Make your changes
3. Test thoroughly
4. Submit a pull request

### Template Guidelines

- Keep AGENTS.md focused on AI-relevant patterns
- Include language-specific naming conventions
- Provide working example code
- Document setup steps clearly
- Follow the language's community standards

## Questions?

Open an issue or start a discussion!
CONTRIB

# Create .gitignore
cat > .gitignore << 'GITIGNORE'
# OS
.DS_Store
Thumbs.db

# Editor
.vscode/*
!.vscode/settings.json
!.vscode/extensions.json
.idea/

# Build artifacts
node_modules/
dist/
build/
*.log

# Test projects (created during testing)
test-*/
example-*/
GITIGNORE

# Create docs directory
mkdir -p docs

cat > docs/adding-languages.md << 'ADDLANG'
# Adding New Language Templates

This guide explains how to add a new language template to this repository.

## Steps

### 1. Create Template Directory

```bash
mkdir -p templates/<language>
cd templates/<language>
```

### 2. Create AGENTS.md

Include:
- Tech stack information
- Language-specific naming conventions
- Code style guidelines
- Testing patterns
- Best practices
- Common anti-patterns

### 3. Add Language-Specific Files

Examples:
- Package/dependency files (package.json, Gemfile, requirements.txt, etc.)
- Configuration files (.eslintrc, .rubocop.yml, pyproject.toml, etc.)
- Build configurations
- Example source code
- Example tests

### 4. Create README.md

Explain:
- Quick start
- Setup requirements
- Available commands
- Links to language documentation

### 5. Create CLAUDE.md Symlink

```bash
ln -s AGENTS.md CLAUDE.md
```

### 6. Update Main Documentation

Add your language to `templates/README.md`

### 7. Test

```bash
./scripts/create-project.sh --lang <language> test-project
cd test-project
# Verify all files are present and correct
```

## Template Checklist

- [ ] `AGENTS.md` with language guidelines
- [ ] `CLAUDE.md` symlink
- [ ] `README.md` with setup instructions
- [ ] Example source files
- [ ] Configuration files
- [ ] Updated main `templates/README.md`
- [ ] Tested with create-project script
ADDLANG

echo ""
echo -e "${GREEN}✅ Standalone repository initialized!${NC}"
echo ""
echo "Next steps:"
echo ""
echo "  1. Initialize git (if not already done):"
echo "     git init"
echo ""
echo "  2. Add files:"
echo "     git add ."
echo ""
echo "  3. Commit:"
echo '     git commit -m "Initial commit: Project templates"'
echo ""
echo "  4. Create repository on GitHub:"
echo "     - Go to https://github.com/new"
echo "     - Create repository (e.g., 'project-templates')"
echo ""
echo "  5. Push to GitHub:"
echo "     git remote add origin https://github.com/<username>/project-templates.git"
echo "     git branch -M main"
echo "     git push -u origin main"
echo ""
echo -e "${BLUE}📚 See SETUP_STANDALONE_REPO.md for detailed instructions${NC}"
echo ""
echo -e "${GREEN}Happy templating! 🚀${NC}"
