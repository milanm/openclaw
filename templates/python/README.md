# Python Project Template

Production-ready Python project template with OpenClaw best practices.

## Quick Start

```bash
python -m venv venv
source venv/bin/activate  # Windows: venv\Scripts\activate
pip install -r requirements.txt
```

## What's Included

- **AGENTS.md** - AI coding assistant guidelines for Python
- **pyproject.toml** - Project configuration
- **requirements.txt** - Dependencies
- **.gitignore** - Standard Python ignores
- **Example source and tests (pytest)**

## Features

- ✅ Python 3.10+
- ✅ Type hints with mypy
- ✅ Black for formatting
- ✅ Ruff/Flake8 for linting
- ✅ pytest for testing
- ✅ GitHub Actions CI/CD
- ✅ AI assistant ready

## Commands

```bash
python -m pytest          # Run tests
python -m black .         # Format code
python -m ruff check .    # Lint code
python -m mypy .          # Type check
```

## Learn More

- [OpenClaw Learning Guide](../../docs/reference/learning-guide.md)
- [Python Documentation](https://docs.python.org/)
