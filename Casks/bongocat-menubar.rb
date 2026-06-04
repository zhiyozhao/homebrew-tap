cask "bongocat-menubar" do
  version "0.1.4"
  sha256 "09022bf5fcfb7d49b2cf75b68617050cf209b8f8fad61140e7f9c22ed145402d"

  url "https://github.com/zhiyozhao/bongocat-menubar/releases/download/v#{version}/BongoCat-Menubar-v#{version}.dmg"
  name "BongoCat Menubar"
  desc "Menu bar Bongo Cat that types along with you"
  homepage "https://github.com/zhiyozhao/bongocat-menubar"

  preflight do
    system_command "/usr/bin/pkill", args: ["-x", "BongoCat Menubar"], must_succeed: false
    system_command "/usr/bin/tccutil", args: ["reset", "Accessibility", "com.zhiyozhao.bongocat-menubar"]
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
