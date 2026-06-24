# Add PR standards template and Slack-enabled CI failure notification

## Motivation
Improve repo governance and CI observability for production-style collaboration.

## What Changed
- Added `.github/pull_request_template.md` for consistent PR quality.
- Updated CI workflow (`.github/workflows/dbt-ci.yml`) with Slack failure notification.
- Fixed workflow YAML structure and step placement so CI runs correctly.

## Testing
- Verified local branch is clean and synced:
  - `git status`
  - `git log --oneline -n 5`
- Verified GitHub Actions workflow run is successful.
- Verified `SLACK_WEBHOOK_URL` secret is present.

## Risks / Rollback
- Risk level: Low
- Rollback: Revert workflow/template commit(s) from this branch or PR merge commit.
