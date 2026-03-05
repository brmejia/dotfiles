const ENV_PREFIX_RE = /^([A-Za-z_][A-Za-z0-9_]*=[^ ]* +)+/;

const RULES: [RegExp, (cmd: string) => string][] = [
  [/^git\s+status(\s|$)/, (c) => c.replace(/^git status/, "rtk git status")],
  [/^git\s+diff(\s|$)/, (c) => c.replace(/^git diff/, "rtk git diff")],
  [/^git\s+log(\s|$)/, (c) => c.replace(/^git log/, "rtk git log")],
  [/^git\s+add(\s|$)/, (c) => c.replace(/^git add/, "rtk git add")],
  [/^git\s+commit(\s|$)/, (c) => c.replace(/^git commit/, "rtk git commit")],
  [/^git\s+push(\s|$)/, (c) => c.replace(/^git push/, "rtk git push")],
  [/^git\s+pull(\s|$)/, (c) => c.replace(/^git pull/, "rtk git pull")],
  [/^git\s+branch(\s|$)/, (c) => c.replace(/^git branch/, "rtk git branch")],
  [/^git\s+fetch(\s|$)/, (c) => c.replace(/^git fetch/, "rtk git fetch")],
  [/^git\s+stash(\s|$)/, (c) => c.replace(/^git stash/, "rtk git stash")],
  [/^git\s+show(\s|$)/, (c) => c.replace(/^git show/, "rtk git show")],

  [/^gh\s+(pr|issue|run|api|release)(\s|$)/, (c) => c.replace(/^gh /, "rtk gh ")],

  [/^cargo\s+test(\s|$)/, (c) => c.replace(/^cargo test/, "rtk cargo test")],
  [/^cargo\s+build(\s|$)/, (c) => c.replace(/^cargo build/, "rtk cargo build")],
  [/^cargo\s+clippy(\s|$)/, (c) => c.replace(/^cargo clippy/, "rtk cargo clippy")],
  [/^cargo\s+check(\s|$)/, (c) => c.replace(/^cargo check/, "rtk cargo check")],
  [/^cargo\s+install(\s|$)/, (c) => c.replace(/^cargo install/, "rtk cargo install")],
  [/^cargo\s+nextest(\s|$)/, (c) => c.replace(/^cargo nextest/, "rtk cargo nextest")],
  [/^cargo\s+fmt(\s|$)/, (c) => c.replace(/^cargo fmt/, "rtk cargo fmt")],

  [/^(cat|bat)\s+/, (c) => c.replace(/^cat /, "rtk read ")],
  [/^(rg|grep)\s+/, (c) => c.replace(/^(rg|grep) /, "rtk grep ")],
  [/^ls(\s|$)/, (c) => c.replace(/^ls/, "rtk ls")],
  [/^tree(\s|$)/, (c) => c.replace(/^tree/, "rtk tree")],
  [/^(find|fd)\s+/, (c) => c.replace(/^find /, "rtk find ")],
  [/^diff\s+/, (c) => c.replace(/^diff /, "rtk diff ")],
  [
    /^head\s+-(\d+)\s+(.+)/,
    (c) => {
      const m = c.match(/^head\s+-(\d+)\s+(.+)/);
      return m ? `rtk read ${m[2]} --max-lines ${m[1]}` : c;
    },
  ],
  [
    /^head\s+--lines=(\d+)\s+(.+)/,
    (c) => {
      const m = c.match(/^head\s+--lines=(\d+)\s+(.+)/);
      return m ? `rtk read ${m[2]} --max-lines ${m[1]}` : c;
    },
  ],

  [
    /^(pnpm\s+)?(npx\s+)?vitest(\s|$)/,
    (c) => c.replace(/^(pnpm )?(npx )?vitest( run)?/, "rtk vitest run"),
  ],
  [/^pnpm\s+test(\s|$)/, (c) => c.replace(/^pnpm test/, "rtk vitest run")],
  [/^npm\s+test(\s|$)/, (c) => c.replace(/^npm test/, "rtk npm test")],
  [/^npm\s+run\s+/, (c) => c.replace(/^npm run /, "rtk npm ")],
  [/^(npx\s+)?vue-tsc(\s|$)/, (c) => c.replace(/^(npx )?vue-tsc/, "rtk tsc")],
  [/^pnpm\s+tsc(\s|$)/, (c) => c.replace(/^pnpm tsc/, "rtk tsc")],
  [/^(npx\s+)?tsc(\s|$)/, (c) => c.replace(/^(npx )?tsc/, "rtk tsc")],
  [/^pnpm\s+lint(\s|$)/, (c) => c.replace(/^pnpm lint/, "rtk lint")],
  [/^(npx\s+)?eslint(\s|$)/, (c) => c.replace(/^(npx )?eslint/, "rtk lint")],
  [/^(npx\s+)?prettier(\s|$)/, (c) => c.replace(/^(npx )?prettier/, "rtk prettier")],
  [/^(npx\s+)?playwright(\s|$)/, (c) => c.replace(/^(npx )?playwright/, "rtk playwright")],
  [/^pnpm\s+playwright(\s|$)/, (c) => c.replace(/^pnpm playwright/, "rtk playwright")],
  [/^(npx\s+)?prisma(\s|$)/, (c) => c.replace(/^(npx )?prisma/, "rtk prisma")],

  [/^(docker|podman)\s+compose(\s|$)/, (c) => c.replace(/^docker /, "rtk docker ")],
  [
    /^(docker|podman)\s+(ps|images|logs|run|build|exec)(\s|$)/,
    (c) => c.replace(/^docker /, "rtk docker "),
  ],
  [/^kubectl\s+(get|logs|describe|apply)(\s|$)/, (c) => c.replace(/^kubectl /, "rtk kubectl ")],

  [/^curl\s+/, (c) => c.replace(/^curl /, "rtk curl ")],
  [/^wget\s+/, (c) => c.replace(/^wget /, "rtk wget ")],

  [/^pnpm\s+(list|ls|outdated)(\s|$)/, (c) => c.replace(/^pnpm /, "rtk pnpm ")],

  [/^pytest(\s|$)/, (c) => c.replace(/^pytest/, "rtk pytest")],
  [/^python\s+-m\s+pytest(\s|$)/, (c) => c.replace(/^python -m pytest/, "rtk pytest")],
  [/^ruff\s+(check|format)(\s|$)/, (c) => c.replace(/^ruff /, "rtk ruff ")],
  [/^pip\s+(list|outdated|install|show)(\s|$)/, (c) => c.replace(/^pip /, "rtk pip ")],
  [/^uv\s+pip\s+(list|outdated|install|show)(\s|$)/, (c) => c.replace(/^uv pip /, "rtk pip ")],
  [/^mypy(\s|$)/, (c) => c.replace(/^mypy/, "rtk mypy")],
  [/^python\s+-m\s+mypy(\s|$)/, (c) => c.replace(/^python -m mypy/, "rtk mypy")],

  [/^go\s+test(\s|$)/, (c) => c.replace(/^go test/, "rtk go test")],
  [/^go\s+build(\s|$)/, (c) => c.replace(/^go build/, "rtk go build")],
  [/^go\s+vet(\s|$)/, (c) => c.replace(/^go vet/, "rtk go vet")],
  [/^golangci-lint(\s|$)/, (c) => c.replace(/^golangci-lint/, "rtk golangci-lint")],
  [/^mix\s+phx\.routes(\s|$)/, (c) => c.replace(/^mix phx\.routes/, "rtk --cache mix phx.routes")],
  [/^mix\s+ash\.info(\s|$)/, (c) => c.replace(/^mix ash\.info/, "rtk --cache mix ash.info")],
  [/^mix\s+test(\s|$)/, (c) => c.replace(/^mix test/, "rtk test mix test")],
  [/^mix\s+credo(\s|$)/, (c) => c.replace(/^mix credo/, "rtk lint mix credo")],
  [/^mix\s+format(\s|$)/, (c) => c.replace(/^mix format/, "rtk format mix format")],
  [/^mix\s+dialyzer(\s|$)/, (c) => c.replace(/^mix dialyzer/, "rtk err mix dialyzer")],
  [/^mix\s+compile(\s|$)/, (c) => c.replace(/^mix compile/, "rtk mix compile")],
  [
    /^mix\s+ecto\.(migrate|migrations)(\s|$)/,
    (c) => c.replace(/^mix ecto\.(migrate|migrations)/, "rtk mix ecto.$1"),
  ],
  [/^mix\s+help(\s|$)/, (c) => c.replace(/^mix help/, "rtk --cache mix help")],
  [/^mix\s+/, (c) => c.replace(/^mix /, "rtk mix ")],
  [/^iex\s+/, (c) => c.replace(/^iex /, "rtk iex ")],
];

export function rewrite(command: unknown): string | null {
  if (typeof command !== "string") return null;

  if (/^(.*\/)?rtk\s/.test(command)) return null;

  if (command.indexOf("<<") !== -1) return null;

  const envMatch = command.match(ENV_PREFIX_RE);
  const envPrefix = envMatch ? envMatch[0] : "";
  const body = envPrefix ? command.slice(envPrefix.length) : command;

  for (const [pattern, rewriter] of RULES) {
    if (pattern.test(body)) {
      return envPrefix + rewriter(body);
    }
  }

  return null;
}
