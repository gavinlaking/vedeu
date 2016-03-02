# frozen_string_literal: true

if ENV['SIMPLECOV'].to_i == 1 || ENV['CONSOLE_COVERAGE'].to_i == 1
  require 'simplecov'
  require 'simplecov-console' if ENV['CONSOLE_COVERAGE'].to_i == 1

  SimpleCov.start do
    formatter SimpleCov::Formatter::Console if ENV['CONSOLE_COVERAGE'].to_i == 1
    command_name 'MiniTest::Spec'
    add_filter '/test/'
    add_group  'application',   'vedeu/application'
    add_group  'borders',       'vedeu/borders'
    add_group  'buffers',       'vedeu/buffers'
    add_group  'cells',         'vedeu/cells'
    add_group  'coercers',      'vedeu/coercers'
    add_group  'colours',       'vedeu/colours'
    add_group  'configuration', 'vedeu/configuration'
    add_group  'cursors',       'vedeu/cursors'
    add_group  'distributed',   'vedeu/distributed'
    add_group  'dsl',           'vedeu/dsl'
    add_group  'editor',        'vedeu/editor'
    add_group  'esc',           'vedeu/esc'
    add_group  'events',        'vedeu/events'
    add_group  'geometries',    'vedeu/geometries'
    add_group  'groups',        'vedeu/groups'
    add_group  'input',         'vedeu/input'
    add_group  'interfaces',    'vedeu/interfaces'
    add_group  'logging',       'vedeu/logging'
    add_group  'menus',         'vedeu/menus'
    add_group  'models',        'vedeu/models'
    add_group  'null',          'vedeu/null'
    add_group  'output',        'vedeu/output'
    add_group  'plugins',       'vedeu/plugins'
    add_group  'presentation',  'vedeu/presentation'
    add_group  'renderers',     'vedeu/renderers'
    add_group  'repositories',  'vedeu/repositories'
    add_group  'runtime',       'vedeu/runtime'
    add_group  'support',       'vedeu/support'
    add_group  'templating',    'vedeu/templating'
    add_group  'terminal',      'vedeu/terminal'
    add_group  'views',         'vedeu/views'
  end
end

require 'pry'
require 'minitest/autorun'
require 'minitest/pride'
require 'minitest/hell'

# Appears to remove ~20ms from test run speed.
if ENV['DISABLE_GC'].to_i == 1
  GC.disable
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

      alias context describe

    end # Eigenclass

  end # Spec

end # MiniTest

require 'mocha/setup'
require 'vedeu'

if ENV['PERFORMANCE'].to_i == 1
  require 'minitest/reporters'
  require 'minitest/reporters/mean_time_reporter'

  Minitest::Reporters.use!(
    Minitest::Reporters::MeanTimeReporter.new({
      show_count: 20,
      previous_runs_filename: "/tmp/durations",
      report_filename:        "/tmp/durations_results"
    })
  )
end

def test_configuration
  Vedeu.config.reset!

  Vedeu.ready!

  Vedeu.configure do
    colour_mode 16_777_216

    # debug! # adds ~40ms to test run speed

    # log '/tmp/vedeu_test_helper.log'
    log false

    # profile!
  end

  # Vedeu::Repositories.reset!
end

test_configuration
