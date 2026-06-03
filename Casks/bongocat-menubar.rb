cask "bongocat-menubar" do
  version "0.1.0"
  sha256 "0d3eb201bc396c0f47aa6510062e910c62cdb5cb42f58992bb8a15fa702529f6"

  url "https://github.com/zhiyozhao/bongocat-menubar/releases/download/v#{version}/BongoCat-Menubar-v#{version}.dmg"
  name "BongoCat Menubar"
  desc "Menu bar Bongo Cat that types along with you"
  homepage "https://github.com/zhiyozhao/bongocat-menubar"

  app "BongoCat Menubar.app"

  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-cr", "#{appdir}/BongoCat Menubar.app"]
  end

  zap trash: [
    "~/Library/Application Support/BongoCat Menubar",
  ]
end
