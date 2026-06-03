cask "bongocat-menubar" do
  version "0.1.3"
  sha256 "c5c6f92bd9faaa835f93e4a903828c253395cf03aed253b9cad7aee27f82771c"

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
