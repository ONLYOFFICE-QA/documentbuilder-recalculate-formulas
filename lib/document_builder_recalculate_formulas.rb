# frozen_string_literal: true

# Main namespace for this project
module DocumentBuilderRecalculateFormulas
  # Handle result string
  # @param [String] file path to file
  # @param [String] result of calculation
  def self.handle_result(file, result)
    if result.include?('error')
      handle_error(file, result)
    else
      puts('OK')
    end
  end

  # Handle errored result
  # @param [String] error string
  def self.handle_error(file, error)
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
  def self.known_error_for_file(file)
    filename = File.basename(file)

    known_errors[filename.to_sym]
  end

  # @return [Hash] list of known error
  def self.known_errors
    {
      'DAYS_emb.xlsx': 'Could not calculate date related data'
    }
  end

  # Form script for file
  # @param [String] file name
  # @return [String] script result
  def self.form_script(file)
    "builder.OpenFile(\"#{file}\");\n"\
    "Api.RecalculateAllFormulas(function(obj){\n"\
    "console.log('error: [' + obj.oldValue + ', ' + obj.newValue + '] "\
    "in ' + obj.sheet + ',' + obj.r + ',' + obj.c);\n"\
    "});\n"\
    'builder.CloseFile();'
  end
end
