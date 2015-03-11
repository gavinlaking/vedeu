require 'simplecov'
require 'simplecov-console'
require 'pry'
require 'minitest/autorun'
require 'minitest/pride' unless ENV['NO_COLOR']
require 'minitest/hell'

# GC.disable # uncomment to remove ~20ms from test run speed

SimpleCov.start do
  formatter    SimpleCov::Formatter::Console
  command_name 'MiniTest::Spec'
  add_filter '/test/'
  add_group  'api',           'vedeu/api'
  add_group  'buffers',       'vedeu/buffers'
  add_group  'configuration', 'vedeu/configuration'
  add_group  'cursor',        'vedeu/cursor'
  add_group  'dsl',           'vedeu/dsl'
  add_group  'events',        'vedeu/events'
  add_group  'input',         'vedeu/input'
  add_group  'models',        'vedeu/models'
  add_group  'output',        'vedeu/output'
  add_group  'presentation',  'vedeu/presentation'
  add_group  'repositories',  'vedeu/repositories'
  add_group  'support',       'vedeu/support'
end unless ENV['no_simplecov']

module MiniTest
  class Spec
    # parallelize_me! # uncomment to unleash hell

    class << self
      alias_method :context, :describe
    end
  end
end

require 'mocha/setup'
require 'vedeu'
require 'support/helpers/all'

def test_configuration
  Vedeu::Configuration.reset!

  Vedeu.configure do
    colour_mode 16777216
     # adds ~40ms to test run speed
     # debug!

     # if debug! above is commented out, then only
     # `Vedeu.log(type: <any type>, message: '...', force: true)`
     # will be logged, otherwise every `Vedeu.log` will be logged.
     log '/tmp/vedeu_test_helper.log'
  end
end

test_configuration

# require 'minitest/reporters'
# Minitest::Reporters.use!(
#   # commented out by default (makes tests slower)
#   # Minitest::Reporters::DefaultReporter.new({ color: true, slow_count: 5 }),
#   # Minitest::Reporters::SpecReporter.new
# )

# trace method execution with (optionally) local variables
# require 'vedeu/support/log'
# Vedeu::Trace.call({ watched: 'call', klass: /^Vedeu/ })
