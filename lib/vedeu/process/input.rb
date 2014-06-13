module Vedeu
  class Input
    class << self
      def capture
        new.capture
      end
    end

    def initialize; end

    def capture
      Queue.enqueue(input)
    end

    private

    def input
      Terminal.input
    end
  end
end
