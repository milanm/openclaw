---
title: "AI Coding Assistant Guide"
summary: "Complete guide for AI coding assistants (Claude Code, GitHub Copilot, etc.) helping develop OpenClaw"
read_when:
  - Setting up an AI coding assistant to contribute to OpenClaw
  - Contributing code to OpenClaw with AI assistance
  - Understanding the repository structure and guidelines
---

# AI Coding Assistant Guide for OpenClaw Development

This guide is for AI coding assistants (Claude Code, GitHub Copilot, Cursor, etc.) helping developers contribute to OpenClaw.

## Primary Instruction Files

### Main Guidelines

**`/AGENTS.md`** (Root)
- **Purpose**: Primary coding guidelines and repository patterns
- **Contains**: Project structure, coding style, testing guidelines, commit conventions, development commands
- **Read**: Always read this first for comprehensive development guidelines

**`/CLAUDE.md`** (Root)
- **Purpose**: Symlink to `AGENTS.md` for Claude-specific tooling
- **Note**: Points to the same content as AGENTS.md

### GitHub Copilot Instructions

**`/.github/instructions/copilot.instructions.md`**
- **Purpose**: GitHub Copilot specific instructions
- **Contains**: Copilot-specific guidance and patterns for this repository

## PR Workflow & Skills

For maintainers reviewing and merging PRs, the repository includes workflow skills:

### Primary Workflow

**`/.agents/skills/PR_WORKFLOW.md`**
- **Purpose**: Complete maintainer PR workflow (triage, review, prepare, merge)
- **Contains**: Workflow steps, quality bar, rebase rules, commit conventions
- **Use**: When managing PRs as a maintainer

### Individual Skills

**`/.agents/skills/review-pr/`**
- **Purpose**: PR review skill
- **Files**: `SKILL.md`, `agents/openai.yaml`
- **Use**: Review PRs and produce findings

**`/.agents/skills/prepare-pr/`**
- **Purpose**: PR preparation skill
- **Files**: `SKILL.md`, `agents/openai.yaml`
- **Use**: Rebase, fix, gate, and push to PR head branch

**`/.agents/skills/merge-pr/`**
- **Purpose**: PR merge skill
- **Files**: `SKILL.md`, `agents/openai.yaml`
- **Use**: Squash-merge and verify MERGED state

**`/.agents/skills/mintlify/`**
- **Purpose**: Documentation skill
- **Files**: `SKILL.md`
- **Use**: Build and maintain Mintlify documentation sites

### Archived Skills

**`/.agents/archive/`**
- **Purpose**: Previous versions of skills (PR_WORKFLOW_V1.md, older skill versions)
- **Note**: Reference only; use current skills above

## VSCode Configuration

**`/.vscode/settings.json`**
- **Purpose**: VSCode workspace settings
- **Contains**: Editor configuration, formatter settings, recommended settings

**`/.vscode/extensions.json`**
- **Purpose**: Recommended VSCode extensions
- **Contains**: Extensions that improve OpenClaw development experience

## Agent Workflows

**`/.agent/workflows/update_clawdbot.md`**
- **Purpose**: Workflow for updating the Clawdbot agent
- **Use**: Specific workflow documentation

## Scripts for Claude/AI

**`/scripts/debug-claude-usage.ts`**
- **Purpose**: Debug Claude API usage
- **Use**: Troubleshoot Claude API integration issues

**`/scripts/claude-auth-status.sh`**
- **Purpose**: Check Claude authentication status
- **Use**: Verify Claude credentials and authentication

## Key Development Files to Know

### Root Configuration

- `/package.json` - Dependencies, scripts, project metadata
- `/tsconfig.json` - TypeScript configuration
- `/pnpm-lock.yaml` - Package lock file (pnpm)
- `/pnpm-workspace.yaml` - Workspace configuration
- `/vitest.config.ts` - Test configuration (main)
- `/vitest.e2e.config.ts` - E2E test configuration
- `/.oxlintrc.json` - Linting rules (Oxlint)
- `/.oxfmtrc.jsonc` - Formatting rules (Oxfmt)

### Documentation

