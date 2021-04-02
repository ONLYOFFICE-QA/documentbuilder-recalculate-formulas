# frozen_string_literal: true

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
  puts("Incorrect result in #{file}\n#{result}") if result.include?('error')
end
