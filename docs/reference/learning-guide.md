---
title: "Learning Guide: OpenClaw Patterns & Best Practices"
summary: "Comprehensive guide for learning from OpenClaw to build your own projects"
read_when:
  - Building new projects inspired by OpenClaw
  - Learning TypeScript/Node.js best practices
  - Understanding event-driven architecture
  - Setting up Windows development environment
---

# Learning Guide: Building Projects Based on OpenClaw

This guide helps you learn from OpenClaw's architecture, patterns, and best practices to build your own projects.

## 🚀 Quick Start: Project Scaffolding

**NEW**: Use our ready-to-go project templates for any language!

```bash
# TypeScript (default)
./scripts/scaffold-project.sh my-awesome-project

# C#/.NET
./scripts/scaffold-project.sh --lang csharp MyDotNetApp

# Ruby
./scripts/scaffold-project.sh --lang ruby my-ruby-app

# Python
./scripts/scaffold-project.sh --lang python my-python-app

# Generic template (customize for your language)
./scripts/scaffold-project.sh --lang base my-custom-project
```

**What you get:**
- ✅ Language-specific best practices
- ✅ AI assistant ready (AGENTS.md)
- ✅ Quality gates and testing
- ✅ CI/CD configuration
- ✅ VSCode integration

**Supported languages:**
- TypeScript - Oxlint, Oxfmt, Vitest
- C#/.NET - Modern .NET tooling
- Ruby - RuboCop, RSpec
- Python - Black, Ruff, pytest
- Base - Generic (customize for any language)

See [templates/README.md](../../templates/README.md) for details.

## Table of Contents

