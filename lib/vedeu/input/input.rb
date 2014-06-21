module Vedeu
  module Input
    extend self

    def capture
      Queue.enqueue(input)
    end

    private

    def input
      Terminal.input
    end
  end
end
