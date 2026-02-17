# Project Scaffolding Template

This is a production-ready project template based on **OpenClaw's best practices** for AI-assisted development.

## Features

- ✅ **AI Assistant Ready** - AGENTS.md with coding guidelines
- ✅ **Quality Gates** - Pre-commit hooks for code quality
- ✅ **Testing Setup** - Test framework configured
- ✅ **CI/CD Ready** - GitHub Actions workflow template
- ✅ **VSCode Integration** - Recommended extensions and settings
- ✅ **Best Practices** - OpenClaw patterns baked in

## Quick Start

### 1. Choose Your Language

This template supports multiple languages:
- TypeScript/JavaScript
- C#/.NET
- Ruby
- Python
- Or customize for your stack

### 2. Initialize

```bash
# Install dependencies (language-specific)
# npm install, dotnet restore, bundle install, pip install, etc.

# Install pre-commit hooks (if using)
# Configure based on your language
```

### 3. Customize

Edit these files for your project:

- `AGENTS.md` - Add project-specific guidelines
- `README.md` - Replace this with your project README
- Language-specific configuration files
- Start coding!

## What's Included

### Core Files

- **`AGENTS.md`** - Instructions for AI coding assistants
- **`CLAUDE.md`** - Symlink to AGENTS.md for Claude-specific tools
- **`README.md`** - This file
- **`.gitignore`** - Standard ignores for your language
- **`scripts/commit`** - Scoped commit helper

### Language-Specific

Each language template includes:
- Build/dependency configuration
- Testing framework setup
- Linting/formatting tools
- Example source and tests
- CI/CD workflow

## AI Assistant Setup

### Claude Code

The `AGENTS.md` and `CLAUDE.md` files are automatically detected by Claude Code and provide:

- Project structure and conventions
- Code style guidelines
- Testing patterns
- Commit message format

### GitHub Copilot

Works out of the box with workspace context.

### Cursor / Other AI Tools

Most AI coding assistants will read `AGENTS.md` for project-specific instructions.

## Customization

### For Your Language

1. Update `AGENTS.md` tech stack section
2. Configure language-specific tools
3. Set up your build system
4. Configure linting/formatting
5. Add language-specific pre-commit hooks

### For Your Domain

Update `AGENTS.md` with:
- Business rules
- API contracts
- Data models
- Workflow patterns

## Learn More

- **OpenClaw Learning Guide**: [docs/reference/learning-guide.md](../../docs/reference/learning-guide.md)
- **Full OpenClaw Docs**: https://docs.openclaw.ai

## License

Customize this section for your project's license.

---

**Built with patterns from [OpenClaw](https://github.com/openclaw/openclaw)** 🦞
