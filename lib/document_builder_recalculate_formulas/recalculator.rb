# frozen_string_literal: true

require 'json'

module DocumentBuilderRecalculateFormulas
  # Class for performing recalculations
  class Recalculator
    # @return [Builder] interface of builder
    attr_reader :builder

    # @param [Builder] builder interface
    def initialize(builder = Builder.new)
      @builder = builder
    end

    # Handle result string
    # @param [String] file path to file
    # @param [String] result of calculation
    def handle_result(file, result)
      if result.include?('error')
        handle_error(file, result)
      else
        puts('OK')
      end
    end

    # Handle errored result
    # @param [String] error string
    def handle_error(file, error)
      known_error = known_error_for_file(file)
      if known_error
        puts("There is known error in this file: #{known_error}")
        puts(error)
      else
        puts("Incorrect result\n#{error}")
      end
    end

    # Return known error for specific file
    # @param [String] file name
    # @return [String, nil] Error or nil if no known error
    def known_error_for_file(file)
      filename = File.basename(file)

      known_errors[filename]
    end

    # @return [Hash] list of known error
    def known_errors
      @known_errors ||= JSON.parse(File.read("#{Dir.pwd}/lib/document_builder_recalculate_formulas/known_errors.json"))
    end

    # Form script for file
    # @param [String] file name
    # @return [String] script result
    def form_script(file)
      script = File.read("#{Dir.pwd}/lib/script.docbuilder")
      script.gsub('$$FILE', file)
    end

    # @return [String] report version
    def report_version
      "builder_v#{builder.version}_project_v#{`git rev-parse --short HEAD`}"
    end
  end
end
