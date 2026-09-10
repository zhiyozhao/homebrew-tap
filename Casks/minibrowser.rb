cask "minibrowser" do
  version "1.0.0"
  sha256 "5d4ad73a7aa5c81d6fcd8e02b1b1a21bdd9fb8114755fda4e3f1b7c7c6ae0b21"

  url "https://github.com/zhiyozhao/MiniBrowser/releases/download/v#{version}/MiniBrowser-#{version}.dmg"
  name "MiniBrowser"
  desc "Minimal native macOS browser (WKWebView)"
  homepage "https://github.com/zhiyozhao/MiniBrowser"

  depends_on macos: :ventura

  preflight_steps do
    terminate_process "MiniBrowser"
  end

  app "MiniBrowser.app"

  # Self-signed, not notarized: strip quarantine so the app opens
  # without the Gatekeeper dance. Stable signing identity keeps
  # TCC grants across updates.
  postflight_steps do
    run "/usr/bin/xattr",
        args: ["-dr", "com.apple.quarantine", "{{appdir}}/MiniBrowser.app"],
        must_succeed: false
  end

  zap trash: "~/Library/Preferences/com.zhao.minibrowser.plist"
end
