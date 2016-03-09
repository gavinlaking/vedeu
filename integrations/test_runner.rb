# frozen_string_literal: true

# Provides the result of running an integration test.
#
# @api private
class TestRunner

  # @param (see #initialize)
  # @return [void]
  def self.result(testcase, file)
    new(testcase, file).result
  end

  # @param testcase [String]
  # @param file [String]
  # @return [TestRunner]
  def initialize(testcase, file)
    @testcase = testcase
    @file     = file
  end

  # @return [void]
  def result
    print "\e[36m#{file}: "
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

  # @!attribute [r] file
  # @return [String]
  attr_reader :file

  private

  # @return [String]
  def actual
    File.read("/tmp/#{testcase}.out")
  end

  # @return [String]
  def expected
    File.read(File.expand_path("../expected/#{testcase}.out", file))
  end

end # TestRunner
