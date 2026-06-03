cask "bongocat-menubar" do
  version "0.1.0"
  sha256 "d4f77ea637f643932ab554453dc58f44455eeb1d203f2e9f3dcf96665163b7f4"

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
