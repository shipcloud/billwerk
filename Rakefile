# frozen_string_literal: true

require "bundler/gem_tasks"
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.pattern = FileList["spec/**/*_spec.rb"]
end

desc "start an irb console with pactas_itero required"
task :console do
  require "irb"
  require "irb/completion"
  require "pactas_itero"
  ARGV.clear
  IRB.start
end

task default: :spec
