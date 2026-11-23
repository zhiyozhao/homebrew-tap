# typed: strict
# frozen_string_literal: true

class Fzfp < Formula
  desc "Fuzzy finder with Mandarin pinyin matching"
  homepage "https://github.com/zhiyozhao/fzf-pinyin"
  version "0.1.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/zhiyozhao/fzf-pinyin/releases/download/fzfp-v0.1.0/fzfp-0.1.0-darwin_arm64.tar.gz"
      sha256 "da9d7a485125aa68b297860ca90a25f55ec593f548abe36178b5228fe44d4c13"
    end
    on_intel do
      url "https://github.com/zhiyozhao/fzf-pinyin/releases/download/fzfp-v0.1.0/fzfp-0.1.0-darwin_amd64.tar.gz"
      sha256 "02c98720d9cc048cd534896e7f09d1b72976b7d4811c9ad4ba5811be0d10a74c"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/zhiyozhao/fzf-pinyin/releases/download/fzfp-v0.1.0/fzfp-0.1.0-linux_arm64.tar.gz"
      sha256 "6338b1e3366f13a417fe1f23aef834ebfe5363e123006ebe53801a123df24eea"
    end
    on_intel do
      url "https://github.com/zhiyozhao/fzf-pinyin/releases/download/fzfp-v0.1.0/fzfp-0.1.0-linux_amd64.tar.gz"
      sha256 "23309041ff737f3a2eaed2a210e9d7032d54acb24c34fc6aa8e0ae6b5b92f05a"
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
