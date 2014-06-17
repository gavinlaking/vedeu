module Vedeu
  class Process
    class << self
      def evaluate
        new.evaluate
      end
    end

    def initialize; end

    def evaluate
      fail Collapse if result == :stop

      Compositor.arrange(result) unless no_result?
    end

    private

    def result
      @result ||= command.execute(*args) if command
    end

    def no_result?
      result.nil? || result.empty?
    end

    def command
      @command ||= find_by_keypress || find_by_keyword
    end

    def find_by_keypress
      CommandRepository.by_keypress(input) if keypress?
    end

    def find_by_keyword
      CommandRepository.by_keyword(input) if keyword?
    end

    def keypress?
      input? && input.size == 1
    end

    def keyword?
      input? && input.size > 1
    end

    def input?
      !!(input)
    end

    def input
      @input ||= Queue.dequeue
    end

    def args
      []
    end
  end
end
