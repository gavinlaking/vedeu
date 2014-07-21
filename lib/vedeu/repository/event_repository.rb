module Vedeu
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
        :_keypress_     => [ proc { |key| keypress(key) } ],
        :_mode_switch_  => [ proc { fail ModeSwitch } ],
      }
    end

    def keypress(key)
      trigger(:_mode_switch_) if key == :escape

      trigger(:key, key)
    end
  end
end
