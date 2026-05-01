---
name: update-mpocock-skills
description: Update local skills in agents/skills/ to match upstream versions from mattpocock/skills on GitHub, then offer to import new skills. Use when user wants to update skills, sync skills, bootstrap skills, or mentions mattpocock skills.
---

# Update Matt Pocock Skills

Sync local skills with upstream versions from `https://github.com/mattpocock/skills`.

## Path Resolution

Resolve these paths **in order** before executing:

### `{SKILLS_DIR}`

Check the following options **in order**. Stop at the first match and do NOT check remaining options:

1. `../` relative to this SKILL.md — check if it exists and contains skill subdirectories. If yes, use it and stop.
2. `~/.dotfiles/agents/skills/` — check if it exists and contains skill subdirectories. If yes, use it and stop.
3. `~/.agents/skills/` — check if it exists and contains skill subdirectories. If yes, use it and stop.
4. Fall back: create `~/.agents/skills/` and use it.

### `{CONFIG_PATH}`

Search for the opencode config file **in order**:

1. Walk up from `{SKILLS_DIR}` and check for `opencode/opencode.json` in each parent directory. Use the first match.
2. Fall back to `~/.config/opencode/opencode.json`.

Use the matched paths for all subsequent references.

## Workflow

1. **Discover local skills** - list directories in `{SKILLS_DIR}`
2. **Fetch upstream catalog** - dynamically discover all skills from GitHub API
3. **Ask which to bootstrap** - if no local skills exist, ask user category by category which upstream skills to install
4. **Match & update** - for each local skill that exists upstream, compare and update if changed
5. **Report results** - show imported, updated, current, and local-only skills
6. **Offer imports** - present remaining upstream skills not yet installed, ask if user wants any

## Upstream Source

Base URLs:
- GitHub API: `https://api.github.com/repos/mattpocock/skills/contents/skills/`
- Raw content: `https://raw.githubusercontent.com/mattpocock/skills/main/skills/`

Categories (discover dynamically, do not hardcode):
- Fetch `{API_BASE}` to get all category directories
- For each category, fetch `{API_BASE}{category}` to get skill directories
- Build a map: `skill-name -> {category, raw_url}` where `raw_url = {RAW_BASE}{category}/{skill-name}/SKILL.md`

## Execution Steps

### Step 1: List local skills

Read the `{SKILLS_DIR}` directory. Each subdirectory name is an installed skill. If the directory doesn't exist, create it and treat as empty.

### Step 2: Discover upstream catalog

Use the GitHub Contents API to dynamically build the full catalog:

1. Fetch `https://api.github.com/repos/mattpocock/skills/contents/skills/` to get category directories (type: "dir")
2. For each category, fetch `https://api.github.com/repos/mattpocock/skills/contents/skills/{category}` to get entries
3. Filter entries where `type: "dir"` - these are skill directories
4. Build the map: `skill-name -> {category, raw_url}`

### Step 3: Bootstrap missing skills (interactive)

If `{SKILLS_DIR}` is empty or has no skills matching the upstream catalog:

1. Get the list of upstream categories (sorted alphabetically)
2. For each category, ask the user using the `question` tool with `multiple: true`:
   - Header: the category name
   - Question: "Import skills from {category}?"
   - Options: the skill names in that category (no category suffix needed since already grouped)
3. For each selected skill across all categories:
   - **Add to opencode permissions**: ask the user "Allow `{skill-name}` to run without prompting?"
     - If yes: insert `"{skill-name}*": "allow"` into the `permission.skill` object in `{CONFIG_PATH}`
     - If no: the `"*": "ask"` wildcard already covers it, no config change needed
   - Create directory `{SKILLS_DIR}/{skill-name}/`
   - Fetch raw `SKILL.md` using `webfetch` with `format: "text"`
   - Write the file
   - Track as `imported`
4. Generate `{SKILLS_DIR}/.gitignore` with only the selected skill directory names (one per line, e.g., `caveman/`, `grill-me/`)
5. If user selects no skills across all categories, skip to Step 4 (no skills to update, so proceed to import offer)

### Step 4: Compare & update (existing install)

For each local skill:
- Look up in the upstream map
- If found upstream:
  - Fetch the raw `SKILL.md` using `webfetch` with `format: "text"`
  - Read the local `SKILL.md`
  - Compare content (normalize trailing whitespace before comparing)
  - If different, overwrite local file with upstream content
  - Track status: `updated` or `up-to-date`
- If NOT found upstream:
  - Track as `local-only` (do NOT modify)

After processing all skills, regenerate `{SKILLS_DIR}/.gitignore` with only the local skill directories that match upstream (one per line). This keeps the ignore list in sync with what the user has chosen to keep from upstream.

### Step 5: Report

Show a summary:
```
Imported: caveman, grill-me, tdd, ...
Updated: write-a-skill
Up-to-date: llm-guidelines
Local-only (not in upstream): my-custom-skill
```

Omit sections with no items. If nothing changed, say so concisely.

### Step 6: Offer imports

Collect all upstream skills NOT currently installed locally. Group by category (sorted alphabetically).

For each category that has available skills, ask the user using the `question` tool with `multiple: true`:
- Header: the category name
- Question: "Import skills from {category}?"
- Options: the skill names in that category (no category suffix needed since already grouped)

For each selected skill:
1. **Add to opencode permissions**: ask the user "Allow `{skill-name}` to run without prompting?"
   - If yes: insert `"{skill-name}*": "allow"` into the `permission.skill` object in `{CONFIG_PATH}`
   - If no: the `"*": "ask"` wildcard already covers it, no config change needed
2. Create directory `{SKILLS_DIR}/{skill-name}/`
3. Fetch raw `SKILL.md` from upstream using `webfetch` with `format: "text"`
4. Write the file
5. Confirm import success

After importing, append only the newly selected skill directories to `{SKILLS_DIR}/.gitignore`.

If no skills available to import, skip this step.

## Config Editing

When adding a skill permission to `{CONFIG_PATH}`:

1. Read the file and locate the `permission.skill` object
2. Insert the new entry after the `"*": "ask"` line, maintaining alphabetical order with existing entries
3. Format: `    "{skill-name}*": "allow",`
4. Ensure the last entry in the object has no trailing comma, and all other entries have trailing commas
5. If `permission.skill` does not exist, create it as a new object inside `permission`

## Important Notes

- **NEVER modify local-only skills** - skills that don't exist upstream must not be touched
- **NEVER commit upstream skill content** - the `{SKILLS_DIR}/.gitignore` file itself IS committed, but the skill directories listed in it are ignored
- **Maintain `{SKILLS_DIR}/.gitignore` selectively** - after any bootstrap/update/import, this file should only contain directories for skills the user has explicitly selected from upstream. Local-only skills (custom skills not from upstream) must NOT be added to `.gitignore`
- **Always ask before bootstrap/import** - never automatically download skills; always present options to the user
- **Always ask before adding permission** - ask the user if they want to allow each new skill to run without prompting
- Use `format: "text"` for webfetch to get exact file content for comparison
- Preserve exact upstream content when updating - do not reformat or modify
- If the GitHub API fails, fall back to fetching category pages directly from GitHub and parsing the directory listing
- Handle rate limits gracefully - if API returns 403, inform the user and suggest retrying later
