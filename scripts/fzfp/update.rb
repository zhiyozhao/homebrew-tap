# frozen_string_literal: true

require 'digest'
require 'tempfile'

# Standard-library only; also compatible with macOS system Ruby.
module FzfpFormula
  PLATFORMS = %w[darwin_arm64 darwin_amd64 linux_arm64 linux_amd64].freeze

  def self.render(tag, directory)
    raise 'Invalid release tag' unless /\Afzfp-v\d+\.\d+\.\d+\z/.match?(tag)

    version = tag.delete_prefix('fzfp-v')
    sums = {}
    File.foreach(File.join(directory, 'checksums.txt')) do |line|
      match = /\A([0-9a-f]{64})  (\S+)\s*\z/.match(line)
      raise 'Invalid checksums line' unless match
      raise 'Duplicate checksum' if sums.key?(match[2])

      sums[match[2]] = match[1]
    end
    hashes = PLATFORMS.map do |platform|
      name = "fzfp-#{version}-#{platform}.tar.gz"
      sum = sums.fetch(name) { raise "Missing checksum: #{name}" }
      raise "Invalid checksum: #{name}" if sum == '0' * 64
      raise "SHA256 mismatch: #{name}" unless Digest::SHA256.file(File.join(directory, name)).hexdigest == sum

      sum
    end
    formula = File.read(File.join(__dir__, 'fzfp.rb'))
    formula = formula.sub(/^# Draft:.*\n/, '')
    template_version = formula[/^  version "([^"]+)"$/, 1]
    raise 'Missing template version' unless template_version

    # The template uses this version only in version/asset URLs; revisit if adding other versioned text.
    formula = formula.gsub(template_version, version)
    hashes.each { |sum| formula = formula.sub('0' * 64, sum) }
    raise 'Unfilled formula' if formula.include?('0' * 64)

    formula
  end
end

if $PROGRAM_NAME == __FILE__
  abort 'Usage: ruby update.rb TAG ASSET_DIRECTORY OUTPUT' unless ARGV.size == 3
  tag, directory, output = ARGV
  content = FzfpFormula.render(tag, directory)
  # Validate everything before replacing an existing formula.
  Tempfile.create(['fzfp', '.rb'], File.dirname(output)) do |file|
    file.write(content)
    file.chmod(0o644)
    file.close
    File.rename(file.path, output)
  end
end
