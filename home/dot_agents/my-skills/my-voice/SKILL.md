---
name: my-voice
description: Rewrite AI-drafted copy in Clay's personal voice. Use when the user pastes a draft to rewrite, points at a draft file, or says something "sounds like AI" / "doesn't sound like me". ALSO auto-apply whenever drafting prose on Clay's behalf — emails, blog posts, marketing copy, bios, client comms — so the first draft already sounds like him.
---

Rewrite the given text in Clay's voice. Read `VOICE.md` in this skill's directory first — it contains the voice profile, register guides, banned words, and calibration samples of Clay's actual writing. The samples outrank any rule: when a rule and a sample disagree, sound like the samples.

## Workflow

1. **Get the text.** Pasted text: work from the paste. File path: read the file. If you're drafting something new on Clay's behalf, skip to step 3 and write it in-voice from the start.

2. **Infer the register** (client email / blog / marketing-bio / chat) from the content and state your assumption in one line, e.g. "Reading this as a client email." Don't ask, just say what you picked so it's easy to correct.

3. **Full rewrite, not surgical edits.** Keep every fact, commitment, and intent. Rebuild the sentences from scratch in Clay's voice per `VOICE.md`. Preserving the original's structure is not a goal; preserving its meaning is.

4. **Output.**
   - Pasted text: the rewrite, then a short "What changed" list (3-6 bullets, why-level, not line-by-line).
   - File: edit the file in place, then give the change notes in chat.
   - New drafts written on Clay's behalf: just the draft, no change notes.

5. **Self-check before returning.** Scan your rewrite for the banned list in `VOICE.md` (em dashes, leverage/robust/seamless-tier words, rule-of-three trait lists, stock email formalities). If any survived, fix them.
