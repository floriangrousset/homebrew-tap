# homebrew-tap

Homebrew formulae by Florian Grousset.

## Install

```bash
brew install floriangrousset/tap/repoknife
```

That expands to `brew tap floriangrousset/homebrew-tap` + `brew install repoknife`.

## Formulae

| Formula | What |
|---|---|
| `repoknife` | single-file bash TUI for managing a tree of git repos — clone, pull, PRs, CI runs, health, branch hygiene, gitflow init. See [floriangrousset/repoknife](https://github.com/floriangrousset/repoknife). |

The `repoknife` "binary" on your PATH **is** the plain bash script (its shebang
rewritten to the brewed bash). No compilation. Upgrade with `brew upgrade repoknife`.
