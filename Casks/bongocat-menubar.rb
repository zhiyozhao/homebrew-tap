cask "bongocat-menubar" do
  version "0.1.0"
  sha256 "84a89dd395f167512281c7c52313de6e51718efc546175b4c9f402aaf90447e5"

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
