cask "orbpeek" do
  version "1.1.0"
  sha256 "8e604ff840ba2d09feeee11c79ebdd5de7a64bee5aaf4dff13cf54b8a39f936c"

  url "https://github.com/zhiyozhao/OrbPeek/releases/download/v#{version}/OrbPeek-#{version}.dmg"
  name "OrbPeek"
  desc "Dock windows to any screen edge and slide them back in on hover"
  homepage "https://github.com/zhiyozhao/OrbPeek"

  depends_on macos: :sonoma

  # A running menu-bar agent; quit it before replacing the app.
  preflight do
    system_command "/usr/bin/pkill", args: ["-x", "OrbPeek"], must_succeed: false
  end

  app "OrbPeek.app"

  # Self-signed, not notarized: strip the download quarantine so the app
  # opens without the Gatekeeper dance. Accessibility and Screen Recording
  # grants survive updates because every build is signed with the same
  # stable certificate.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/OrbPeek.app"],
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
