require 'simplecov'
require 'simplecov-console'
require 'pry'
require 'minitest/autorun'
require 'minitest/pride' unless ENV['NO_COLOR']
require 'minitest/hell'

# GC.disable # uncomment to remove ~20ms from test run speed

SimpleCov.start do
  formatter SimpleCov::Formatter::Console
  command_name 'MiniTest::Spec'
  add_filter '/test/'
  add_group  'buffers',       'vedeu/buffers'
  add_group  'configuration', 'vedeu/configuration'
  add_group  'cursor',        'vedeu/cursor'
  add_group  'distributed',   'vedeu/distributed'
  add_group  'dsl',           'vedeu/dsl'
  add_group  'events',        'vedeu/events'
  add_group  'geometry',      'vedeu/geometry'
  add_group  'input',         'vedeu/input'
  add_group  'models',        'vedeu/models'
  add_group  'output',        'vedeu/output'
  add_group  'repositories',  'vedeu/repositories'
  add_group  'storage',       'vedeu/storage'
  add_group  'support',       'vedeu/support'
end unless ENV['no_simplecov']

module VedeuMiniTestPlugin
  # def before_setup
  #   Vedeu::Repositories.reset!
  #   super
  # end

  # def after_setup
  #   super
  # end

  # def before_teardown
  #   super
  # end

  # def after_teardown
  #   super
  #   Vedeu::Repositories.reset!
  # end
end

module MiniTest
  class Spec
    # parallelize_me! # uncomment to unleash hell
    # i_suck_and_my_tests_are_order_dependent! # just incase

    # include VedeuMiniTestPlugin

    class << self
      alias_method :context, :describe
    end
  end
end

require 'mocha/setup'
require 'vedeu'
require 'support/helpers/model_test_class'

# require 'minitest/reporters'
# Minitest::Reporters.use!(
#  # commented out by default (makes tests slower)
#  # Minitest::Reporters::DefaultReporter.new({ color: true,
#  #                                            slow_suite_count: 3 }),
#  # Minitest::Reporters::SpecReporter.new
# )

def test_configuration
  Vedeu::Configuration.reset!

  Vedeu.configure do
    colour_mode 16_777_216
    # adds ~40ms to test run speed
    # debug!

    # if debug! above is commented out, then only
    # `Vedeu.log(type: <any type>, message: '...', force: true)`
    # will be logged, otherwise every `Vedeu.log` will be logged.
    # log '/tmp/vedeu_test_helper.log'
  end

  Vedeu::Repositories.reset!
end

test_configuration
