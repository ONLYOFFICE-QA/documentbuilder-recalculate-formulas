# frozen_string_literal: true

task default: [:run]

desc 'Main task for running recalculate result'
task :run do
  sh('ruby calculate.rb > result.log 2>&1')
end
