---
name: dev-loop
description: Autonomous serial dev loop — claim ready tickets from the configured tracker one at a time, implement, review clean in a fresh subagent, land, close; ralph-loop drives iteration until the queue is empty.
disable-model-invocation: true
---

# Dev Loop

Burn down the ready queue one ticket at a time: **claim → implement → review clean → land → close → next**. The ralph-loop plugin re-feeds the iteration prompt every time you try to stop, so the loop persists until the queue is genuinely empty. The **tracker is the only state**: every iteration rediscovers its work by querying, and hands results back by commenting and closing — nothing rides between iterations except what the tracker and git hold.

Requires the ralph-loop plugin and the `## Agent project config` block (tracker + triage label) in `AGENTS.md`/`CLAUDE.md`. Missing either → stop and tell the user; `/setup-my-skills` writes the config block.

## Invocation

```
/dev-loop [--linear] [--max-iterations N]
```

- `--linear` — series mode: every ticket commits directly to the current branch; no per-ticket branches, no merges.
- `--max-iterations N` — the ralph safety net (default 30). One iteration ≈ one ticket, so size it to the queue with slack for resumed tickets.

## Setup (once, before the loop)

1. Resolve the **tracker** and **triage label** from the `## Agent project config` block.
2. Note the current branch — that is the **target branch** every ticket merges back to (or, in linear mode, commits to). Require a clean working tree: dev-loop commits must not mix with the user's half-done work. Dirty tree → stop and report.
3. Run the ready query (Iteration step 1). Empty queue → report and stop; the loop never starts.
4. Compose the **iteration prompt** — one line, resolved values filled in, no quote characters inside:

   > Read <absolute path of this SKILL.md> and run one Iteration of the dev loop. Mode: <branch-per-ticket | linear>. Target branch: <branch>. Tracker: <tracker>. Triage label: <label>.

5. Start the loop — invoke the `ralph-loop:ralph-loop` skill with args:

   ```
   "<iteration prompt>" --max-iterations <N> --completion-promise "NO READY TICKETS REMAIN"
   ```

6. Ralph only replays the prompt when you try to stop — begin the first Iteration immediately.

## Iteration

0. **Resume** — an unfinished ticket outranks a new claim. Standing on a `dev-loop/*` branch, or holding a claimed ticket that is open and not parked? Rejoin it at whichever step it stands.
1. **Query** — a ticket is **ready** when it carries the triage label, has no assignee, and every ticket its "Blocked by" section references is closed. None ready → Finish.
2. **Claim** — take the oldest ready ticket: assign yourself and set it in progress (where the tracker has such a status). The claim is what keeps a second agent — or a future you — from double-picking it.
3. **Branch** — branch-per-ticket mode: `git checkout -b dev-loop/<id>-<slug> <target-branch>`. Linear mode: stay on the target branch and record `git rev-parse HEAD` as this ticket's review base.
4. **Implement** — fetch the full ticket (body and comments) and run the `/implement` skill with the ticket as the spec. One override: when `/implement` reaches its review step, use the Review below instead of running `/code-review` inline.
5. **Review** — spawn a fresh subagent (model: sonnet) as the reviewer. A reviewer that watched the code being written inherits the writer's blind spots; the fresh context is the point. Its prompt carries: the repo root, the diff command (`git diff <target-branch>...HEAD`, or in linear mode `git diff <review-base>...HEAD`), the ticket reference to fetch as the spec, and this brief: *read `~/.claude/skills/code-review/SKILL.md` and apply both of its axes yourself, sequentially, inside your own context; report findings split into **blocking** and **non-blocking**, under 400 words.* Fix every blocking finding, commit, and spawn a **new** reviewer. **Clean** = a round with zero blocking findings. Non-blocking findings: apply the cheap ones, carry the rest into the closing comment.
6. **Land** — branch-per-ticket mode: checkout the target branch, `git merge --no-ff dev-loop/<id>-<slug>`, delete the ticket branch. Done when the target branch holds the work and the tree is clean. Linear mode: the work already sits on the branch.
7. **Close** — comment on the ticket: what changed, the landing commit, review rounds, and any non-blocking findings left open. Close it. The tracker now reflects reality, so the next Query cannot return it. End your turn — ralph brings the next iteration.

**Park** (reachable from any step) — when a ticket cannot proceed without a human: contradictory spec, missing access, a design decision that isn't yours to make. Comment what blocks it and what you attempted, leave it assigned and in progress — the assignment is exactly what keeps it out of Query — return to the target branch with the ticket branch left intact, and end your turn.

**Finish** — post the run summary: tickets closed, tickets parked and why. End that same message with `<promise>NO READY TICKETS REMAIN</promise>` — output it only when the Query genuinely returned nothing.

## Context hygiene

The loop is built to survive compaction, not to prevent it. The harness compacts the conversation on its own as it fills; when that happens mid-run, nothing is lost — the re-fed iteration prompt is a standing handoff (mode, target branch, tracker, label, pointer back to this file), and the tracker plus git hold every ticket's state. Treat a compaction as routine: re-read this SKILL.md and rejoin at Resume.

Keep each iteration's residue small so compactions stay rare:

- Fetch only the ticket you claimed — never the whole queue's bodies. Query returns IDs and labels, not prose.
- A closed ticket is dead context; its durable record is the closing comment. Continue from the tracker, not from memory of earlier iterations.
- Bulky exploration inside Implement (reading many files, hunting usages, test-suite runs) goes to subagents that return condensed findings — the same reason Review runs in one.

## Known limitations

- A crashed or cancelled loop leaves its claimed ticket assigned; unassign it by hand to make it ready again.
- Serial by design: one agent, one ticket at a time. Parallel workers, worktrees, and merge queues are deliberately out of scope — run more repos, not more threads.
