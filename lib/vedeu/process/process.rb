require_relative '../repository/command_repository'
require_relative '../support/queue'
require_relative '../support/parser'

module Vedeu
  class Process
    def self.evaluate
      new.evaluate
    end

    def initialize; end

    def evaluate
      return false if no_input?

      fail StopIteration if stop_requested?

      Parser.parse(result) unless no_result?
    end

    private

    def stop_requested?
      result == :stop
    end

    def no_result?
      result.nil? || result.empty?
    end

    def no_input?
      input.nil? || input.empty?
    end

    def result
      @result ||= command.execute(*args) if command
    end

    def command
      @command ||= CommandRepository.by_input(input)
    end

    def input
      @input ||= Queue.dequeue
    end

    def args
      []
    end
  end
end
