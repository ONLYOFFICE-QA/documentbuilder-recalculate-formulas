# frozen_string_literal: true

task default: [:run]

desc 'Main task for running recalculate result'
task :run do
  sh('ruby calculate.rb 2>&1 | tee result.log')
  report_version = `head -n 1 result.log`.chomp
  sh("mv result.log #{report_version}.log")
end
