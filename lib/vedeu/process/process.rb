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
      fail StopIteration if no_result?

      parsed_data = Parser.parse(result)

      Composition.enqueue(parsed_data)
    end

    private

    def no_result?
      result.nil? || result.empty? || result == :stop
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
