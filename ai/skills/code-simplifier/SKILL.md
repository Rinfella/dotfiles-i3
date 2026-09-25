---
name: code-simplifier
description: Analyzes complex or lengthy files and suggests refactoring strategies to simplify logical paths.
---

# Code Simplifier

This skill helps you clean up complex code, reduce indentation levels, split bloated functions, and make files more readable.

## Core Rules
1. **Rule of 30**: A function should rarely exceed 30 lines of code. If it does, consider extracting helper functions.
2. **Minimize Nesting**: Prefer early returns (guard clauses) to nested `if` blocks.
3. **Descriptive Naming**: Rename variables and functions to describe *what* they represent/do clearly without needing long comments.
4. **DRY (Don't Repeat Yourself)**: Extract duplicated code blocks into reusable utilities.

## Simplification Process
- Analyze the target file/function.
- Highlight blocks with high cyclomatic complexity (e.g. nested loops, deep condition trees).
- Suggest concrete refactoring options with side-by-side or draft comparisons.