- `/CONTRIBUTING.md` - Contribution guidelines
- `/README.md` - Project overview
- `/CHANGELOG.md` - Release notes and changes
- `/docs/` - Complete documentation (hosted on Mintlify)

### Source Code Structure

- `/src/` - Main source code
  - `/src/cli/` - CLI wiring and commands
  - `/src/commands/` - Command implementations
  - `/src/agents/` - Agent system
  - `/src/gateway/` - Gateway server
  - `/src/infra/` - Infrastructure utilities
  - `/src/media/` - Media processing pipeline
- `/extensions/` - Extension packages
- `/apps/` - Platform-specific apps (macOS, iOS, Android)
- `/ui/` - Web UI components

## Essential Commands

### Setup
```bash
pnpm install              # Install dependencies
pnpm ui:build            # Build UI (auto-installs UI deps)
pnpm build               # Build TypeScript
```

### Development
```bash
pnpm openclaw ...        # Run CLI in dev mode (via Bun)
pnpm dev                 # Alternative dev command
```

### Quality Checks
```bash
pnpm check               # Lint and format check (Oxlint + Oxfmt)
pnpm format              # Format check only (Oxfmt --check)
pnpm format:fix          # Auto-fix formatting (Oxfmt --write)
pnpm tsgo                # TypeScript type checking
```

### Testing
```bash
pnpm test                # Run tests (Vitest)
pnpm test:coverage       # Run with coverage
```

### Pre-commit Hooks
```bash
prek install             # Install pre-commit hooks (same as CI)
```

## Key Guidelines Summary

### Code Style
- **Language**: TypeScript (ESM, strict mode)
- **Formatting**: Oxlint + Oxfmt (run `pnpm check` before commits)
- **File size**: Keep under ~700 LOC when feasible
- **Comments**: Add brief comments for tricky/non-obvious logic
- **Imports**: Use `.js` extension for cross-package imports (ESM)

### Testing
- **Framework**: Vitest with V8 coverage
- **Naming**: `*.test.ts` for unit tests, `*.e2e.test.ts` for E2E
- **Coverage**: 70% threshold (lines/branches/functions/statements)

### Commits
- **Tool**: Use `scripts/committer "<msg>" <file...>` for scoped commits
- **Style**: Concise, action-oriented (e.g., "CLI: add verbose flag to send")
- **Grouping**: Group related changes; avoid bundling unrelated refactors

### Git Conventions
- **Never** use `git stash` unless explicitly requested
- **Never** switch branches without explicit request
- **Focus** on your changes only; don't modify unrelated files
- **Multi-agent safe**: Assume other agents may be working

## Quick Start for AI Assistants

1. **Read `/AGENTS.md`** first - it contains all the detailed guidelines
2. **Check** `/CONTRIBUTING.md` for contribution workflow
3. **Run** `pnpm install && pnpm build` to set up the repository
4. **Follow** the coding patterns in existing files
5. **Test** your changes with `pnpm test` and `pnpm check`
6. **Commit** using `scripts/committer` for proper scoping

## What NOT to Do

- ❌ Don't add `@ts-nocheck` or disable `no-explicit-any`
- ❌ Don't use prototype mutation for sharing behavior
- ❌ Don't create duplicate utility functions (search for existing ones)
- ❌ Don't modify `/node_modules` (updates will overwrite)
- ❌ Don't commit secrets or real credentials
- ❌ Don't create temporary files in the repo (use `/tmp`)
- ❌ Don't manually add/commit with `git` (use `scripts/committer`)

## Extensions and Plugins

**`/extensions/copilot-proxy/`**
- GitHub Copilot integration extension

**`/extensions/llm-task/`**
- LLM task execution extension

**Note**: These are product features, not development tools

## Need More Details?

- **Full guidelines**: Read `/AGENTS.md`
- **Dual purpose explanation**: See `docs/reference/ai-setup-files.md`
- **Contributing workflow**: Read `/CONTRIBUTING.md`
- **Documentation**: Visit https://docs.openclaw.ai

## Important Distinction

This guide covers **development files** for building OpenClaw.

For **product files** (configuring users' OpenClaw AI assistants), see:
- `/docs/reference/templates/AGENTS.md` - User workspace template
- `docs/reference/ai-setup-files.md` - Full dual-purpose explanation
