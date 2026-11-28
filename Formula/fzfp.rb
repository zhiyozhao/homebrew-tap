# typed: strict
# frozen_string_literal: true

class Fzfp < Formula
  desc "Fuzzy finder with Mandarin pinyin matching"
  homepage "https://github.com/zhiyozhao/fzf-pinyin"
  version "0.2.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/zhiyozhao/fzf-pinyin/releases/download/fzfp-v0.2.1/fzfp-0.2.1-darwin_arm64.tar.gz"
      sha256 "e02396f0a32e6c91361a969dafbc47ac567e739c42bfdc6f63e1ebbfa3570b3c"
    end
    on_intel do
      url "https://github.com/zhiyozhao/fzf-pinyin/releases/download/fzfp-v0.2.1/fzfp-0.2.1-darwin_amd64.tar.gz"
      sha256 "152616554a947a2c74c5f68519f40297abb9431fb3df86b9dbd99cebad5326e6"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/zhiyozhao/fzf-pinyin/releases/download/fzfp-v0.2.1/fzfp-0.2.1-linux_arm64.tar.gz"
      sha256 "75aad885f9cbabd2c83c33be4fcf91a7172c93905c555ba1d0a033397100d40c"
    end
    on_intel do
      url "https://github.com/zhiyozhao/fzf-pinyin/releases/download/fzfp-v0.2.1/fzfp-0.2.1-linux_amd64.tar.gz"
      sha256 "663628204fa282726609b5f451b307ba43728f59513b251bc487c4fe1605720a"
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
