require 'simplecov'
require 'pry'
require 'minitest/autorun'
require 'minitest/pride'
require 'minitest/hell'

SimpleCov.start do
  command_name 'MiniTest::Spec'
  add_filter   '/test/'
end unless ENV['no_simplecov']

require 'mocha/setup'

GC.disable

require 'vedeu'

# commented out by default (makes tests slower)
# require 'minitest/reporters'
# Minitest::Reporters.use!(
  # Minitest::Reporters::DefaultReporter.new({ color: true, slow_count: 5 }),
  # Minitest::Reporters::SpecReporter.new
# )

# trace method execution with (optionally) local variables
# require 'vedeu/api/log'
# Vedeu::Log::Trace.call({ watched: 'call', klass: /^Vedeu/ })
