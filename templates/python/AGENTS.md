# AI Coding Assistant Guidelines - Python

## Project Overview

This is a Python project using modern practices.

## Tech Stack

- **Language**: Python 3.10+
- **Testing**: pytest
- **Linter**: Ruff / Flake8
- **Formatter**: Black
- **Type Checker**: mypy
- **Package Manager**: pip / poetry

## Code Style

### Naming Conventions

- **Classes**: `PascalCase` (e.g., `UserService`, `PaymentProcessor`)
- **Functions/Methods**: `snake_case` (e.g., `get_user_by_id`, `process_payment`)
- **Variables**: `snake_case` (e.g., `user_id`, `first_name`)
- **Constants**: `SCREAMING_SNAKE_CASE` (e.g., `MAX_RETRIES`, `API_KEY`)
- **Private**: `_leading_underscore` (e.g., `_internal_method`)
- **Files**: `snake_case.py` (e.g., `user_service.py`)

### Best Practices

- Follow PEP 8 (enforced by Black and Ruff)
- Use type hints for function signatures
- Prefer list comprehensions over map/filter
- Use context managers (`with` statements)
- Write docstrings for public APIs

### Example

```python
from typing import Optional

class UserService:
    def __init__(self, user_repository: UserRepository) -> None:
        self._user_repository = user_repository
    
    def get_user_by_id(self, user_id: int) -> Optional[User]:
        """Get user by ID.
        
        Args:
            user_id: The user's unique identifier
            
        Returns:
            User object if found, None otherwise
            
        Raises:
            ValueError: If user_id is invalid
        """
        if user_id <= 0:
            raise ValueError("User ID must be positive")
        
        return self._user_repository.find(user_id)
```

## Testing (pytest)

```python
import pytest

def test_get_user_by_id_valid_id():
    # Arrange
    repository = MockUserRepository()
    service = UserService(repository)
    
    # Act
    user = service.get_user_by_id(1)
    
    # Assert
    assert user is not None
    assert user.id == 1

def test_get_user_by_id_invalid_id():
    service = UserService(MockUserRepository())
    
    with pytest.raises(ValueError):
        service.get_user_by_id(-1)
```

## Commit Guidelines

Follow conventional commits:

```
feat: add user authentication
fix: resolve None reference in UserService
docs: update API documentation
```

## What NOT to Do

- ❌ Don't use mutable default arguments
- ❌ Don't catch broad exceptions without re-raising
- ❌ Don't use `from module import *`
- ❌ Don't ignore type checker warnings
- ❌ Don't use bare `except:` clauses

---

Based on [OpenClaw](https://github.com/openclaw/openclaw) best practices.
