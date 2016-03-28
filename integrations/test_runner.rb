# frozen_string_literal: true

# Provides the result of running an integration test.
#
# @api private
class TestRunner

  # @param (see #initialize)
  # @return [void]
  def self.result(testcase, filename)
    new(testcase, filename).result
  end

  # @param testcase [String]
  # @param filename [String]
  # @return [TestRunner]
  def initialize(testcase, filename)
    @testcase = testcase
    @filename = filename
  end

  # @return [void]
  def result
    print "\e[36m#{filename}: "

    if expected == actual
      print "\e[32mPassed.\e[39m\n"
      exit 0;

    else
      print "\e[31mFailed.\e[39m\n"
      puts "\e[33mExpected:\e[39m"
      puts expected.inspect
      puts "\e[34mActual:\e[39m"
      puts actual.inspect
      exit 1;

    end
  end

  protected

  # @!attribute [r] testcase
  # @return [String]
  attr_reader :testcase

  # @!attribute [r] filename
  # @return [String]
  attr_reader :filename

  private

  # @return [String]
  def actual
    @_actual ||= File.read(actual_path)
  end

  # @return [String]
  def expected
    @_expected ||= File.read(File.expand_path(expected_path, filename))
  end

  # @return [String]
  def actual_path
    Dir.tmpdir + "/#{testcase}.out"
  end

  # @return [String]
  def expected_path
    "../expected/#{testcase}.out"
  end

end # TestRunner