1. [Windows Setup](#windows-setup-wsl2)
2. [Hooks & Context Management](#hooks--context-management)
3. [Architecture Patterns](#architecture-patterns-to-learn)
4. [Development Workflow](#development-workflow)
5. [Best Practices](#best-practices-from-openclaw)
6. [Key Concepts](#key-concepts-to-apply)

---

## Windows Setup (WSL2)

### Why WSL2?

OpenClaw is designed for Linux/Unix environments. On Windows, use **WSL2** (Windows Subsystem for Linux) for the best experience:

- ✅ Full Linux compatibility
- ✅ Native tooling support (Node, pnpm, git)
- ✅ Consistent with production environments
- ✅ Better performance than native Windows Node.js for many operations
- ✅ Easier debugging and development

### Quick WSL2 Setup

**Step 1: Install WSL2**

Open PowerShell as Administrator:

```powershell
wsl --install
# Or choose Ubuntu 24.04 specifically:
wsl --install -d Ubuntu-24.04
```

Reboot if prompted.

**Step 2: Enable systemd (for services)**

Inside your WSL terminal:

```bash
sudo tee /etc/wsl.conf >/dev/null <<'EOF'
[boot]
systemd=true
EOF
```

Then from PowerShell:

```powershell
wsl --shutdown
```

Re-open Ubuntu and verify:

```bash
systemctl --user status
```

**Step 3: Install Development Tools**

Inside WSL:

```bash
# Update package list
sudo apt update && sudo apt upgrade -y

# Install Node.js (use nvm for version management)
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
source ~/.bashrc
nvm install 22  # Node 22+ required

# Install pnpm
npm install -g pnpm

# Install build essentials
sudo apt install -y build-essential git
```

**Step 4: Clone and Build OpenClaw**

```bash
git clone https://github.com/openclaw/openclaw.git
cd openclaw
pnpm install
pnpm build
```

### Windows Integration Tips

**Accessing WSL files from Windows:**
- WSL root: `\\wsl$\Ubuntu-24.04\home\<username>\`
- Use VS Code Remote-WSL extension for seamless editing

**Port forwarding (if needed):**

See [Windows documentation](../platforms/windows.md#advanced-expose-wsl-services-over-lan-portproxy) for exposing WSL services to LAN.

---

## Hooks & Context Management

OpenClaw uses several sophisticated "hooks" and "context tricks" you can learn from:

### 1. Pre-commit Hooks (Git Quality Gates)

**What OpenClaw Does:**

Uses `prek` (pre-commit framework) to run quality checks before every commit:

```yaml
# .pre-commit-config.yaml
repos:
  - repo: https://github.com/pre-commit/pre-commit-hooks
    hooks:
      - trailing-whitespace
      - end-of-file-fixer
      - check-yaml
      - check-added-large-files
```

**Custom Git Hook** (`git-hooks/pre-commit`):
```bash
#!/usr/bin/env bash
# Auto-lint and format on commit
oxlint --type-aware --fix
oxfmt --write
git add  # Re-add fixed files
```

**What You Can Learn:**
- Enforce code quality automatically
- Prevent bad commits from entering history
- Run linters/formatters before commit
- Use `detect-secrets` to prevent credential leaks

**Apply to Your Projects:**

```bash
# Install pre-commit framework
pip install pre-commit

# Create .pre-commit-config.yaml
pre-commit install

# Test it
pre-commit run --all-files
```

### 2. Event-Driven Hooks (Application Lifecycle)

**What OpenClaw Does:**

Event hooks for application lifecycle events:

```typescript
// Hooks system: src/hooks/
type HookHandler = async (event: HookEvent) => void;

// Event types:
// - command:new, command:reset, command:stop
// - agent:bootstrap (inject workspace files)
// - gateway:startup (run on server start)
```

**Example: session-memory Hook**
```typescript
// Saves session context when /new is issued
const handler: HookHandler = async (event) => {
  if (event.type === "command" && event.action === "new") {
    // Save session to memory before reset
    await saveSessionContext(event.context);
  }
};
```

**What You Can Learn:**
- Event-driven architecture for extensibility
- Plugin system without modifying core code
- Lifecycle hooks for bootstrapping
- Auto-discovery of extensions

**Apply to Your Projects:**
- Implement plugin systems with auto-discovery
- Use event emitters for decoupled components
- Create lifecycle hooks (startup, shutdown, error)
- Allow users to extend your app without forking

### 3. Context Management Patterns

OpenClaw has sophisticated context management for AI conversations:

#### A. Context Window Management

**What OpenClaw Does:**

Tracks token usage and auto-compacts when approaching limits:

```typescript
// src/reference/session-management-compaction.md
interface SessionEntry {
  contextTokens: number;      // Current context size
  contextWindow: number;       // Model's max context
  reserveTokens: number;       // Safety buffer
}

// Auto-compact when:
// contextTokens > contextWindow - reserveTokens
```

**What You Can Learn:**
- Sliding window pattern for bounded memory
- Token/resource tracking and limits
- Auto-compaction when approaching limits
- Graceful degradation strategies

#### B. Workspace Bootstrap Injection

**What OpenClaw Does:**

Injects workspace files into system prompt automatically:

```typescript
// Bootstrap files injected on every run:
const bootstrapFiles = [
  'AGENTS.md',    // Agent instructions
  'SOUL.md',      // Personality
  'TOOLS.md',     // Tool usage guidelines
  'MEMORY.md',    // Memory/context
];

// Hook: agent:bootstrap
// Allows injecting extra files dynamically
```

**What You Can Learn:**
- Configuration as code (markdown files)
- Workspace-based context injection
- Extensible bootstrap process via hooks
- Separation of config from code

#### C. Session Management & Persistence

**What OpenClaw Does:**

Two-layer persistence for conversations:

```typescript
// Layer 1: Session store (sessions.json)
{
  "sessionKey": {
    "sessionId": "abc123",
    "lastActivity": "2026-02-17T10:00:00Z",
    "contextTokens": 1500,
    "model": "claude-opus-4.6"
  }
}

// Layer 2: Transcript (abc123.jsonl)
// Append-only log of conversation
{"id":"1","type":"message","role":"user","content":"Hello"}
{"id":"2","parentId":"1","type":"message","role":"assistant","content":"Hi!"}
```

**What You Can Learn:**
- Hybrid storage pattern (metadata + append-only log)
- JSONL for append-only data structures
- Tree structure with `parentId` for branching conversations
- Session isolation and routing

**Apply to Your Projects:**
- Use JSONL for append-only logs
- Separate metadata (fast queries) from content (full history)
- Implement session/conversation management
- Use parent/child IDs for tree structures

### 4. Configuration System

**What OpenClaw Does:**

Layered configuration with validation:

```typescript
// src/config/
// - types.ts - TypeScript types for all config
// - schema.ts - Zod schemas for validation
// - config.ts - Runtime config loading & merging

// Layers (highest precedence first):
1. Environment variables
2. ~/.openclaw/config.json
3. Built-in defaults
```

**What You Can Learn:**
- Type-safe configuration with Zod
- Layered config (env vars > files > defaults)
- Schema validation on load
- Config migration helpers

---

## Architecture Patterns to Learn

### 1. Gateway + RPC Pattern

**What It Is:**

Central Gateway process with WebSocket RPC protocol:

```
┌─────────────┐
│   Gateway   │  (single source of truth)
│  (Node.js)  │
└──────┬──────┘
       │ WebSocket RPC
       ├─────────┬────────┬─────────┐
   ┌───▼───┐ ┌──▼──┐  ┌──▼──┐   ┌──▼───┐
   │ macOS │ │ iOS │  │ CLI │   │ Web  │
   │  App  │ │ App │  │     │   │  UI  │
   └───────┘ └─────┘  └─────┘   └──────┘
```

**Benefits:**
- Single source of truth (no state sync issues)
- Platform-agnostic clients
- Easy to add new clients
- Centralized logic and data

**Apply to Your Projects:**
- Build a server with WebSocket API
- Create lightweight clients (UI only)
- Use RPC for type-safe method calls
- Keep business logic server-side

### 2. Monorepo with Workspaces

**What OpenClaw Uses:**

pnpm workspaces for managing multiple packages:

```yaml
# pnpm-workspace.yaml
packages:
  - 'packages/*'
  - 'extensions/*'
  - 'apps/*'
```

**Structure:**
```
openclaw/
├── src/                 # Main package
├── extensions/          # Plugin packages
│   ├── copilot-proxy/
│   ├── llm-task/
│   └── voice-call/
├── apps/                # Platform apps
│   ├── macos/
│   ├── ios/
│   └── android/
└── packages/            # Shared packages
```

**Benefits:**
- Share code between packages
- Single lint/test/build configuration
- Atomic cross-package changes
- Easier dependency management

**Apply to Your Projects:**
```bash
# Initialize monorepo
pnpm init
echo 'packages:\n  - "packages/*"\n  - "apps/*"' > pnpm-workspace.yaml

# Create packages
mkdir -p packages/core packages/utils
cd packages/core && pnpm init
cd ../utils && pnpm init
```

### 3. Plugin System with Auto-Discovery

**What OpenClaw Does:**

Discovers and loads plugins/hooks automatically:

```typescript
// Discovery pattern:
async function discoverHooks(directories: string[]) {
  const hooks: Hook[] = [];
  
  for (const dir of directories) {
    const entries = await fs.readdir(dir);
    
    for (const entry of entries) {
      const hookPath = path.join(dir, entry);
      const metaPath = path.join(hookPath, 'HOOK.md');
      
      if (await fs.exists(metaPath)) {
        const metadata = await parseHookMetadata(metaPath);
        const handler = await import(path.join(hookPath, 'handler.ts'));
        hooks.push({ metadata, handler });
      }
    }
  }
  
  return hooks;
}
```

**Benefits:**
- No manual registration needed
- Users can add plugins by dropping files
- Clear plugin structure/contract
- Metadata-driven configuration

**Apply to Your Projects:**
- Use filesystem for plugin discovery
- Require metadata file (YAML/JSON frontmatter)
- Support multiple plugin directories
- Implement eligibility checking

### 4. TypeScript with Strict Mode

**What OpenClaw Uses:**

```json
// tsconfig.json
{
  "compilerOptions": {
    "strict": true,
    "noImplicitAny": true,
    "strictNullChecks": true,
    "moduleResolution": "bundler",
    "module": "ESNext",
    "target": "ES2022"
  }
}
```

**Benefits:**
- Catch bugs at compile time
- Better IDE autocomplete
- Self-documenting code
- Easier refactoring

### 5. Modern Build Tools

**What OpenClaw Uses:**

- **tsdown** - Fast TypeScript bundler
- **Oxlint** - Fast linter (Rust-based)
- **Oxfmt** - Fast formatter (Rust-based)
- **Vitest** - Fast test runner

**Benefits:**
- 10-100x faster than traditional tools
- Better DX (instant feedback)
- Lower CI costs
- Modern ESM support

**Apply to Your Projects:**

```json
// package.json
{
  "scripts": {
    "build": "tsdown",
    "lint": "oxlint src",
    "format": "oxfmt --write src",
    "test": "vitest"
  }
}
```

---

## Development Workflow

### 1. Commit Scoping Pattern

**What OpenClaw Does:**

Uses `scripts/committer` to scope commits:

```bash
#!/usr/bin/env bash
# scripts/committer "<message>" <files...>
MESSAGE=$1
shift
FILES=("$@")

git add "${FILES[@]}"
git commit -m "$MESSAGE"
```

**Why:**
- Explicit about what's committed
- Prevents accidental commits
- Clear commit scope
- Easier code review

**Apply to Your Projects:**

```bash
# Create scripts/commit
#!/bin/bash
git add "$@"
git commit -m "$1"

# Use it
./scripts/commit "fix: update config" src/config.ts
```

### 2. Progressive Enhancement Testing

**What OpenClaw Does:**

```typescript
// Unit tests (fast, many)
test('formatTime returns correct format', () => {
  expect(formatTime(1000)).toBe('1s');
});

// E2E tests (slower, fewer)
test('gateway starts and accepts connections', async () => {
  const gateway = await startGateway();
  const client = await connectClient();
  expect(client.isConnected()).toBe(true);
});

// Live tests (real APIs, manual)
LIVE=1 pnpm test:live
```

**Levels:**
1. Unit tests (pure functions, no I/O)
2. Integration tests (with mocks)
3. E2E tests (full system)
4. Live tests (real external services)

**Apply to Your Projects:**
- Write many unit tests (fast feedback)
- Some integration tests (critical paths)
- Few E2E tests (happy paths only)
- Manual live tests (API keys required)

### 3. Documentation as Code

**What OpenClaw Does:**

Docs in repository, built with Mintlify:

```markdown
---
title: "System Prompt"
summary: "What the OpenClaw system prompt contains"
read_when:
  - Editing system prompt text
  - Changing workspace bootstrap
---

# System Prompt

The prompt is assembled by OpenClaw...
```

**Benefits:**
- Docs versioned with code
- Markdown is readable in GitHub
- Frontmatter for metadata
- Easy to contribute

**Apply to Your Projects:**

```bash
# Use markdown for docs
mkdir docs
echo "# API Reference" > docs/api.md

# Host on GitHub Pages or Mintlify
# Keep docs in sync with code
```

---

## Best Practices from OpenClaw

### 1. Code Organization

**File Size Limits:**
- Keep files under ~700 LOC
- Extract helpers when larger
- One concept per file

**Naming Conventions:**
```typescript
// Types: PascalCase
type SessionEntry = { ... }

// Functions: camelCase
function loadSession() { ... }

// Constants: SCREAMING_SNAKE_CASE
const DEFAULT_PORT = 18789;

// Files: kebab-case
// session-manager.ts
// config-loader.ts
```

**Import Style:**
```typescript
// Use .js extension for ESM
import { loadConfig } from './config.js';

// Type-only imports
import type { Config } from './types.js';

// No barrel exports (import directly)
// ❌ import { foo } from './index.js';
// ✅ import { foo } from './foo.js';
```

### 2. Error Handling

**What OpenClaw Does:**

```typescript
// Specific error types
class SessionNotFoundError extends Error {
  constructor(sessionId: string) {
    super(`Session not found: ${sessionId}`);
    this.name = 'SessionNotFoundError';
  }
}

// Graceful degradation
async function loadSession(id: string) {
  try {
    return await fs.readJSON(`${id}.json`);
  } catch (err) {
    if (err.code === 'ENOENT') {
      console.warn(`Session ${id} not found, creating new`);
      return createNewSession(id);
    }
    throw err;  // Re-throw unexpected errors
  }
}
```

**Best Practices:**
- Use custom error types
- Provide context in messages
- Fail fast for programmer errors
- Graceful degradation for user errors
- Log warnings, not silent failures

### 3. Configuration

**What OpenClaw Does:**

```typescript
// 1. Define types
interface Config {
  port: number;
  host: string;
  database: {
    url: string;
  };
}

// 2. Create schema (Zod)
const ConfigSchema = z.object({
  port: z.number().int().min(1).max(65535),
  host: z.string(),
  database: z.object({
    url: z.string().url(),
  }),
});

// 3. Load with validation
function loadConfig(): Config {
  const raw = JSON.parse(fs.readFileSync('config.json', 'utf-8'));
  return ConfigSchema.parse(raw);  // Throws on invalid
}

// 4. Provide defaults
const DEFAULT_CONFIG: Config = {
  port: 8080,
  host: '127.0.0.1',
  database: { url: 'postgres://localhost/db' },
};
```

**Best Practices:**
- Type everything
- Validate on load (fail fast)
- Provide sensible defaults
- Document all options
- Support environment variables

### 4. Async Patterns

**What OpenClaw Does:**

```typescript
// ✅ Good: Promise.all for parallel
const [users, posts, comments] = await Promise.all([
  fetchUsers(),
  fetchPosts(),
  fetchComments(),
]);

// ✅ Good: Sequential when needed
const user = await fetchUser(id);
const posts = await fetchUserPosts(user.id);  // Depends on user

// ✅ Good: Error handling
try {
  await riskyOperation();
} catch (err) {
  console.error('Operation failed:', err);
  return fallbackValue;
}

// ❌ Bad: Unhandled promise rejections
riskyOperation();  // Missing await or .catch()
```

### 5. Testing Philosophy

**What OpenClaw Does:**

```typescript
// Test behavior, not implementation
test('user can send message', async () => {
  const gateway = await createTestGateway();
  const user = createTestUser();
  
  const response = await user.sendMessage('Hello');
  
  expect(response.status).toBe('success');
  expect(gateway.getMessages()).toHaveLength(1);
});

// Use factories for test data
function createTestUser(overrides = {}) {
  return {
    id: 'test-user',
    name: 'Test User',
    ...overrides,
  };
}
```

**Best Practices:**
- Test public APIs, not internals
- Use factories for test data
- Clean up resources (after hooks)
- Meaningful test names
- Fast tests (mock slow operations)

---

## Key Concepts to Apply

### 1. Separation of Concerns

OpenClaw separates:
- **Gateway** - Business logic, state management
- **Channels** - Message routing (Telegram, WhatsApp, etc.)
- **Agents** - AI/LLM interactions
- **Storage** - Persistence layer
- **UI** - User interfaces (Mac app, web, CLI)

Each has clear responsibilities and interfaces.

### 2. Event-Driven Architecture

Events allow loose coupling:
```typescript
// Emit events
emitter.emit('message:received', { from: user, text: 'Hello' });

// Subscribe anywhere
emitter.on('message:received', handleMessage);
emitter.on('message:received', logMessage);
emitter.on('message:received', analyzeMessage);
```

### 3. Extensibility via Plugins

Allow users to extend without forking:
- Auto-discovery
- Clear contracts (interfaces)
- Metadata for requirements
- Graceful degradation when missing

### 4. Type Safety

Use TypeScript strictly:
- Catch bugs early
- Better refactoring
- Self-documenting
- IDE support

### 5. Developer Experience

Optimize for DX:
- Fast tools (Oxlint, tsdown, Vitest)
- Good error messages
- Auto-formatting
- Pre-commit checks
- Clear documentation

---

## Quick Reference: Files to Study

### Architecture
- `src/gateway/` - Gateway/RPC pattern
- `src/hooks/` - Plugin system
- `src/config/` - Configuration management

### Patterns
- `src/auto-reply/reply/session.ts` - Session management
- `src/agents/system-prompt.ts` - Dynamic prompt building
- `src/hooks/workspace.ts` - Auto-discovery pattern

### Testing
- `*.test.ts` - Unit tests
- `*.e2e.test.ts` - E2E tests
- `vitest.config.ts` - Test configuration

### Build/Deploy
- `tsdown.config.ts` - Build configuration
- `.pre-commit-config.yaml` - Quality gates
- `package.json` - Scripts and dependencies

---

## Next Steps

1. **Clone and explore**: `git clone https://github.com/openclaw/openclaw.git`
2. **Read the docs**: Start with `/docs/concepts/` for architecture
3. **Study patterns**: Look at hooks, config, and session management
4. **Build something**: Apply patterns to your own project
5. **Contribute**: Fix bugs or add features to learn more

## Resources

- **Full Documentation**: https://docs.openclaw.ai
- **Source Code**: https://github.com/openclaw/openclaw
- **Discord Community**: https://discord.gg/clawd
- **Contributing Guide**: `/CONTRIBUTING.md`
- **Windows Setup**: `/docs/platforms/windows.md`
- **Hooks Deep Dive**: `/docs/automation/hooks.md`

---

**TL;DR for Windows Users:**

1. Install WSL2: `wsl --install`
2. Enable systemd in `/etc/wsl.conf`
3. Install Node 22+ and pnpm
4. Clone and build OpenClaw
5. Study hooks (`src/hooks/`), config (`src/config/`), and session management
6. Apply patterns to your own projects
7. Use pre-commit hooks for quality gates
8. Build with TypeScript, Vitest, and modern tools
