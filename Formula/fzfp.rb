# typed: strict
# frozen_string_literal: true

class Fzfp < Formula
  desc "Fuzzy finder with Mandarin pinyin matching"
  homepage "https://github.com/zhiyozhao/fzf-pinyin"
  version "0.2.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/zhiyozhao/fzf-pinyin/releases/download/fzfp-v0.2.0/fzfp-0.2.0-darwin_arm64.tar.gz"
      sha256 "30f539e390fd54dd6ff0e8f619072b8b6accdda47ca9098505f41169aa277184"
    end
    on_intel do
      url "https://github.com/zhiyozhao/fzf-pinyin/releases/download/fzfp-v0.2.0/fzfp-0.2.0-darwin_amd64.tar.gz"
      sha256 "6901f05f07db9a2c29cd263df544d6d1c577c99ec25db27890dc30aa742face2"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/zhiyozhao/fzf-pinyin/releases/download/fzfp-v0.2.0/fzfp-0.2.0-linux_arm64.tar.gz"
      sha256 "a9b3b1b0f877e2f792202f9d4f63a81963566803e79f0e31d4a933b97fe0037e"
    end
    on_intel do
      url "https://github.com/zhiyozhao/fzf-pinyin/releases/download/fzfp-v0.2.0/fzfp-0.2.0-linux_amd64.tar.gz"
      sha256 "f83d7a1ea2736e38f12698cdc439bb0092a46d4ffc322e6fc4c703ecdfa5b627"
    end
  end

  def install
    bin.install "fzfp"
    man1.install "fzfp.1"
  end

  test do
    assert_equal "北京\n", pipe_output("#{bin}/fzfp --filter=bj", "北京\n上海\n", 0)
    assert_match "fzfp #{version} (based on fzf", shell_output("#{bin}/fzfp --version")
  end
end
