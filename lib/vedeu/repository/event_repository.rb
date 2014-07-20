require_relative '../support/terminal'

module Vedeu
  class Trigger
    def self.event(event, *args)
      EventRepository.trigger(event, *args)
    end
  end

  class Register
    def self.event(event, *args)
      EventRepository.register(event, &block)
    end
  end

  module EventRepository
    extend self

    def handlers
      @handlers ||= Hash.new { |h, k| h[k] = [] }.merge(defaults)
    end

    def register(event, &block)
      handlers[event] << block
    end

    def trigger(event, *args)
      handlers[event].each do |handler|
        handler.call(*args)
      end
    end

    private

    def defaults
      {
        :_exit_         => [ proc { fail StopIteration } ],
        :_mode_switch_  => [ proc { fail ModeSwitch } ]
      }
    end
  end
end
