# AI Coding Assistant Guidelines

This file provides instructions for AI coding assistants (Claude Code, GitHub Copilot, Cursor, etc.) helping develop this project.

## Project Overview

<!-- Replace with your project description -->
This project uses modern development practices and tooling.

## Tech Stack

<!-- Update this section for your technology stack -->
- **Language**: [Your Language]
- **Runtime**: [Your Runtime/Platform]
- **Package Manager**: [Your Package Manager]
- **Testing Framework**: [Your Test Framework]
- **Build Tool**: [Your Build Tool]

## File Structure

```
src/           # Source code
test/          # Tests
scripts/       # Build and utility scripts
docs/          # Documentation
```

## Code Style

### General Principles

- **Consistency**: Follow existing code patterns
- **Clarity**: Write self-documenting code
- **Simplicity**: Keep it simple, avoid over-engineering
- **Testability**: Write code that's easy to test

### File Organization

- Keep files focused on a single responsibility
- Extract helpers to separate files when they grow
- Colocate related functionality
- Use clear, descriptive file names

### Naming Conventions

<!-- Adjust for your language -->
- Types/Classes: `PascalCase`
- Functions/Methods: `camelCase` or `snake_case`
- Constants: `SCREAMING_SNAKE_CASE` or `PascalCase`
- Files: `kebab-case` or language conventions

### Error Handling

```
// Provide clear error messages
// Log errors appropriately
// Fail fast for programmer errors
// Graceful degradation for user errors
```

## Testing

### Testing Philosophy

- **Test behavior**, not implementation
- Use descriptive test names
- One assertion per test (when possible)
- Clean up resources after tests
- Mock external dependencies
- Aim for >80% coverage

### Test File Naming

- `*.test.*` - Unit tests
- `*.integration.test.*` - Integration tests
- `*.e2e.test.*` - End-to-end tests

## Commit Guidelines

### Use the Commit Helper

```bash
./scripts/commit "feat: add new feature" src/feature.*
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
- ❌ Build artifacts
- ❌ Dependencies (unless adding new ones)
- ❌ IDE files (unless project-specific)

## Pre-commit Hooks

Automatically run before each commit:
- Code linting/formatting
- Test execution
- File hygiene checks

Install with your pre-commit framework.

## Best Practices

### Code Quality

- Write self-documenting code
- Add comments for complex logic
- Keep functions small and focused
- Avoid deep nesting
- Use meaningful variable names

### Performance

- Optimize when necessary, not prematurely
- Profile before optimizing
- Consider algorithmic complexity
- Cache expensive operations when appropriate

### Security

- Never commit secrets or credentials
- Validate all inputs
- Sanitize outputs
- Use parameterized queries
- Keep dependencies updated

## What NOT to Do

- ❌ Don't commit commented-out code
- ❌ Don't commit debugging statements
- ❌ Don't ignore warnings without investigation
- ❌ Don't copy-paste code without understanding it
- ❌ Don't skip writing tests
- ❌ Don't hardcode configuration values

## When Stuck

1. Read the error message carefully
2. Check the documentation
3. Run the tests
4. Look at existing code for patterns
5. Ask for clarification if requirements are unclear

## Project-Specific Notes

<!-- Add your project-specific guidelines here -->

### Architecture

<!-- Describe your architecture -->

### API Conventions

<!-- Document your API patterns -->

### Database Schema

<!-- Document your data models -->

### Business Logic

<!-- Explain domain-specific rules -->

---

**Note**: This template is based on [OpenClaw](https://github.com/openclaw/openclaw) best practices.
For more patterns, see the [Learning Guide](../../docs/reference/learning-guide.md).
