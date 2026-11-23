# frozen_string_literal: true

require_relative 'update'
require 'tmpdir'
require 'rbconfig'

Dir.mktmpdir('fzfp-formula') do |directory|
  lines = FzfpFormula::PLATFORMS.map do |platform|
    name = "fzfp-0.1.0-#{platform}.tar.gz"
    File.write(File.join(directory, name), platform)
    "#{Digest::SHA256.hexdigest(platform)}  #{name}\n"
  end
  manifest = File.join(directory, 'checksums.txt')
  File.write(manifest, lines.join)
  formula = FzfpFormula.render('fzfp-v0.1.0', directory)
  raise 'Wrong version' unless formula.include?('version "0.1.0"')
  raise 'Wrong platform count' unless formula.scan(/sha256 /).size == 4
  raise 'Not idempotent' unless formula == FzfpFormula.render('fzfp-v0.1.0', directory)
  output = File.join(directory, 'fzfp.rb')
  updater = File.join(__dir__, 'update.rb')
  # A lower release replaces a higher installed formula without semver gating.
  File.write(output, 'version "9.9.9"')
  raise 'CLI failed' unless system(RbConfig.ruby, updater, 'fzfp-v0.1.0', directory, output)
  raise 'Wrong CLI output' unless File.read(output) == formula
  raise 'Formula must be readable' unless (File.stat(output).mode & 0o777) == 0o644
  [lines[0..2].join, lines.join + lines[0]].each do |bad|
    File.write(manifest, bad)
    begin
      FzfpFormula.render('fzfp-v0.1.0', directory)
    rescue RuntimeError
      next
    end
    raise 'Accepted incomplete or duplicate checksums'
  end
  File.write(manifest, lines.join)
  File.write(File.join(directory, 'fzfp-0.1.0-linux_amd64.tar.gz'), 'corrupted')
  begin
    FzfpFormula.render('fzfp-v0.1.0', directory)
    raise 'Accepted corrupt archive'
  rescue RuntimeError => e
    raise unless e.message.start_with?('SHA256 mismatch:')
  end
  if system(RbConfig.ruby, updater, 'fzfp-v0.1.0', directory, output, out: File::NULL, err: File::NULL)
    raise 'CLI accepted corrupt archive'
  end
  raise 'CLI damaged existing formula' unless File.read(output) == formula
end
puts 'Formula updater: four platforms, version, idempotence, missing/duplicate checksums and corruption passed'
