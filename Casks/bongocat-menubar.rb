cask "bongocat-menubar" do
  version "1.0.1"
  sha256 "0ed2d36e295a27ed95ba087baf705727c1a5f9617ff405f354a3e0c43a912729"

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
