require 'bundler/gem_tasks'
require 'rake/testtask'
require 'cucumber'
require 'cucumber/rake/task'

Cucumber::Rake::Task.new(:cucumber) do |t|
  t.cucumber_opts = "features --format progress"
end

Rake::TestTask.new do |t|
  t.libs.push 'lib'
  t.libs.push 'test'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = false
end

task :default => :test

Rake::Task['cucumber'].execute
