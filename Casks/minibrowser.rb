cask "minibrowser" do
  version "1.0.1"
  sha256 "925927b40ff5e1ccd504e915463e5fd3d6df19e7117e8a4a3e34bd32101341e1"

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
