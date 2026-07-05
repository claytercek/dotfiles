Never include a co-author attribution in commit messages

When executing tasks in a task list, use a subagent for each task

Never write documentation, comments, or anything that references CLAUDE.md, AGENTS.md, or any other code agent configuration. They are all deliberately git-ignored. Same goes for ADRs, local markdown plans, local issues, etc.

When working on long task lists, commit incrementally with conventional commit messages to document progress and make it easier to revert if needed. Don't wait until the end to write a single commit. Use the caveman-commit skill to write your commit messages.

Keep a clean git history. Use `--fixup` and `--amend` where applicable. Each commit in the final history should represent one logical, complete unit of change.

Don't worry about backwards compatibility when making API changes unless explicitly asked to. 
