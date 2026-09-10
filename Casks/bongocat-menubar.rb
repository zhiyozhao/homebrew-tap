cask "bongocat-menubar" do
  version "1.0.0"
  sha256 "bed315c1ea18e6d98965059be4a1cf9af8826c7d422357410a6125c6646f3daa"

  url "https://github.com/zhiyozhao/bongocat-menubar/releases/download/v#{version}/BongoCat-Menubar-v#{version}.dmg"
  name "BongoCat Menubar"
  desc "Menu bar Bongo Cat that types along with you"
  homepage "https://github.com/zhiyozhao/bongocat-menubar"

  preflight_steps do
    terminate_process "BongoCat Menubar"
  end

  app "BongoCat Menubar.app"

  postflight_steps do
    run "/usr/bin/xattr", args: ["-cr", "{{appdir}}/BongoCat Menubar.app"], must_succeed: false
  end

  caveats do
    unsigned_accessibility
  end
end
