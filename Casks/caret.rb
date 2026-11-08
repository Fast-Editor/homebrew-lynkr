cask "caret" do
  arch arm: "aarch64", intel: "x64"

  version "0.2.0"
  sha256 arm:   "7e7d7ee45103a02fac789d49c1a6180c05488b8d7e1b4967d49c61b34c4fc960",
         intel: "9e557380db2c877892f47df6917aa6a508756760424e11108c05aa4b965a8945"

  url "https://github.com/Fast-Editor/Caret/releases/download/v#{version}/Caret_#{version}_#{arch}.dmg"
  name "Caret"
  desc "Cursor-class local AI coding agent and editor (Rust core, Tauri 2)"
  homepage "https://github.com/Fast-Editor/Caret"

  livecheck do
    url :url
    strategy :github_latest
  end

  # Caret has its own tap now: `brew tap fast-editor/caret && brew install --cask caret`.
  deprecate! date: "2026-11-08", because: "it moved to the fast-editor/caret tap", replacement_cask: "fast-editor/caret/caret"

  depends_on macos: :monterey

  app "Caret.app"

  # Builds are ad-hoc signed until a Developer ID is configured. Homebrew quarantines cask downloads, and a quarantined
  # ad-hoc app is refused by Gatekeeper as "damaged", so clear the attribute after moving the app into place.
  # (Legacy `postflight` block: Homebrew 7's `postflight_steps` DSL has no verb for running a command yet.)
  postflight do
    system_command "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "#{appdir}/Caret.app"], sudo: false
  end

  zap trash: [
    "~/.caret",
    "~/Library/Caches/dev.caret.editor",
    "~/Library/WebKit/dev.caret.editor",
  ]
end
