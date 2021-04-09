# frozen_string_literal: true

require_relative 'lib/document_builder_recalculate_formulas'

# @return [String] default path for all formulas files
FILES_PATH = "#{ENV['HOME']}/RubymineProjects/OnlineDocuments/data/data_files/spreadsheet_formulas"

files = Dir["#{FILES_PATH}/*"].sort
recalculator = DocumentBuilderRecalculateFormulas::Recalculator.new

files.each do |file|
  script = recalculator.form_script(file)
  puts("Processing #{file}")
  File.write('./test.docbuilder', script)
  result = recalculator.builder.build_file('./test.docbuilder')
  recalculator.handle_result(file, result)
end
