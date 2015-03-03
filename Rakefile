require 'bundler/gem_tasks'
require 'rake/testtask'
require 'cucumber'
require 'cucumber/rake/task'
require 'inch/rake'
require 'yard'

Cucumber::Rake::Task.new(:cucumber) do |t|
  t.cucumber_opts = "features --format progress"
end

Rake::TestTask.new(:test) do |t|
  t.libs.push 'lib'
  t.libs.push 'test'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = false
end

YARD::Rake::YardocTask.new(:yard) do |t|
  t.files = [
    'lib/**/*.rb',
    '-',
    'docs/api.md',
    'docs/getting_started.md',
    'docs/views.md'
  ]
end

Inch::Rake::Suggest.new(:inch) do |suggest|
  suggest.args << "--pedantic"
  suggest.args << "--all"
end

task :default => :test
