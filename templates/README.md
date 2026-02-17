# OpenClaw Project Templates

This directory contains project templates and scaffolding tools to help you start new projects using OpenClaw's best practices.

## Available Templates

### 1. Project Scaffolding

**Location:** `templates/project-scaffolding/`

A complete TypeScript project template with modern tooling and AI assistant integration.

**Features:**
- ✅ TypeScript with strict mode
- ✅ Modern build tools (Oxlint, Oxfmt, Vitest)
- ✅ Pre-commit hooks for quality gates
- ✅ AI assistant ready (AGENTS.md, CLAUDE.md)
- ✅ GitHub Actions CI pipeline
- ✅ VSCode integration

**Quick Start:**

```bash
# Option 1: Use the scaffolding script
./scripts/scaffold-project.sh my-project

# Option 2: Manual copy
cp -r templates/project-scaffolding my-project
cd my-project
npm install
npx prek install
```

**What's Included:**

```
project-scaffolding/
├── .github/workflows/ci.yml    # GitHub Actions CI
├── .vscode/                    # VSCode settings
├── scripts/commit              # Scoped commit helper
├── src/index.ts               # Example source
├── test/index.test.ts         # Example test
├── .gitignore                 # Git ignores
├── .pre-commit-config.yaml    # Pre-commit hooks
├── AGENTS.md                  # AI assistant instructions
├── CLAUDE.md                  # Symlink to AGENTS.md
├── package.json               # Dependencies & scripts
├── README.md                  # Template documentation
├── tsconfig.json              # TypeScript config
└── vitest.config.ts           # Test config
```

## Using the Scaffolding Script

The `scripts/scaffold-project.sh` script automates project creation:

```bash
# Create project in current directory
./scripts/scaffold-project.sh my-awesome-project

# Create project in specific directory
./scripts/scaffold-project.sh my-api ./projects/my-api
```

**What it does:**
1. Creates target directory
2. Copies all template files
3. Updates `package.json` with project name
4. Provides next steps instructions

## Customization Guide

After creating your project, customize these files:

### 1. package.json

```json
{
  "name": "your-project-name",
  "description": "Your project description",
  "author": "Your Name <your.email@example.com>",
  "license": "MIT",
  "repository": {
    "type": "git",
    "url": "https://github.com/yourusername/your-project"
  }
}
```

### 2. AGENTS.md

Add project-specific guidelines:
- Architecture decisions
- API patterns
- Database schema
- Business logic rules
- Domain-specific terminology

### 3. README.md

Replace template content with:
- Project overview
- Installation instructions
- Usage examples
- API documentation
- Contributing guidelines

### 4. tsconfig.json

Adjust TypeScript settings:
- Target ES version
- Module system
- Path mappings
- Compiler options

### 5. .pre-commit-config.yaml

Add/remove hooks:
- Secret detection
- Custom linters
- Code formatters
- Additional checks

## Templates vs OpenClaw Repository

**Templates** provide a clean starting point for **new projects**.

**OpenClaw repository** is a full-featured example with:
- Complex architecture (Gateway, channels, agents)
- Multiple workspaces (monorepo)
- Production deployment configs
- Extensive documentation

Use templates for new projects. Study OpenClaw for advanced patterns.

## Best Practices

### 1. Start Simple

Don't copy everything from OpenClaw. The template provides essentials:
- TypeScript setup
- Testing framework
- Quality gates
- AI assistant integration

Add complexity as needed.

### 2. Customize for Your Domain

Update `AGENTS.md` with domain knowledge:
- Business rules
- API contracts
- Data models
- Workflow patterns

This helps AI assistants understand your context.

### 3. Add Dependencies Gradually

Start with the template's minimal dependencies:
- TypeScript
- Vitest
- Oxlint/Oxfmt

Add libraries as you need them.

### 4. Keep It Maintained

Update dependencies regularly:
```bash
npm outdated
npm update
```

Review and update `AGENTS.md` as patterns evolve.

## Learn More

- **Learning Guide**: [docs/reference/learning-guide.md](../docs/reference/learning-guide.md)
- **AI Coding Assistant Guide**: [docs/reference/ai-coding-assistant-guide.md](../docs/reference/ai-coding-assistant-guide.md)
- **OpenClaw Documentation**: https://docs.openclaw.ai

## Contributing Templates

Want to contribute a new template?

1. Create `templates/your-template/`
2. Include complete setup (package.json, configs, etc.)
3. Add README explaining usage
4. Update this index
5. Submit PR

Examples of useful templates:
- Express.js API server
- React/Next.js frontend
- CLI application
- Library/package

## License

Templates are MIT licensed - feel free to use in any project.

---

**Built from [OpenClaw](https://github.com/openclaw/openclaw) patterns** 🦞
