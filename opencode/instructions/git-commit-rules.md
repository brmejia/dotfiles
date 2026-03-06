# Git Commands

**NEVER chain git commands** (e.g., `git add . && git commit`). Always run them as separate bash calls.

## Commit Messages

Use present tense for the subject line and explain "why" something has changed, not just "what" has changed.

### Conventional Commits
- `feat` – A new feature added to the application
- `fix` – A bug patch
- `docs` – Documentation-only changes
- `style` – Formatting, missing semicolons, whitespace — no logic change
- `refactor` – Code change that neither fixes a bug nor adds a feature
- `perf` – A code change that improves performance
- `test` – Adding missing tests or correcting existing ones
- `build` – Changes affecting the build system or external dependencies (e.g. npm, gulp)
- `ci` – Changes to CI configuration files and scripts (e.g. GitHub Actions, CircleCI)
- `chore` – Maintenance tasks that don't modify src or test files
- `revert` – Reverts a previous commit
- `ops` – Affects infrastructure, deployment, monitoring, or CI/CD pipelines

<Optional body explaining *why* not *what*>

### Breaking Changes
- Use `!` in the header when the change is breaking (e.g., `feat(api)!:`).
- Optionally add a `BREAKING CHANGE:` footer when the "why/impact" needs detail.

### Commit Message Format
```
<type>: <concise_description>

<optional_body_list_explaining_why>
```
