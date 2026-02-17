# AI Coding Assistant Guidelines - Ruby

## Project Overview

This is a Ruby project using modern practices.

## Tech Stack

- **Language**: Ruby 3.0+
- **Testing**: RSpec / Minitest
- **Linter**: RuboCop
- **Package Manager**: Bundler

## Code Style

### Naming Conventions

- **Classes/Modules**: `PascalCase` (e.g., `UserService`, `PaymentProcessor`)
- **Methods**: `snake_case` (e.g., `get_user_by_id`, `process_payment`)
- **Variables**: `snake_case` (e.g., `user_id`, `first_name`)
- **Constants**: `SCREAMING_SNAKE_CASE` (e.g., `MAX_RETRIES`, `API_KEY`)
- **Files**: `snake_case.rb` (e.g., `user_service.rb`)

### Best Practices

- Follow Ruby Style Guide (enforced by RuboCop)
- Prefer symbols over strings for hash keys
- Use `do...end` for multi-line blocks, `{...}` for single-line
- Avoid `unless` with `else`
- Use meaningful variable names

### Example

```ruby
class UserService
  def initialize(user_repository)
    @user_repository = user_repository
  end
  
  def find_user(id)
    raise ArgumentError, "Invalid ID" unless id.positive?
    
    @user_repository.find(id)
  end
  
  def create_user(attributes)
    user = User.new(attributes)
    user.save ? user : raise(ValidationError, user.errors.full_messages)
  end
end
```

## Testing (RSpec)

```ruby
describe UserService do
  describe '#find_user' do
    it 'returns user when found' do
      repository = double('repository')
      service = UserService.new(repository)
      
      expect(repository).to receive(:find).with(1).and_return(user)
      expect(service.find_user(1)).to eq(user)
    end
  end
end
```

## Commit Guidelines

Follow conventional commits:

```
feat: add user authentication
fix: resolve nil pointer in UserService
docs: update API documentation
```

## What NOT to Do

- ❌ Don't use `for` loops (use `.each`, `.map`, etc.)
- ❌ Don't modify frozen strings
- ❌ Don't use global variables
- ❌ Don't ignore RuboCop warnings without good reason
- ❌ Don't nest code too deeply (prefer guard clauses)

---

Based on [OpenClaw](https://github.com/openclaw/openclaw) best practices.
