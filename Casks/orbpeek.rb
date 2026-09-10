cask "orbpeek" do
  version "1.0.1"
  sha256 "f96780bcd4d8f83a9d6cde4431c50e23f76d463e39a908bdd575daccfcfc90a9"

  url "https://github.com/zhiyozhao/OrbPeek/releases/download/v#{version}/OrbPeek-#{version}.dmg"
  name "OrbPeek"
  desc "Dock windows to any screen edge and slide them back in on hover"
  homepage "https://github.com/zhiyozhao/OrbPeek"

  depends_on macos: :sonoma

  # A running menu-bar agent; quit it before replacing the app.
  preflight_steps do
    terminate_process "OrbPeek"
  end

  app "OrbPeek.app"

  # Self-signed, not notarized: strip the download quarantine so the app
  # opens without the Gatekeeper dance. Accessibility and Screen Recording
  # grants survive updates because every build is signed with the same
  # stable certificate.
  postflight_steps do
    run "/usr/bin/xattr",
        args: ["-dr", "com.apple.quarantine", "{{appdir}}/OrbPeek.app"],
        must_succeed: false
  end

  caveats do
    unsigned_accessibility
  end

  zap trash: [
    "~/Library/Logs/orbpeek.log",
    "~/Library/Preferences/com.orbpeek.OrbPeek.plist",
  ]
end
