---
description: Generate a detailed execution plan from a feature spec file
argument-hint: <path/to/feature-spec.md>
agent: explorer
subtask: true
$ARGUMENTS:
  type: string
  description: Path to the feature spec file (required)
  required: true
---

You are helping to generate a detailed execution plan from a feature spec file. Follow the steps below carefully.

User input: $ARGUMENTS

## Step 1. Parse the argument

Extract the spec file path from `$ARGUMENTS`. This is the path to the feature spec markdown file.

If no argument is provided, respond with exactly:
```
Error: No spec file path provided. Usage: plan-feature <path/to/spec.md>
```

## Step 2. Validate input

### 2.1 Check file exists
Verify that the spec file exists at the provided path. If not, respond with exactly:
```
Error: Spec file not found: <path>
```
(Replace `<path>` with the actual file path)

### 2.2 Check file is readable
Verify that the spec file can be read. If there are permission issues, respond with exactly:
```
Error: Cannot read spec file: <path>. Permission denied.
```
(Replace `<path>` with the actual file path)

### 2.3 Check file is not empty
Verify that the spec file has content. If the file is empty, respond with exactly:
```
Error: Spec file is empty.
```

### 2.4 Validate spec format
Read the spec file and verify it contains all required sections. The required sections are:
- ## Meta
- ## Summary
- ## Context & Motivation
- ## Goals
- ## Functional Requirements
- ## Acceptance Criteria

If any required sections are missing, respond with exactly:
```
Error: Invalid spec format. Missing required sections: <list>
```
(Replace `<list>` with a comma-separated list of missing section names)

### 2.5 Check output directory is writable
Transform the spec file path by inserting `.plan` before the extension. For example:
- `<path>/ft_spec.md` → `<path>/ft_spec.plan.md`
- `<path>/feature.md` → `<path>/feature.plan.md`

Check if the directory where the output file will be written is writable. If not, respond with exactly:
```
Error: Cannot write to directory: <dir>. Permission denied.
```
(Replace `<dir>` with the actual directory path)

## Step 3. Read spec content

Read the entire content of the feature spec file.

## Step 4. Generate execution plan

Create a detailed execution plan based on the spec content. The plan must include:

### Overview
A brief summary of what this feature is about.

### File Changes
- **New files**: List any new files that need to be created
- **Modified files**: List any existing files that need to be modified

### Implementation Steps
A numbered sequence of steps to implement the feature.

### Dependencies
External dependencies, libraries, or other features this depends on.

### Risks & Mitigations
Potential risks and how to mitigate them.

### Testing Approach
How to test the implementation.

### Acceptance Criteria Check
Map each acceptance criteria from the spec to verification steps.

## Step 5. Write output

Save the generated plan to the transformed path (spec path with `.plan` inserted before extension).

## Step 6. Success feedback

After successfully generating the plan, respond with exactly:
```
✓ Plan generated successfully
Output: <output_path>
Spec: <input_path>
```
(Replace `<output_path>` and `<input_path>` with the actual paths)
