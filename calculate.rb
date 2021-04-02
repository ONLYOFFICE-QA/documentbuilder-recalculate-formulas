# frozen_string_literal: true

require_relative 'lib/document_builder_recalculate_formulas'

DOC_BUILDER_PATH = 'documentbuilder'
FILES_PATH = "#{ENV['HOME']}/RubymineProjects/OnlineDocuments/data/data_files/spreadsheet_formulas"

files = Dir["#{FILES_PATH}/*"].sort

files.each do |file|
  script = DocumentBuilderRecalculateFormulas.form_script(file)
  puts("Processing #{file}")
  File.write('./test.docbuilder', script)
  result = `#{DOC_BUILDER_PATH} ./test.docbuilder`
  DocumentBuilderRecalculateFormulas.handle_result(file, result)
end
