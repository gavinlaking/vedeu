require 'bundler/gem_tasks'
require 'rake/testtask'
require 'yard'
require 'rubocop/rake_task'

Rake::TestTask.new(:test) do |task|
  task.libs.push 'lib'
  task.libs.push 'test'
  task.pattern = 'test/**/*_test.rb'
  task.verbose = false
  task.warning = false # set to true for Ruby warnings (ruby -w)
end

YARD::Rake::YardocTask.new(:yard) do |task|
  task.files = [
    'lib/**/*.rb',
    '-',
    'docs/api.md',
    'docs/configuration.md',
    'docs/dsl.md',
    'docs/events.md',
    'docs/getting_started.md',
    'docs/object_graph.md',
    'docs/events/application.md',
    'docs/events/document.md',
    'docs/events/drb.md',
    'docs/events/focus.md',
    'docs/events/menu.md',
    'docs/events/movement.md',
    'docs/events/refresh.md',
    'docs/events/system.md',
    'docs/events/view.md',
    'docs/events/visibility.md',
  ]
  task.options = ['--highlight']
  task.stats_options = ['--list-undoc']
end

RuboCop::RakeTask.new(:rubocop) do |task|
  task.patterns = ['lib/**/*.rb']
  task.formatters = ['progress']
  task.fail_on_error = false
end

task default: :test
