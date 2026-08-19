cask "bongocat-menubar" do
  version "0.1.5"
  sha256 "f3b89d41d193f35d7ab5d51c743fd657a75a00bad52d5ad25b8804580d84cb3a"

  url "https://github.com/zhiyozhao/bongocat-menubar/releases/download/v#{version}/BongoCat-Menubar-v#{version}.dmg"
  name "BongoCat Menubar"
  desc "Menu bar Bongo Cat that types along with you"
  homepage "https://github.com/zhiyozhao/bongocat-menubar"

  preflight do
    system_command "/usr/bin/pkill", args: ["-x", "BongoCat Menubar"], must_succeed: false
  end

  app "BongoCat Menubar.app"

  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-cr", "#{appdir}/BongoCat Menubar.app"]
  end

  caveats do
    unsigned_accessibility
  end
end
