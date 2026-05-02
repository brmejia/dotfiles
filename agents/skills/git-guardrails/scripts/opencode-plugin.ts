import type { Plugin } from "@opencode-ai/plugin"

const DANGEROUS_PATTERNS = [
  /^git\s+push\b/,
  /^git\s+reset\s+--hard\b/,
  /^git\s+clean\s+-[a-zA-Z]*f[a-zA-Z]*\b/,
  /^git\s+branch\s+-D\b/,
  /^git\s+checkout\s+\.\s*$/,
  /^git\s+restore\s+\.\s*$/,
  /push\s+--force\b/,
  /reset\s+--hard\b/,
]

export const GitGuardrailsPlugin: Plugin = async ({ $ }) => {
  return {
    "tool.execute.before": async (input, output) => {
      const tool = String(input?.tool ?? "").toLowerCase()
      if (tool !== "bash" && tool !== "shell") return
      const args = output?.args
      if (!args || typeof args !== "object") return

      const command = (args as Record<string, unknown>).command
      if (typeof command !== "string" || !command) return

      for (const pattern of DANGEROUS_PATTERNS) {
        if (pattern.test(command)) {
          ;(args as Record<string, unknown>).command =
            `echo "BLOCKED: '${command}' matches dangerous git pattern. The user has prevented you from doing this." >&2 && exit 2`
          return
        }
      }
    },
  }
}
