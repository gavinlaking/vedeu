module Vedeu
  class Input
    class << self
      def evaluate
        new.evaluate
      end
    end

    def initialize; end

    def evaluate
      raise Collapse if result == :stop

      Queue.enqueue(result) unless empty?
    end

    private

    def empty?
      result.nil? || result.empty?
    end

    def result
      @result ||= command.execute(*args) if exists?
    end

    def exists?
      command.is_a?(Command)
    end

    def command
      @command ||= CommandRepository.find_by_input(input)
    end

    def input
      Terminal.input
    end

    def args
      []
    end
  end
end
