cask "caret" do
  arch arm: "aarch64", intel: "x64"

  version "0.1.0"
  sha256 arm:   "fe79cbac6fe22382f324f867ad7310a172089eb5279698b5f5e71e30d85e451f",
         intel: "972cbc6d42adcbf8b25f49e55ce805435ecd33153e3cd925363ee9ea06836339"

  url "https://github.com/Fast-Editor/Caret/releases/download/v#{version}/Caret_#{version}_#{arch}.dmg"
  name "Caret"
  desc "Cursor-class local AI coding agent and editor (Rust core, Tauri 2)"
  homepage "https://github.com/Fast-Editor/Caret"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: ">= :monterey"

  app "Caret.app"

  # Builds are ad-hoc signed until a Developer ID is configured; install with `--no-quarantine` to skip Gatekeeper's
  # "damaged" dialog, or run `xattr -dr com.apple.quarantine /Applications/Caret.app` afterwards.
  postflight do
    system_command "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "#{appdir}/Caret.app"], sudo: false
  end

  zap trash: [
    "~/.caret",
    "~/Library/Caches/dev.caret.editor",
    "~/Library/WebKit/dev.caret.editor",
  ]
end
