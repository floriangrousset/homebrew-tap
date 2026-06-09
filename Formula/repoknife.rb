class Repoknife < Formula
  desc "Single-file bash TUI swiss-army-knife for a tree of git repos (gh/az/gitflow)"
  homepage "https://github.com/floriangrousset/repoknife"
  url "https://github.com/floriangrousset/repoknife/archive/refs/tags/v1.8.0.tar.gz"
  sha256 "b5d541dd7dfbfff32b056e1bd2feb5b5a3913cce579e93546c397e4346bf5389"
  license "MIT"
  head "https://github.com/floriangrousset/repoknife.git", branch: "develop"

  depends_on "bash" # script requires bash >= 4.4; macOS system bash is 3.2
  depends_on "fzf"  # all list pickers
  depends_on "gh"   # GitHub API + PRs + runs
  depends_on "gum"  # menus / confirm / spin / style
  depends_on "jq"   # JSON parsing
  # `git` is intentionally NOT a dependency — macOS (Xcode CLT) always provides it.
  # `az` (Azure DevOps), `lazygit`, and `glab` are optional — see caveats.

  def install
    bin.install "repoknife"
    # Rewrite the `#!/usr/bin/env bash` shebang to the brewed bash so the
    # bash>=4.4 guard is satisfied regardless of the user's PATH order.
    inreplace bin/"repoknife", %r{\A#!/usr/bin/env bash},
              "#!#{Formula["bash"].opt_bin}/bash"
  end

  def caveats
    <<~EOS
      repoknife manages a tree of git repos under a "code root" folder —
      treat ~/Code like Documents/Pictures/Music: a first-class home for code.

        ~/Code/github/<org>/<repo>
        ~/Code/gitlab/<org>/<project>/<repo>
        ~/Code/azure-devops/<org>/<project>/<repo>

      First run:
        mkdir -p ~/Code
        repoknife config            # set code_root (default: ~/Code)

      Config lives at ~/.repoknife.conf (set REPOKNIFE_CFG_FILE to override).

      Optional tools:
        az       Azure DevOps        (brew install azure-cli)
        lazygit  health-screen shortcut
        glab     GitLab CLI
      Enable re-running failed Actions: gh auth refresh -s workflow
    EOS
  end

  test do
    assert_match "repoknife #{version}", shell_output("#{bin}/repoknife --version")
  end
end
