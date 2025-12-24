---
description: Commit staged changes
agent: build
---

Here are the currently staged changes:

`!git diff --cached`

Please review these staged changes and generate an appropriate commit message following these guidelines:

**Commit Message Format:**
- Use conventional commit format: `type(scope): description`
- Types: feat, fix, docs, style, refactor, test, chore, perf
- Keep the first line under 50 characters
- Add a blank line, then a detailed body if needed (wrap at 72 chars)
- Reference issue numbers if applicable (e.g., "Fixes #123")

**What to include:**
- What changed (the "what")
- Why it changed (the "why")
- Any breaking changes or migration notes

After generating the commit message, create the commit using ```git commit``` command with these staged changes only.

Example format:
```
feat(auth): add password reset functionality

Implements password reset flow with email verification.
Users can now request a password reset link that expires
after 1 hour for security.

Fixes #456
```
