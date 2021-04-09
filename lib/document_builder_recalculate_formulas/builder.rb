# frozen_string_literal: true

module DocumentBuilderRecalculateFormulas
  # Class for interface for builder
  class Builder
    # @param [String] exe path to executable
    def initialize(exe = 'documentbuilder')
      @exe = exe
    end

    # @return [Gem::Version] version of builder
    def version
      Gem::Version.new(cleanup_version)
    rescue StandardError => e
      puts("Cannot get builder version because of `#{e}`")
      'unknown'
    end

    # Build script file
    # @param [String] file path
    def build_file(file)
      `#{@exe} #{file}`
    end

    private

    # @return [String] raw version string
    def raw_version
      `#{@exe} -v`
    end

    # @return [String] cleaned-up version string
    def cleanup_version
      raw_version.split("\n")
                 .first
                 .delete('v')
    end
  end
end
