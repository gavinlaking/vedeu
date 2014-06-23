require 'simplecov'
require 'minitest/autorun'
require 'minitest/pride'
require 'pry'

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

Minitest.after_run do
  print [27.chr, '[', '?25h'].join # show cursor
end

# commented out by default (makes tests slower)
# require 'minitest/reporters'
# Minitest::Reporters.use!(
  # Minitest::Reporters::DefaultReporter.new({ color: true, slow_count: 5 }),
  # Minitest::Reporters::SpecReporter.new
# )

require_relative '../lib/vedeu.rb'

require 'mocha/setup'
