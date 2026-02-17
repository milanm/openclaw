# Quick Start: Create Your Template Repository in 5 Minutes

This is the fastest way to get your own template repository on GitHub.

## Prerequisites

- GitHub account
- Git installed
- Terminal/Command line access
- OpenClaw repository cloned locally

## 5-Minute Setup

### 1️⃣ Create GitHub Repository (2 minutes)

Visit: **https://github.com/new**

Fill in:
```
Repository name:     project-templates
Description:         Language-agnostic project scaffolding with AI assistant integration
Visibility:          ● Public
```

Check:
- ✅ Add a README file
- ✅ Add .gitignore: None (we'll generate our own)
- ✅ Choose a license: MIT License

Click: **"Create repository"**

📝 **Save this URL**: `https://github.com/<YOUR-USERNAME>/project-templates.git`

---

### 2️⃣ Run Initialization Script (2 minutes)

```bash
# Create a directory for your new repo
mkdir ~/project-templates
cd ~/project-templates

# Run the initialization script from OpenClaw
# (Replace /path/to/openclaw with actual path)
/path/to/openclaw/scripts/init-standalone-repo.sh .

# Review what was created
ls -la
```

You should see:
```
README.md
CONTRIBUTING.md
.gitignore
scripts/
templates/
docs/
```

---

### 3️⃣ Initialize Git and Push (1 minute)

```bash
# Initialize git repository
git init

# Add all files
git add .

# Make initial commit
git commit -m "Initial commit: Project templates from OpenClaw"

# Add your GitHub repository as remote
# Replace <YOUR-USERNAME> with your GitHub username
git remote add origin https://github.com/<YOUR-USERNAME>/project-templates.git

# Set main branch and push
git branch -M main
git push -u origin main
```

---

### ✅ Done!

Your repository is now live at:
**`https://github.com/<YOUR-USERNAME>/project-templates`**

---

## Test Your New Repository

```bash
# Clone your new repository
cd ~/
git clone https://github.com/<YOUR-USERNAME>/project-templates.git test-templates
cd test-templates

# Try creating a project
./scripts/create-project.sh --lang typescript my-test-project

# Verify it worked
ls my-test-project/
```

You should see:
```
AGENTS.md
CLAUDE.md
README.md
package.json
src/
test/
tsconfig.json
vitest.config.ts
```

---

## Share with Others

Now anyone can use your templates:

```bash
git clone https://github.com/<YOUR-USERNAME>/project-templates.git
cd project-templates
./scripts/create-project.sh my-awesome-project
```

---

## What to Do Next

### Add GitHub Topics

1. Go to your repository on GitHub
2. Click the ⚙️ icon next to "About"
3. Add topics:
   - `project-template`
   - `scaffolding`
   - `ai-assistant`
   - `claude-code`
   - `github-copilot`
   - `typescript`
   - `csharp`
   - `ruby`
   - `python`

### Enable Features

In repository Settings:
- ✅ Issues
- ✅ Discussions
- ✅ Wiki (optional)

### Share It!

- Tweet about it
- Share in Discord/Slack
- Add to your GitHub profile README
- Link from your other projects

---

## Common Issues

**Issue**: "Permission denied" when running script
```bash
# Solution: Make script executable
chmod +x /path/to/openclaw/scripts/init-standalone-repo.sh
```

**Issue**: "templates/ directory not found"
```bash
# Solution: Run from OpenClaw repository root
cd /path/to/openclaw
./scripts/init-standalone-repo.sh ~/project-templates
```

**Issue**: Git push rejected
```bash
# Solution: Pull first (if you added README on GitHub)
git pull origin main --rebase
git push origin main
```

---

## Copy-Paste Commands

Replace `<YOUR-USERNAME>` with your GitHub username and run:

```bash
# Step 1: Create directory
mkdir ~/project-templates && cd ~/project-templates

# Step 2: Run init script (adjust path to OpenClaw)
~/openclaw/scripts/init-standalone-repo.sh .

# Step 3: Git setup
git init
git add .
git commit -m "Initial commit: Project templates from OpenClaw"
git remote add origin https://github.com/<YOUR-USERNAME>/project-templates.git
git branch -M main
git push -u origin main

# Step 4: Test it
cd ~
git clone https://github.com/<YOUR-USERNAME>/project-templates.git test-templates
cd test-templates
./scripts/create-project.sh --lang typescript my-test
ls my-test/
```

---

## That's It! 🎉

You now have:
- ✅ Your own template repository on GitHub
- ✅ All languages: TypeScript, C#, Ruby, Python, Base
- ✅ AI assistant integration (AGENTS.md, CLAUDE.md)
- ✅ Complete documentation
- ✅ Ready to share and use

**Total time**: ~5 minutes
**Effort**: Minimal (mostly automated)
**Result**: Professional template repository

---

## Need Help?

- See `templates/SETUP_STANDALONE_REPO.md` for detailed guide
- See `templates/STANDALONE_REPOSITORY.md` for overview
- Check OpenClaw docs: https://docs.openclaw.ai
