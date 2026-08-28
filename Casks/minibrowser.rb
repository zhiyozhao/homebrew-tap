cask "minibrowser" do
  version "1.0.2"
  sha256 "755dd235bc2bbb0277d87d870805e50c738c8659f4ad910b699ea41d1cdc0ad9"

  url "https://github.com/zhiyozhao/MiniBrowser/releases/download/v#{version}/MiniBrowser-#{version}.dmg"
  name "MiniBrowser"
  desc "Minimal native macOS browser (WKWebView)"
  homepage "https://github.com/zhiyozhao/MiniBrowser"

  depends_on macos: :ventura

  preflight do
    system_command "/usr/bin/pkill", args: ["-x", "MiniBrowser"], must_succeed: false
  end

  app "MiniBrowser.app"

  # Self-signed, not notarized: strip quarantine so the app opens
  # without the Gatekeeper dance. Stable signing identity keeps
  # TCC grants across updates.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/MiniBrowser.app"],
                   must_succeed: false
  end

  caveats do
    unsigned_accessibility
  end

  zap trash: "~/Library/Preferences/com.zhao.minibrowser.plist"
end
