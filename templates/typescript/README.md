# Project Scaffolding Template

This is a production-ready project template based on **OpenClaw's best practices** for AI-assisted development with Claude Code, GitHub Copilot, and other AI coding assistants.

## Features

- ✅ **AI Assistant Ready** - AGENTS.md with coding guidelines
- ✅ **TypeScript Strict Mode** - Type safety from day one
- ✅ **Modern Build Tools** - Fast Rust-based tooling (Oxlint, Oxfmt, Vitest)
- ✅ **Pre-commit Hooks** - Auto-format and lint before every commit
- ✅ **Quality Gates** - Prevent bad code from entering the repo
- ✅ **GitHub Actions** - Optional CI/CD pipeline
- ✅ **VSCode Integration** - Recommended extensions and settings

## Quick Start

### 1. Copy Template

```bash
# Copy this template to your new project
cp -r templates/project-scaffolding my-new-project
cd my-new-project
```

### 2. Initialize

```bash
# Install dependencies
npm install
# or
pnpm install

# Install pre-commit hooks
npx prek install
```

### 3. Customize

Edit these files for your project:

- `package.json` - Change name, description, author
- `AGENTS.md` - Add project-specific guidelines
- `README.md` - Replace this with your project README
- `src/index.ts` - Start coding!

### 4. Start Developing

```bash
# Development
npm run dev

# Build
npm run build

# Test
npm test

# Lint
npm run lint

# Format
npm run format:fix
```

## What's Included

### Configuration Files

- **`AGENTS.md`** - Instructions for AI coding assistants
- **`CLAUDE.md`** - Symlink to AGENTS.md for Claude-specific tools
- **`tsconfig.json`** - TypeScript configuration (strict mode)
- **`package.json`** - Dependencies and scripts
- **`.pre-commit-config.yaml`** - Pre-commit hooks
- **`.gitignore`** - Standard ignores for Node.js/TypeScript
- **`vitest.config.ts`** - Test configuration
- **`.vscode/settings.json`** - VSCode workspace settings
- **`.vscode/extensions.json`** - Recommended extensions

### Scripts

- **`scripts/commit`** - Scoped commit helper

### Optional

- **`.github/workflows/ci.yml`** - GitHub Actions CI pipeline

## File Structure

```
my-new-project/
├── .github/
│   └── workflows/
│       └── ci.yml           # Optional CI/CD
├── .vscode/
│   ├── extensions.json      # Recommended extensions
│   └── settings.json        # Workspace settings
├── scripts/
│   └── commit              # Commit helper script
├── src/
│   └── index.ts            # Your code here
├── test/
│   └── index.test.ts       # Your tests here
├── .gitignore              # Git ignores
├── .pre-commit-config.yaml # Pre-commit hooks
├── AGENTS.md               # AI assistant instructions
├── CLAUDE.md               # Symlink to AGENTS.md
├── package.json            # Dependencies & scripts
├── README.md               # This file
├── tsconfig.json           # TypeScript config
└── vitest.config.ts        # Test config
```

## AI Assistant Setup

### Claude Code

The `AGENTS.md` and `CLAUDE.md` files are automatically detected by Claude Code and provide:

- Project structure and conventions
- Code style guidelines
- Testing patterns
- Commit message format

### GitHub Copilot

The `.github/copilot-instructions.md` file (optional) provides Copilot-specific guidance.

### Cursor / Other AI Tools

Most AI coding assistants will read `AGENTS.md` or `.cursorrules` for project-specific instructions.

## Commands Reference

### Development

```bash
npm run dev          # Watch mode (if configured)
npm run build        # Build TypeScript
npm run typecheck    # Check types without building
```

### Testing

```bash
npm test             # Run tests once
npm test:watch       # Watch mode
npm test:coverage    # With coverage report
```

### Quality

```bash
npm run lint         # Check with Oxlint
npm run format       # Check formatting
npm run format:fix   # Auto-fix formatting
npm run check        # Run lint + format
```

### Pre-commit Hooks

```bash
npx prek install     # Install hooks
npx prek run --all   # Run all hooks manually
```

## Customization

### Add Dependencies

```bash
npm install <package>
# or
pnpm add <package>
```

### Add Dev Dependencies

```bash
npm install -D <package>
# or
pnpm add -D <package>
```

### Modify TypeScript Config

Edit `tsconfig.json` to adjust:
- Compiler options
- Include/exclude patterns
- Module resolution

### Customize Pre-commit Hooks

Edit `.pre-commit-config.yaml` to:
- Add/remove hooks
- Adjust hook settings
- Add custom scripts

## Learn More

- **OpenClaw Learning Guide**: [docs/reference/learning-guide.md](../../docs/reference/learning-guide.md)
- **AI Coding Assistant Guide**: [docs/reference/ai-coding-assistant-guide.md](../../docs/reference/ai-coding-assistant-guide.md)
- **Full OpenClaw Docs**: https://docs.openclaw.ai

## License

Customize this section for your project's license.

---

**Built with patterns from [OpenClaw](https://github.com/openclaw/openclaw)** 🦞
