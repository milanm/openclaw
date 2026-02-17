# Creating a Standalone Template Repository

This guide explains how to create a separate GitHub repository for the OpenClaw project templates.

## Why a Standalone Repository?

Benefits of having templates in a separate repository:
- ✅ Easier to share and distribute
- ✅ Can be used without cloning entire OpenClaw repo
- ✅ Simpler version management for templates
- ✅ Lighter weight for users who just want templates
- ✅ Can be forked and customized independently

## Quick Setup (5 minutes)

### Step 1: Create the Repository on GitHub

1. Go to https://github.com/new
2. Fill in the details:
   - **Repository name**: `project-templates` (or your preferred name)
   - **Description**: "Language-agnostic project scaffolding templates with AI assistant integration"
   - **Visibility**: Public (recommended) or Private
   - **Initialize**: ✅ Add a README file
   - **Add .gitignore**: Node (optional)
   - **Choose a license**: MIT (recommended)

3. Click "Create repository"

### Step 2: Clone Your New Repository

```bash
git clone https://github.com/<your-username>/project-templates.git
cd project-templates
```

### Step 3: Copy Template Files

From the OpenClaw repository:

```bash
# Option 1: Copy just the templates directory
cp -r /path/to/openclaw/templates/* .

# Option 2: Use the initialization script (see below)
```

### Step 4: Customize for Standalone Use

Edit the following files:

**README.md** - Update with standalone repo information:
```markdown
# Project Templates

Language-agnostic project scaffolding templates with AI assistant integration.

Based on [OpenClaw](https://github.com/openclaw/openclaw) best practices.

## Quick Start

\`\`\`bash
# Clone this repository
git clone https://github.com/<your-username>/project-templates.git
cd project-templates

# Create a new project
./scripts/create-project.sh --lang typescript my-project
\`\`\`

## Available Languages

- TypeScript
- C#/.NET
- Ruby
- Python
- Base (generic)

See [templates/README.md](templates/README.md) for details.
```

### Step 5: Update Script Paths

The `scaffold-project.sh` script needs adjustment for standalone use:

```bash
# Create a new script: scripts/create-project.sh
# This wraps the scaffold script with correct paths
```

### Step 6: Commit and Push

```bash
git add .
git commit -m "Initial commit: Add project templates"
git push origin main
```

## Using the Standalone Repository

Once set up, users can:

### Option 1: Clone and Use Locally

```bash
git clone https://github.com/<your-username>/project-templates.git
cd project-templates
./scripts/create-project.sh --lang typescript my-project
```

### Option 2: Direct Template Download

```bash
# Download specific template
curl -L https://github.com/<your-username>/project-templates/archive/main.zip -o templates.zip
unzip templates.zip
cd project-templates-main
./scripts/create-project.sh --lang python my-app
```

### Option 3: Use as Git Submodule

```bash
# In your project
git submodule add https://github.com/<your-username>/project-templates.git .templates
.templates/scripts/create-project.sh --lang ruby my-service
```

## Repository Structure

```
project-templates/
├── README.md                   # Main documentation
├── LICENSE                     # MIT recommended
├── .gitignore                 # Ignore build artifacts
├── scripts/
│   └── create-project.sh      # Project creation script
├── templates/
│   ├── README.md              # Template documentation
│   ├── base/                  # Generic template
│   ├── typescript/            # TypeScript template
│   ├── csharp/                # C# template
│   ├── ruby/                  # Ruby template
│   └── python/                # Python template
└── docs/
    ├── CONTRIBUTING.md        # How to contribute templates
    └── adding-languages.md    # Guide for adding new languages
```

## Maintaining the Repository

### Adding New Languages

1. Create `templates/<language>/` directory
2. Add language-specific `AGENTS.md`
3. Add `README.md` with setup instructions
4. Create symlink `CLAUDE.md -> AGENTS.md`
5. Update main `templates/README.md`
6. Test with `./scripts/create-project.sh --lang <language> test-project`

### Keeping in Sync with OpenClaw

If you want to keep templates synchronized with OpenClaw:

```bash
# Set up OpenClaw as upstream
git remote add upstream https://github.com/openclaw/openclaw.git
git fetch upstream

# Cherry-pick template updates
git cherry-pick <commit-hash>

# Or manually sync
cp -r /path/to/openclaw/templates/* templates/
git add templates/
git commit -m "Sync with OpenClaw templates"
```

## Automation Script

See `scripts/init-standalone-repo.sh` for automated setup.

## Benefits of Standalone Repository

1. **Lightweight**: Users don't need to clone entire OpenClaw repo
2. **Focused**: Only templates and creation tools
3. **Shareable**: Easy to share via URL
4. **Forkable**: Users can customize for their needs
5. **Versioned**: Tag releases for stable versions

## Example Usage

```bash
# Create TypeScript project
git clone https://github.com/username/project-templates.git
cd project-templates
./scripts/create-project.sh my-api
cd my-api
npm install && npm test

# Create C# project
./scripts/create-project.sh --lang csharp MyWebApp
cd MyWebApp
dotnet restore && dotnet build
```

## Support and Contributing

- Issues: File in the standalone repository
- Pull Requests: Welcome for new templates and improvements
- Discussions: Use GitHub Discussions for questions

## License

MIT License (recommended) - See LICENSE file

---

**Note**: While I cannot directly create the GitHub repository for you, following these steps will give you a complete standalone template repository in about 5 minutes!
