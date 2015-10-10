require 'bundler/gem_tasks'
require 'rake/testtask'
require 'yard'
require 'rubocop/rake_task'

Rake::TestTask.new(:test) do |task|
  task.libs.push 'lib'
  task.libs.push 'test'
  task.pattern = 'test/**/*_test.rb'
  task.verbose = false
  task.warning = true if ENV['WARNINGS']
end

YARD::Rake::YardocTask.new(:yard) do |task|
  task.files = [
    'lib/**/*.rb',
    '-',
    'docs/api.md',
    'docs/border.md',
    'docs/buffer.md',
    'docs/configuration.md',
    'docs/cursor.md',
    'docs/dsl.md',
    'docs/events.md',
    'docs/geometry.md',
    'docs/getting_started.md',
    'docs/group.md',
    'docs/interfaces.md',
    'docs/keymaps.md',
    'docs/object_graph.md',
    'docs/view.md',
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
  task.options = ['highlight']
  task.stats_options = ['--list-undoc']
end

RuboCop::RakeTask.new(:rubocop) do |task|
  task.patterns = ['lib/**/*.rb']
  task.formatters = ['simple']
  task.fail_on_error = false
end

tasks_to_run = [:test]
tasks_to_run << :rubocop if ENV['RUBOCOP']
tasks_to_run << :yard if ENV['YARD']

task default: tasks_to_run
