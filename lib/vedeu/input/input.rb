require_relative '../support/queue'
require_relative '../support/terminal'

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
