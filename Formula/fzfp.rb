# typed: strict
# frozen_string_literal: true

class Fzfp < Formula
  desc "Fuzzy finder with Mandarin pinyin matching"
  homepage "https://github.com/zhiyozhao/fzf-pinyin"
  version "0.1.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/zhiyozhao/fzf-pinyin/releases/download/fzfp-v0.1.1/fzfp-0.1.1-darwin_arm64.tar.gz"
      sha256 "7cac0b4b8c171be39da1f9e8c2bbbbf84223508fd898ad4168b2c9a507f68682"
    end
    on_intel do
      url "https://github.com/zhiyozhao/fzf-pinyin/releases/download/fzfp-v0.1.1/fzfp-0.1.1-darwin_amd64.tar.gz"
      sha256 "677512a0da9a493373e4ed0eb7bb3ec062fcce6fbadd5da9589a87f9ea787f39"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/zhiyozhao/fzf-pinyin/releases/download/fzfp-v0.1.1/fzfp-0.1.1-linux_arm64.tar.gz"
      sha256 "44082b9ad68283f8e95bdc596a652c99141919983320c8f31a357695be8635f2"
    end
    on_intel do
      url "https://github.com/zhiyozhao/fzf-pinyin/releases/download/fzfp-v0.1.1/fzfp-0.1.1-linux_amd64.tar.gz"
      sha256 "cc115e16659964e17dab24a89e80124aacaf152196deab6810b8bad1d535a8fc"
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
