require 'simplecov'
require 'simplecov-console' if ENV['CONSOLE_COVERAGE']
require 'pry'
require 'minitest/autorun'
require 'minitest/pride' unless ENV['NO_COLOR']
require 'minitest/hell'

# Notes: (2015-07-20)
#
# On my MacBookPro 6,2 (Mid-2010), the test speed is around 0.9s to 1.1s.
# On my Raspberry Pi 2 (Early 2015), the test speed is around 6.5s to 7.0s.

# GC.disable # Uncomment to remove ~20ms from test run speed; left uncommented
             # though makes tests slower over time with 'guard'.

SimpleCov.start do
  formatter SimpleCov::Formatter::Console if ENV['CONSOLE_COVERAGE']
  command_name 'MiniTest::Spec'
  add_filter '/test/'
  add_group  'application',   'vedeu/application'
  add_group  'bindings',      'vedeu/bindings'
  add_group  'buffers',       'vedeu/buffers'
  add_group  'cli',           'vedeu/cli'
  add_group  'configuration', 'vedeu/configuration'
  add_group  'cursor',        'vedeu/cursor'
  add_group  'distributed',   'vedeu/distributed'
  add_group  'dsl',           'vedeu/dsl'
  add_group  'events',        'vedeu/events'
  add_group  'geometry',      'vedeu/geometry'
  add_group  'input',         'vedeu/input'
  add_group  'models',        'vedeu/models'
  add_group  'null',          'vedeu/null'
  add_group  'output',        'vedeu/output'
  add_group  'repositories',  'vedeu/repositories'
  add_group  'storage',       'vedeu/storage'
  add_group  'support',       'vedeu/support'
  add_group  'templating',    'vedeu/templating'
end unless ENV['NO_SIMPLECOV']

module VedeuMiniTestPlugin
  # def before_setup
  #   # Vedeu::Repositories.reset!
  #   # Vedeu.log(type: :debug, message: "#{self.class}")
  #
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
end # VedeuMiniTestPlugin

module MiniTest

  class Spec

    # parallelize_me! # uncomment to unleash hell
    # i_suck_and_my_tests_are_order_dependent! # just incase

    include VedeuMiniTestPlugin

    class << self

      alias_method :context, :describe

    end # Eigenclass

  end # Spec

end # MiniTest

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
