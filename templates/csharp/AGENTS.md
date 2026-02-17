# AI Coding Assistant Guidelines - C#/.NET

## Project Overview

This is a C#/.NET project using modern practices.

## Tech Stack

- **Language**: C# (latest version)
- **Runtime**: .NET 8.0+
- **Testing**: xUnit / NUnit
- **Build Tool**: dotnet CLI
- **Package Manager**: NuGet

## Code Style

### Naming Conventions

- **Classes/Interfaces**: `PascalCase` (e.g., `UserService`, `IRepository`)
- **Methods**: `PascalCase` (e.g., `GetUserById`)
- **Properties**: `PascalCase` (e.g., `UserId`, `FirstName`)
- **Private fields**: `_camelCase` (e.g., `_userId`, `_database`)
- **Constants**: `PascalCase` (e.g., `MaxRetries`)
- **Namespaces**: `CompanyName.ProductName.Feature`

### Best Practices

- Enable nullable reference types
- Use `async`/`await` for I/O operations
- Prefer `using` declarations for IDisposable
- Use pattern matching where appropriate
- Follow SOLID principles

### Example

```csharp
public class UserService : IUserService
{
    private readonly IRepository<User> _userRepository;
    
    public UserService(IRepository<User> userRepository)
    {
        _userRepository = userRepository ?? throw new ArgumentNullException(nameof(userRepository));
    }
    
    public async Task<User?> GetUserByIdAsync(int id, CancellationToken cancellationToken = default)
    {
        if (id <= 0)
            throw new ArgumentOutOfRangeException(nameof(id));
            
        return await _userRepository.GetByIdAsync(id, cancellationToken);
    }
}
```

## Testing

```csharp
public class UserServiceTests
{
    [Fact]
    public async Task GetUserByIdAsync_ValidId_ReturnsUser()
    {
        // Arrange
        var mockRepo = new Mock<IRepository<User>>();
        var service = new UserService(mockRepo.Object);
        
        // Act
        var result = await service.GetUserByIdAsync(1);
        
        // Assert
        Assert.NotNull(result);
    }
}
```

## Commit Guidelines

Follow conventional commits:

```
feat: add user authentication
fix: resolve null reference in UserService
docs: update API documentation
```

## What NOT to Do

- ❌ Don't use `var` excessively (be explicit with types when it aids readability)
- ❌ Don't ignore compiler warnings
- ❌ Don't catch exceptions without handling them
- ❌ Don't use `!= null` when you can use pattern matching
- ❌ Don't forget to dispose IDisposable objects

---

Based on [OpenClaw](https://github.com/openclaw/openclaw) best practices.
