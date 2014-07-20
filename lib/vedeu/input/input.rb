require_relative '../support/queue'
require_relative '../support/terminal'

module Vedeu
  module Input
    extend self

    def capture
      key = input

      EventRepository.trigger(:_mode_switch_) if is_escape?(key)

      Queue.enqueue(key)
    end

    private

    def is_escape?(key)
      key.ord == 27
    end

    def input
      Terminal.input
    end
  end
end
