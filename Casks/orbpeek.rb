cask "orbpeek" do
  version "1.1.4"
  sha256 "1266f93fbd4c725b8faff67611fd734e0385a850b80f878720c442a027c3ce5c"

  url "https://github.com/zhiyozhao/OrbPeek/releases/download/v#{version}/OrbPeek-#{version}.dmg"
  name "OrbPeek"
  desc "Dock windows to any screen edge and reveal them on hover"
  homepage "https://github.com/zhiyozhao/OrbPeek"

  depends_on macos: :sonoma

  app "OrbPeek.app"

  # A running menu-bar agent; quit it before replacing the app.
  preflight_steps do
    terminate_process "OrbPeek"
  end

  # Self-signed, not notarized: strip the download quarantine so the app
  # opens without the Gatekeeper dance. Accessibility and Screen Recording
  # grants survive updates because every build is signed with the same
  # stable certificate.
  postflight_steps do
    run "/usr/bin/xattr",
        args:         ["-dr", "com.apple.quarantine", "{{appdir}}/OrbPeek.app"],
        must_succeed: false
  end

  zap trash: [
    "~/.config/orbpeek",
    "~/Library/Application Support/OrbPeek",
    "~/Library/Logs/orbpeek.log",
    "~/Library/Preferences/com.orbpeek.OrbPeek.plist",
  ]

  caveats do
    unsigned_accessibility
  end
end
