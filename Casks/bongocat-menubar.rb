cask "bongocat-menubar" do
  version "0.1.6"
  sha256 "359893ac54f54fca0a9b5ce6dc7c3f3b954edd269ba30eb7664593d3d1e60f19"

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
