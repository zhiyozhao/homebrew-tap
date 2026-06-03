cask "menumew" do
  version "0.1.0"
  sha256 :no_check

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
