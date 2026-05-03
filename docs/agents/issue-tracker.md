# Issue tracker: GitLab

Issues and PRDs for this repo live as GitLab issues. Use the [`glab`](https://gitlab.com/gitlab-org/cli) CLI for all operations.

## Conventions

- **Create an issue**: `glab issue create --title "..." --description "..."`. Use a heredoc for multi-line descriptions. Pass `--description -` to open an editor.
- **Read an issue**: `glab issue view <number> --comments`. Use `-F json` for machine-readable output.
- **List issues**: `glab issue list --state opened -F json` with appropriate `--label` filters. Note that GitLab uses `opened` (not `open`) for the state value.
- **Comment on an issue**: `glab issue note <number> --message "..."`. GitLab calls comments "notes".
- **Apply / remove labels**: `glab issue update <number> --label "..."` / `--unlabel "..."`. Multiple labels can be comma-separated or by repeating the flag.
- **Close**: `glab issue close <number>`. `glab issue close` does not accept a closing comment, so post the explanation first with `glab issue note <number> --message "..."`, then close.
- **Merge requests**: GitLab calls PRs "merge requests". Use `glab mr create`, `glab mr view`, `glab mr note`, etc. — the same shape as `gh pr ...` with `mr` in place of `pr` and `note`/`--message` in place of `comment`/`--body`.

Infer the repo from `git remote -v` — `glab` does this automatically when run inside a clone.

## When a skill says "publish to the issue tracker"

Create a GitLab issue.

## When a skill says "fetch the relevant ticket"

Run `glab issue view <number> --comments`.

## Issue linking

Issue links are bi-directional relationships between issues. Use the Issue Tracker API to create, list, and delete links.

### Create a link

```bash
glab api --method POST "projects/<namespace_id>/issues/<blocked_id>/links?target_project_id=<namespace_id>&target_issue_iid=<blocker_id>&link_type=<link_type>"
```

- The issue in the URL path is the BLOCKED issue (the one waiting).
- `target_issue_iid` is the BLOCKER (the one that must complete first).
- `link_type`: `relates_to` (available on all tiers), `blocks` or `is_blocked_by` (may require a paid tier — see [linked issues docs](https://docs.gitlab.com/ee/api/issue_links.html)).
- Defaults to `relates_to` if `link_type` is omitted.

### Probe for blocking support

Attempt a `link_type=blocks` request with a real dependency pair. If HTTP 201, blocking is available. If HTTP 403 or 422, fall back to `relates_to`. Cache the result for the session.

### List links for an issue

```bash
glab api "projects/<namespace_id>/issues/<id>/links"
```

### Delete a link

```bash
glab api --method DELETE "projects/<namespace_id>/issues/<id>/links/<issue_link_id>"
```
