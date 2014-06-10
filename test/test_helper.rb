require 'simplecov'
require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require 'pry-nav'

SimpleCov.start do
  command_name 'MiniTest::Spec'
  add_filter   '/test/'
end unless ENV["no_simplecov"]

module MiniTest
  class Spec
    class << self
      alias_method :context, :describe
    end
  end
end

class DummyCommand
  def self.dispatch
    :stop
  end
end

Minitest.after_run do
  print [27.chr, '[', '?25h'].join # show cursor
end

require_relative '../lib/vedeu.rb'

require 'mocha/setup'
