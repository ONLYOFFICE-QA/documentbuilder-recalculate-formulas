# frozen_string_literal: true

require_relative 'lib/document_builder_recalculate_formulas'

DOC_BUILDER_PATH = 'documentbuilder'
FILES_PATH = "#{ENV['HOME']}/RubymineProjects/OnlineDocuments/data/data_files/spreadsheet_formulas"

files = Dir["#{FILES_PATH}/*"].sort

files.each do |file|
  script_content = "builder.OpenFile(\"#{file}\");\n"
  script_content += "Api.RecalculateAllFormulas(function(obj){\n"
  script_content += "console.log('error: [' + obj.oldValue + ', ' + obj.newValue + '] in ' + obj.sheet + ',' + obj.r + ',' + obj.c);\n"
  script_content += "});\n"
  script_content += 'builder.CloseFile();'

  puts("Processing #{file}")
  File.write('./test.docbuilder', script_content)
  result = `#{DOC_BUILDER_PATH} ./test.docbuilder`
  DocumentBuilderRecalculateFormulas.handle_result(file, result)
end
