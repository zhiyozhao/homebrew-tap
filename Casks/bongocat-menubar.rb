cask "bongocat-menubar" do
  version "0.1.7"
  sha256 "421ee151173c342d868d8d7c2901715e15500bf21bd7c88339ffe26c06d789a0"

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
