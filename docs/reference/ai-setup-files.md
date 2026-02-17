---
title: "AI Setup Files - Dual Purpose"
summary: "Explains the dual purpose of AGENTS.md and other AI coding setup files in the OpenClaw repository"
read_when:
  - Contributing to OpenClaw development
  - Setting up AI coding assistants (Claude Code, GitHub Copilot, etc.)
  - Configuring OpenClaw's AI assistant for end users
---

# AI Setup Files - Understanding the Dual Purpose

OpenClaw contains AI setup files that serve **two distinct purposes**. Understanding this dual nature is important for both contributors and users.

**Quick navigation:**
- **For AI coding assistants helping develop OpenClaw**: See [AI Coding Assistant Guide](ai-coding-assistant-guide.md)
- **For users configuring their OpenClaw AI assistant**: See templates in `/docs/reference/templates/`

## The Dual Purpose

### 1. Development (Repository Contributors)

Files for AI coding assistants helping **develop OpenClaw itself**:

**Primary files:**
- `/AGENTS.md` - Main coding guidelines for AI assistants (Claude Code, GitHub Copilot, etc.)
- `/CLAUDE.md` - Symlink to `AGENTS.md` for Claude-specific tooling
- `/.github/instructions/copilot.instructions.md` - GitHub Copilot specific instructions

**Skills for PR workflow (used by maintainers):**
- `/.agents/skills/PR_WORKFLOW.md` - Maintainer workflow for reviewing/merging PRs
- `/.agents/skills/review-pr/` - PR review skill
- `/.agents/skills/prepare-pr/` - PR preparation skill
- `/.agents/skills/merge-pr/` - PR merge skill
- `/.agents/skills/mintlify/` - Documentation (Mintlify) skill

**VSCode configuration:**
- `/.vscode/settings.json` - VSCode workspace settings
- `/.vscode/extensions.json` - Recommended VSCode extensions

**Scripts for Claude/AI debugging:**
- `/scripts/debug-claude-usage.ts` - Debug Claude API usage
- `/scripts/claude-auth-status.sh` - Check Claude authentication status

### 2. Product (OpenClaw Users)

Files for configuring **OpenClaw's AI assistant** that users run:

**Template files (copied to user workspace):**
- `/docs/reference/templates/AGENTS.md` - Template for user's workspace AGENTS.md
- `/docs/reference/templates/SOUL.md` - Template for personality/behavior
- `/docs/reference/templates/TOOLS.md` - Template for tool configuration

**Default workspace location:**
- `~/.openclaw/workspace/AGENTS.md` - User's actual workspace instructions (created from template)

**Documentation:**
- `/docs/concepts/system-prompt.md` - How OpenClaw builds system prompts for the AI assistant
- `/docs/reference/AGENTS.default.md` - Default AGENTS.md documentation

## How They Work Together

### Development Side

When you contribute to OpenClaw using Claude Code or GitHub Copilot:

1. Your AI assistant reads `/AGENTS.md` (or `CLAUDE.md`) for coding guidelines
2. It follows the repository structure, coding style, and testing conventions
3. Maintainers may use PR workflow skills in `/.agents/skills/` to review your contribution

### Product Side

When an OpenClaw user runs their AI assistant:

1. User copies templates from `/docs/reference/templates/` to `~/.openclaw/workspace/`
2. OpenClaw loads `~/.openclaw/workspace/AGENTS.md` as part of the system prompt
3. The AI assistant follows the user's custom instructions in their workspace

## Key Distinction

| Aspect | Development Files | Product Files |
|--------|------------------|---------------|
| **Purpose** | Guide AI tools developing OpenClaw | Configure user's OpenClaw AI assistant |
| **Location** | Repository root (`.agents/`, `AGENTS.md`) | User workspace (`~/.openclaw/workspace/`) |
| **Audience** | Contributors, AI coding assistants | End users, their AI assistant |
| **Managed by** | Repository maintainers (version control) | Individual users (local configuration) |
| **Content** | TypeScript style, repo structure, PR workflow | User preferences, personal assistant behavior |

## For Contributors

When contributing to OpenClaw:

- **Read** `/AGENTS.md` for development guidelines
- **Follow** the coding patterns and testing requirements described there
- **Use** the PR workflow skills if you're a maintainer
- **Don't modify** product template files unless you're improving the user experience

## For Users

When setting up your OpenClaw assistant:

- **Copy** templates from `/docs/reference/templates/` to your workspace
- **Customize** `~/.openclaw/workspace/AGENTS.md` for your needs
- **Don't worry** about development files in `.agents/` - those are for contributors

## Related Documentation

- [Contributing Guide](/CONTRIBUTING.md) - How to contribute to OpenClaw development
- [System Prompt](/concepts/system-prompt) - How OpenClaw builds prompts for the AI assistant
- [Getting Started](https://docs.openclaw.ai/start/getting-started) - Setting up OpenClaw for end users

## Extensions and Plugins

The repository also contains:

- `/extensions/copilot-proxy/` - GitHub Copilot integration extension
- `/extensions/llm-task/` - LLM task execution extension

These are product features that users can install, not development tools.
