require "bundler/gem_tasks"
require "rake/testtask"

Rake::TestTask.new(:minitest) do |t|
  t.libs << 'lib/vedeu'
  t.test_files = FileList["test/lib/vedeu/*_test.rb",
                          "test/lib/vedeu/**/*_test.rb"]
  # t.options = '-v' # verbose mode
end

task default: :minitest
