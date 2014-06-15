require 'simplecov'
require 'minitest/autorun'
require 'minitest/pride'
require 'minitest/reporters'
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

Minitest.after_run do
  print [27.chr, '[', '?25h'].join # show cursor
end

Minitest::Reporters.use!(Minitest::Reporters::SpecReporter.new)

require_relative '../lib/vedeu.rb'

require 'mocha/setup'
