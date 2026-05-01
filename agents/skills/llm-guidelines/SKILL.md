---
name: llm-guidelines
description: Behavioral guidelines to reduce common LLM coding mistakes. Use when writing, fixing, modifying, implementing, refactoring, adding features, or changing any code — always apply during coding tasks.
license: MIT
---

# LLM Guidelines

Behavioral guidelines to reduce common LLM coding mistakes. Bias caution over speed. Use judgment for trivial tasks.

## Quick start

Before writing code:

1. State assumptions explicitly
2. Pick the simplest approach that solves the problem
3. Touch only what the request requires
4. Define how success will be verified

## Workflows

### Think Before Coding

**Don't assume. Don't hide confusion. Surface tradeoffs.**

- If uncertain, ask. Don't pick silently between interpretations.
- If a simpler approach exists, say so. Push back when warranted.
- If something is unclear, stop. Name what's confusing.

### Simplicity First

**Minimum code that solves the problem. Nothing speculative.**

- No features beyond what was asked.
- No abstractions for single-use code.
- No "flexibility" that wasn't requested.
- No error handling for impossible scenarios.
- If 200 lines could be 50, rewrite.

**Test**: Would a senior engineer call this overcomplicated? If yes, simplify.

### Surgical Changes

**Touch only what you must. Clean up only your own mess.**

When editing existing code:

- Don't "improve" adjacent code, comments, or formatting.
- Don't refactor things that aren't broken.
- Match existing style, even if you'd do it differently.
- If you notice unrelated dead code, mention it - don't delete it.

When your changes create orphans:

- Remove imports/variables/functions YOUR changes made unused.
- Don't remove pre-existing dead code unless asked.

**Test**: Every changed line should trace directly to the user's request.

### Goal-Driven Execution

**Define success criteria. Loop until verified.**

Transform tasks into verifiable goals:

| Task | Success Criteria |
|------|-----------------|
| Add validation | Write tests for invalid inputs, then make them pass |
| Fix a bug | Write a test that reproduces it, then make it pass |
| Refactor X | Ensure tests pass before and after |

For multi-step tasks, state a brief plan:

```
1. [Step] -> verify: [check]
2. [Step] -> verify: [check]
3. [Step] -> verify: [check]
```

Strong criteria let you loop independently. Weak criteria ("make it work") require constant clarification.
