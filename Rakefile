require 'bundler'
Bundler.setup

require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.rspec_opts = '-c -f n'
end

task default: [:spec]
