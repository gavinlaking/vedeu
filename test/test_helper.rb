unless ENV['NO_SIMPLECOV']
  require 'simplecov'
  require 'simplecov-console' if ENV['CONSOLE_COVERAGE']
end

require 'pry'
require 'minitest/autorun'
require 'minitest/pride' unless ENV['NO_COLOR']
require 'minitest/hell'

# GC.disable # Uncomment to remove ~20ms from test run speed; left uncommented
             # though makes tests slower over time with 'guard'.

unless ENV['NO_SIMPLECOV']
  SimpleCov.start do
    formatter SimpleCov::Formatter::Console if ENV['CONSOLE_COVERAGE']
    command_name 'MiniTest::Spec'
    add_filter '/test/'
    add_group  'application',   'vedeu/application'
    add_group  'bindings',      'vedeu/bindings'
    add_group  'borders',       'vedeu/borders'
    add_group  'buffers',       'vedeu/buffers'
    add_group  'colours',       'vedeu/colours'
    add_group  'configuration', 'vedeu/configuration'
    add_group  'cursors',       'vedeu/cursors'
    add_group  'distributed',   'vedeu/distributed'
    add_group  'dsl',           'vedeu/dsl'
    add_group  'editor',        'vedeu/editor'
    add_group  'esc',           'vedeu/esc'
    add_group  'events',        'vedeu/events'
    add_group  'geometry',      'vedeu/geometry'
    add_group  'input',         'vedeu/input'
    add_group  'log',           'vedeu/logging'
    add_group  'menus',         'vedeu/menus'
    add_group  'models',        'vedeu/models'
    add_group  'null',          'vedeu/null'
    add_group  'output',        'vedeu/output'
    add_group  'plugins',       'vedeu/plugins'
    add_group  'refresh',       'vedeu/refresh'
    add_group  'repositories',  'vedeu/repositories'
    add_group  'runtime',       'vedeu/runtime'
    add_group  'templating',    'vedeu/templating'
    add_group  'terminal',      'vedeu/terminal'
  end
end

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
# require 'support/average_duration_reporter'
# Minitest::Reporters.use!(
    # commented out by default (makes tests slower)
    # Minitest::Reporters::MeanTimeReporter.new({
    #   previous_runs_filename: "/tmp/reports/durations",
    #   report_filename:        "/tmp/reports/durations_results"})
    # Minitest::Reporters::DefaultReporter.new({ color: true,
    #                                            slow_suite_count: 15 }),
    # Minitest::Reporters::SpecReporter.new
# )

def test_configuration
  Vedeu::Configuration.reset!

  Vedeu.ready!

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
