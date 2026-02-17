# AI Coding Assistant Guidelines

This file provides instructions for AI coding assistants (Claude Code, GitHub Copilot, Cursor, etc.) helping develop this project.

## Project Overview

<!-- Replace with your project description -->
This is a TypeScript project using modern tooling and best practices.

## Tech Stack

- **Language**: TypeScript (ESM, strict mode)
- **Runtime**: Node.js 20+
- **Package Manager**: npm (or pnpm)
- **Linter**: Oxlint
- **Formatter**: Oxfmt
- **Test Framework**: Vitest
- **Build Tool**: tsc (TypeScript compiler)

## File Structure

```
src/           # Source code
test/          # Tests (colocated with source is also fine)
scripts/       # Build and utility scripts
dist/          # Build output (git-ignored)
```

## Code Style

### TypeScript

- **Strict mode**: Always enabled
- **No `any`**: Use proper types or `unknown`
- **ESM imports**: Use `.js` extension for local imports
- **Naming**:
  - Types/Interfaces: `PascalCase`
  - Functions/Variables: `camelCase`
  - Constants: `SCREAMING_SNAKE_CASE`
  - Files: `kebab-case.ts`

### File Organization

- Keep files under ~500 lines
- One main concept per file
- Extract helpers to separate files
- Colocate tests with source (optional)

### Imports

```typescript
// ✅ Good
import { helper } from './utils/helper.js';
import type { Config } from './types.js';

// ❌ Avoid
import { helper } from './utils/helper';  // Missing .js
import { Config } from './types.js';      // Should be type-only
```

### Error Handling

```typescript
// ✅ Good - Specific errors
class ValidationError extends Error {
  constructor(message: string) {
    super(message);
    this.name = 'ValidationError';
  }
}

// ✅ Good - Graceful degradation
try {
  const data = await fetchData();
  return data;
} catch (err) {
  console.error('Fetch failed:', err);
  return fallbackData;
}

// ❌ Avoid - Silent failures
try {
  await riskyOperation();
} catch {}  // Don't swallow errors
```

## Testing

### Framework: Vitest

```typescript
import { describe, test, expect } from 'vitest';

describe('MyFunction', () => {
  test('handles valid input', () => {
    const result = myFunction('valid');
    expect(result).toBe('expected');
  });

  test('throws on invalid input', () => {
    expect(() => myFunction('invalid')).toThrow();
  });
});
```

### Testing Guidelines

- **Test behavior**, not implementation
- Use descriptive test names
- One assertion per test (when possible)
- Clean up resources in `afterEach`
- Mock external dependencies
- Aim for >80% coverage

### Test File Naming

- `*.test.ts` - Unit tests
- `*.integration.test.ts` - Integration tests
- `*.e2e.test.ts` - End-to-end tests

## Commands

```bash
# Development
npm run build         # Build TypeScript
npm run typecheck     # Type check only
npm test              # Run tests
npm run test:watch    # Watch mode
npm run test:coverage # With coverage

# Quality
npm run lint          # Check with Oxlint
npm run format        # Check formatting
npm run format:fix    # Auto-fix formatting
npm run check         # Run all checks
```

## Commit Guidelines

### Use the Commit Helper

```bash
./scripts/commit "feat: add new feature" src/feature.ts
```

### Commit Message Format

```
<type>: <description>

[optional body]
```

**Types:**
- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation
- `style`: Formatting (no code change)
- `refactor`: Code restructuring
- `test`: Adding tests
- `chore`: Maintenance

**Examples:**
```
feat: add user authentication
fix: resolve null pointer in validator
docs: update API documentation
refactor: extract helper functions
```

### What to Commit

- ✅ Source code changes
- ✅ Test updates
- ✅ Documentation updates
- ✅ Configuration changes
- ❌ Build artifacts (`dist/`)
- ❌ Dependencies (`node_modules/`)
- ❌ IDE files (`.vscode/` is project-specific, so it's OK)

## Pre-commit Hooks

Automatically run before each commit:
- Trailing whitespace removal
- End-of-file fixer
- YAML validation
- Large file check
- Oxlint (auto-fix)
- Oxfmt (auto-format)

Install with: `npx prek install`

## Best Practices

### Async/Await

```typescript
// ✅ Good - Parallel when possible
const [users, posts] = await Promise.all([
  fetchUsers(),
  fetchPosts(),
]);

// ✅ Good - Sequential when needed
const user = await fetchUser(id);
const posts = await fetchUserPosts(user.id);

// ❌ Avoid - Unnecessary sequential
const users = await fetchUsers();
const posts = await fetchPosts();  // Could be parallel
```

### Type Safety

```typescript
// ✅ Good - Proper types
interface User {
  id: string;
  name: string;
  email: string;
}

function getUser(id: string): User {
  // ...
}

// ❌ Avoid - Using any
function getUser(id: any): any {
  // ...
}
```

### Configuration

```typescript
// ✅ Good - Type-safe config
interface Config {
  apiUrl: string;
  timeout: number;
}

const config: Config = {
  apiUrl: process.env.API_URL || 'http://localhost:3000',
  timeout: Number(process.env.TIMEOUT) || 5000,
};

// ❌ Avoid - Untyped config
const config = {
  apiUrl: process.env.API_URL,
  timeout: process.env.TIMEOUT,
};
```

## What NOT to Do

- ❌ Don't use `any` (use `unknown` if type is truly unknown)
- ❌ Don't disable TypeScript checks (`@ts-ignore`, `@ts-nocheck`)
- ❌ Don't commit commented-out code
- ❌ Don't commit `console.log` debugging statements
- ❌ Don't mutate function parameters
- ❌ Don't use `var` (use `const` or `let`)

## When Stuck

1. Read the error message carefully
2. Check types with `npm run typecheck`
3. Run tests with `npm test`
4. Check linter with `npm run lint`
5. Look at existing code for patterns
6. Ask for clarification if requirements are unclear

## Project-Specific Notes

<!-- Add your project-specific guidelines here -->

---

**Note**: This template is based on [OpenClaw](https://github.com/openclaw/openclaw) best practices.
For more patterns, see the [Learning Guide](../../docs/reference/learning-guide.md).
