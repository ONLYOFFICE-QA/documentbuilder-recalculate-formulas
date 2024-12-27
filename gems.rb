# frozen_string_literal: true

source 'https://rubygems.org'

gem 'rake', '~> 13'

group :development do
  gem 'overcommit', require: false
  gem 'rubocop', require: false
  gem 'rubocop-performance', require: false
  gem 'rubocop-rake', require: false
  gem 'yard', require: false
end
