require_relative '../repository/command_repository'
require_relative '../support/queue'
require_relative '../support/parser'

module Vedeu
  class Process
    class << self
      def evaluate
        new.evaluate
      end
    end

    def initialize; end

    def evaluate
      fail StopIteration if no_result?

      json = Parser.parse(result)

      Composition.enqueue(json)
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
