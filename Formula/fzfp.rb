# typed: strict
# frozen_string_literal: true

# Build and install the fzfp CLI and its manual from release source.
class Fzfp < Formula
  desc "Fuzzy finder with Mandarin pinyin matching"
  homepage "https://github.com/zhiyozhao/fzf-pinyin"
  url "https://github.com/zhiyozhao/fzf-pinyin/archive/refs/tags/fzfp-v0.1.0.tar.gz"
  sha256 "a394e2d06a644625ff73988b823aaca2ff851cee7a76b9e28889cfc7af6257b3"
  license "MIT"

  depends_on "go" => :build

  def install
    ldflags = "-s -w -X main.version=#{version} -X main.revision="
    system "go", "build", *std_go_args(ldflags:), "."
    man1.install "man/man1/fzfp.1"
  end

  test do
    assert_equal "北京\n", pipe_output("#{bin}/fzfp --filter=bj", "北京\n上海\n", 0)
    assert_match "fzfp #{version} (based on fzf", shell_output("#{bin}/fzfp --version")
  end
end
