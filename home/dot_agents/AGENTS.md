## Git

- Commit incrementally as you complete each logical unit of work — never
  batch a long task into one commit at the end. Small commits document
  progress and make reverts easy.
- Use the caveman-commit skill to write commit messages.
- Never include a co-author attribution (e.g. "Co-Authored-By: Claude")
  in commit messages.
- Keep the final history clean: use `git commit --fixup` and `--amend` to
  fold corrections into the commit they belong to, rather than adding
  "fix typo" commits. Each commit in the final history should be one
  logical, complete unit of change.

## Agent config files are invisible

CLAUDE.md, AGENTS.md, ADRs, local markdown plans, local issue files, and
all other agent configuration are deliberately git-ignored. Treat them as
if they don't exist in any output that leaves this machine: never mention
or reference them in code comments, documentation, commit messages, PR
descriptions, or anywhere else.

## Scope and design

- Don't preserve backwards compatibility when changing APIs unless
  explicitly asked. Make the clean breaking change.
- Don't expand code to handle every edge case. If an edge case affects a
  tiny fraction of users, document it as a known limitation instead of
  adding code for it. Prefer a smaller codebase with stated limitations
  over a larger one that handles everything.

## Subagent usage

- Delegate to subagents any task that would generate a lot of intermediate
  output I don't need in the main context: codebase exploration, searching for
  usages, reading many files, running and interpreting test suites, log
  analysis. Have the subagent return only a condensed summary of findings.
- Match the subagent's model to the task, using the Agent tool's model
  parameter:
  - **haiku**: file discovery, grep-style searches, simple lookups,
    mechanical transformations
  - **sonnet**: reading and summarizing code, routine implementation,
    code review, writing tests
  - **opus / inherit**: only for tasks needing real architectural reasoning
    or complex debugging
- Prefer the cheapest model that can do the job reliably; don't inherit the
  main session's model by default.
- Run independent subagent tasks in parallel rather than sequentially.