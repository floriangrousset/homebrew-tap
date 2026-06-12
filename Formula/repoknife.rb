class Repoknife < Formula
  desc "Single-file bash TUI swiss-army-knife for a tree of git repos (gh/az/gitflow)"
  homepage "https://github.com/floriangrousset/repoknife"
  url "https://github.com/floriangrousset/repoknife/archive/refs/tags/v1.8.2.tar.gz"
  sha256 "afae5802c83447ca7a58d2f21a3a027da4bfbae77c98609a7d3a7374883de231"
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
      ╔═══════════════════════════════════════════════╗
      ║   🔪  repoknife  ─────────────────────────▶   ║
      ╚═══════════════════════════════════════════════╝
           one blade for your whole tree of git repos

      🌳  ~/Code is a first-class home for code
          (treat it like Documents / Pictures / Music):
            github/<org>/<repo>
            gitlab/<org>/<project>/<repo>
            azure-devops/<org>/<project>/<repo>

      🚀  First run
            mkdir -p ~/Code
            repoknife            # launch the TUI
            repoknife config     # set code_root (default ~/Code)

      ⚙️  Config & paths
            ~/.repoknife.conf      config file  (REPOKNIFE_CFG_FILE relocates)
            REPOKNIFE_CODE_ROOT    pin the code root anywhere

      🧰  Optional sidekicks
            az        Azure DevOps     brew install azure-cli
            glab      GitLab CLI       brew install glab
            lazygit   health 'g' jump  brew install lazygit

      💡  Re-run failed Actions:  gh auth refresh -s workflow
          Slice away  →  repoknife --help
    EOS
  end

  test do
    assert_match "repoknife #{version}", shell_output("#{bin}/repoknife --version")
  end
end
