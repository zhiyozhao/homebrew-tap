cask "menumew" do
  version "0.1.0"
  sha256 "84a89dd395f167512281c7c52313de6e51718efc546175b4c9f402aaf90447e5"

  url "https://github.com/zhiyozhao/bongocat-menubar/releases/download/v#{version}/MenuMew-v#{version}.dmg"
  name "MenuMew"
  desc "Menu bar Bongo Cat that types along with you"
  homepage "https://github.com/zhiyozhao/bongocat-menubar"

  app "MenuMew.app"

  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-cr", "#{appdir}/MenuMew.app"]
  end

  zap trash: [
    "~/Library/Application Support/MenuMew",
  ]
end
