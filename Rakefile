# frozen_string_literal: true

task default: [:run]

desc 'Main task for running recalculate result'
task :run do
  sh('ruby calculate.rb 2>&1 | tee result.log')
end
