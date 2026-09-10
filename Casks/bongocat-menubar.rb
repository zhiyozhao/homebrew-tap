cask "bongocat-menubar" do
  version "1.0.2"
  sha256 "ee8f9e4aea621e1b681dead64c32b6a85a318b2810b3d52ce2bb0fe48a48b928"

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
