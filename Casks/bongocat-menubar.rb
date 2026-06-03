cask "bongocat-menubar" do
  version "0.1.1"
  sha256 "4b6aa5abe5c578b24a61cd5ceb8fd125b095c635f91e803315a0828a825198dd"

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
