module Vedeu
  class Input
    class << self
      def evaluate(input, args = [])
        new(input, args).evaluate
      end
    end

    def initialize(input, args = [])
      @input = input
      @args  = args
    end

    def evaluate
      command.execute(*args) if exists?
    end

    private

    attr_reader :input, :args

    def exists?
      command.is_a?(Command)
    end

    def command
      @command ||= CommandRepository.find_by_input(input)
    end
  end
end
