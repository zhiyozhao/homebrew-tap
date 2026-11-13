cask "bongocat-menubar" do
  version "1.0.3"
  sha256 "66e13320bc458737343a00f469229467ceccd042eac465ddd3579193b021259c"

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
