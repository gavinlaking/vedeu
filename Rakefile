require 'bundler/gem_tasks'
require 'rake/testtask'
require 'yard'
require 'rubocop/rake_task'

Rake::TestTask.new(:test) do |task|
  task.libs.push 'lib'
  task.libs.push 'test'
  task.pattern = 'test/**/*_test.rb'
  task.verbose = false
  task.warning = true # set to true for Ruby warnings (ruby -w)
end

YARD::Rake::YardocTask.new(:yard) do |task|
  task.files = [
    'lib/**/*.rb',
    '-',
    'docs/api.md',
    'docs/dsl.md',
    'docs/events.md',
    'docs/getting_started.md',
    'docs/object_graph.md',
  ]
end

RuboCop::RakeTask.new(:rubocop) do |task|
  task.patterns = ['lib/**/*.rb']
  task.formatters = ['progress']
  task.fail_on_error = false
end

task default: :test
