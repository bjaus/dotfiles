---
description: Generate a git commit message
---

Generate a comprehensive git commit message for the current changes:

1. Create a clear, concise subject line (50 chars or less)
2. Add a blank line
3. Write a detailed body explaining:
   - What changed
   - Why it changed
   - Any side effects or considerations

Follow conventional commit format:
- feat: New feature
- fix: Bug fix
- docs: Documentation
- style: Formatting
- refactor: Code restructuring
- test: Adding tests
- chore: Maintenance

Example:
```
feat: Add user authentication system

- Implemented JWT-based authentication
- Added login/logout endpoints
- Created user session management
- Added password hashing with bcrypt

Closes #123
```