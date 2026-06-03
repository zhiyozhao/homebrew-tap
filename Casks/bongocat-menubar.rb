cask "bongocat-menubar" do
  version "0.1.2"
  sha256 "cb42542cce8dbd90c36cd1e313da0b5f94c1bc4fe1b610ebd772613dc17bd21e"

  url "https://github.com/zhiyozhao/bongocat-menubar/releases/download/v#{version}/BongoCat-Menubar-v#{version}.dmg"
  name "BongoCat Menubar"
  desc "Menu bar Bongo Cat that types along with you"
  homepage "https://github.com/zhiyozhao/bongocat-menubar"

  preflight do
    system_command "/usr/bin/pkill", args: ["-x", "BongoCat Menubar"], must_succeed: false
    system_command "/usr/bin/tccutil", args: ["reset", "Accessibility", "com.zhiyozhao.bongocat-menubar"], must_succeed: false
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
