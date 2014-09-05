require 'simplecov'
require 'pry'
require 'minitest/autorun'
require 'minitest/pride'
require 'minitest/hell'

SimpleCov.start do
  command_name 'MiniTest::Spec'
  add_filter   '/test/'
end unless ENV['no_simplecov']

module MiniTest
  class Spec
    class << self
      alias_method :context, :describe
    end
  end
end

require 'mocha/setup'

GC.disable

ENV['VEDEU_TERM'] = 'xterm-truecolor'

require 'vedeu'

module Vedeu
  def self.reset_all!
    Vedeu::Buffers.reset
    Vedeu::Configuration.reset
    Vedeu.events.reset
    Vedeu::Focus.reset
    Vedeu::Groups.reset
    Vedeu::Interfaces.reset
  end
end

module MyMiniTestPlugin
  # Code to run before every test case
  def before_setup
    super
    Vedeu.reset_all!
  end

  # Code to run after every test case
  def after_teardown
    Vedeu.reset_all!
    super
  end
end

class MiniTest::Spec
  include MyMiniTestPlugin
end

# commented out by default (makes tests slower)
# require 'minitest/reporters'
# Minitest::Reporters.use!(
  # Minitest::Reporters::DefaultReporter.new({ color: true, slow_count: 5 }),
  # Minitest::Reporters::SpecReporter.new
# )

# trace method execution with (optionally) local variables
# require 'vedeu/support/log'
# Vedeu::Trace.call({ watched: 'call', klass: /^Vedeu/ })
