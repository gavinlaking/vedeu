require 'simplecov'
require 'minitest/autorun'
require 'minitest/pride'

SimpleCov.start do
  command_name 'MiniTest::Spec'
  add_filter   '/test/'
end

module MiniTest
  class Spec
    class << self
      alias_method :context, :describe
    end
  end
end

require_relative '../lib/vedeu.rb'

require 'mocha/setup'
