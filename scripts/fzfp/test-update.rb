# frozen_string_literal: true

require_relative 'update'
require 'tmpdir'
require 'rbconfig'

def test_version(version)
Dir.mktmpdir('fzfp-formula') do |directory|
  lines = FzfpFormula::PLATFORMS.map do |platform|
    name = "fzfp-#{version}-#{platform}.tar.gz"
    File.write(File.join(directory, name), platform)
    "#{Digest::SHA256.hexdigest(platform)}  #{name}\n"
  end
  manifest = File.join(directory, 'checksums.txt')
  File.write(manifest, lines.join)
  tag = "fzfp-v#{version}"
  formula = FzfpFormula.render(tag, directory)
  raise 'Wrong version' unless formula.include?("version \"#{version}\"")
  raise 'Unfilled placeholder' if formula.include?('__VERSION__')
  raise 'Draft comment retained' if formula.include?('# Draft:')
  FzfpFormula::PLATFORMS.each do |platform|
    url = "https://github.com/zhiyozhao/fzf-pinyin/releases/download/#{tag}/fzfp-#{version}-#{platform}.tar.gz"
    raise 'Wrong asset URL' unless formula.include?(url)
    raise 'Wrong SHA256' unless formula.include?("sha256 \"#{Digest::SHA256.hexdigest(platform)}\"")
  end
  template = File.read(File.join(__dir__, 'fzfp.rb'))
  unrelated = "# Compatibility note: 0.1.0\n"
  raise 'Rewrote unrelated version text' unless FzfpFormula.render(tag, directory, template: template + unrelated) == formula + unrelated
  begin
    FzfpFormula.render(tag, directory, template: template.sub('version "__VERSION__"', 'version "0.1.0"'))
    raise 'Accepted missing version placeholder'
  rescue RuntimeError => e
    raise unless e.message == 'Missing template version placeholder'
  end
  raise 'Wrong platform count' unless formula.scan(/sha256 /).size == 4
  raise 'Not idempotent' unless formula == FzfpFormula.render(tag, directory)
  output = File.join(directory, 'fzfp.rb')
  updater = File.join(__dir__, 'update.rb')
  # A lower release replaces a higher installed formula without semver gating.
  File.write(output, 'version "9.9.9"')
  raise 'CLI failed' unless system(RbConfig.ruby, updater, tag, directory, output)
  raise 'Wrong CLI output' unless File.read(output) == formula
  raise 'Formula must be readable' unless (File.stat(output).mode & 0o777) == 0o644
  [lines[0..2].join, lines.join + lines[0]].each do |bad|
    File.write(manifest, bad)
    begin
      FzfpFormula.render(tag, directory)
    rescue RuntimeError
      next
    end
    raise 'Accepted incomplete or duplicate checksums'
  end
  File.write(manifest, lines.join)
  File.write(File.join(directory, "fzfp-#{version}-linux_amd64.tar.gz"), 'corrupted')
  begin
    FzfpFormula.render(tag, directory)
    raise 'Accepted corrupt archive'
  rescue RuntimeError => e
    raise unless e.message.start_with?('SHA256 mismatch:')
  end
  if system(RbConfig.ruby, updater, tag, directory, output, out: File::NULL, err: File::NULL)
    raise 'CLI accepted corrupt archive'
  end
  raise 'CLI damaged existing formula' unless File.read(output) == formula
end
end
%w[0.1.0 0.2.0].each { |version| test_version(version) }
puts 'Formula updater: two versions, four platforms, placeholders, unchanged version text, checksums and corruption passed'
