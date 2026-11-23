# typed: strict
# frozen_string_literal: true

# Draft: zero checksums must be replaced from published assets by update.rb.
class Fzfp < Formula
  desc "Fuzzy finder with Mandarin pinyin matching"
  homepage "https://github.com/zhiyozhao/fzf-pinyin"
  version "0.1.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/zhiyozhao/fzf-pinyin/releases/download/fzfp-v0.1.0/fzfp-0.1.0-darwin_arm64.tar.gz"
      sha256 "0000000000000000000000000000000000000000000000000000000000000000"
    end
    on_intel do
      url "https://github.com/zhiyozhao/fzf-pinyin/releases/download/fzfp-v0.1.0/fzfp-0.1.0-darwin_amd64.tar.gz"
      sha256 "0000000000000000000000000000000000000000000000000000000000000000"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/zhiyozhao/fzf-pinyin/releases/download/fzfp-v0.1.0/fzfp-0.1.0-linux_arm64.tar.gz"
      sha256 "0000000000000000000000000000000000000000000000000000000000000000"
    end
    on_intel do
      url "https://github.com/zhiyozhao/fzf-pinyin/releases/download/fzfp-v0.1.0/fzfp-0.1.0-linux_amd64.tar.gz"
      sha256 "0000000000000000000000000000000000000000000000000000000000000000"
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
