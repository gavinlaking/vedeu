module Vedeu
  module API
    def on(name, delay = 0, &block)
      Vedeu.events.on(name, delay, &block)
    end
    alias_method :event, :on

    def trigger(name, *args)
      Vedeu.events.trigger(name, *args)
    end

    def events
      @events ||= API::Events.new do
        on(:_exit_)        { fail StopIteration }
        on(:_log_)         { |message| Vedeu.log(message) }
        on(:_mode_switch_) { fail ModeSwitch    }
        on(:_clear_)       { Terminal.output(Esc.string('clear')) }
        on(:_refresh_)     { Buffers.refresh_all }

        on(:_keypress_) do |key|
          trigger(:key, key)
          trigger(:_log_, (' ' * 42) + "key: #{key}")
          trigger(:_mode_switch_) if key == :escape
        end
      end
    end

    class Events
      def initialize(&block)
        @handlers = Hash.new do |hash, key|
          hash[key] = {
            delay:     0,
            events:    [],
            last_exec: 0,
          }
        end
        self.instance_eval(&block) if block_given?
      end

      def add(object, &block)
        @self_before_instance_eval = eval 'self', block.binding

        self.instance_eval(&block)
      end

      def on(event, delay = 0, &block)
        handlers[event][:events] << block
        handlers[event][:delay]  = delay
        handlers[event]
      end

      def trigger(event, *args)
        elapsed = Time.now.to_f - handlers[event][:last_exec]

        if elapsed > handlers[event][:delay]
          handlers[event][:last_exec] = Time.now.to_f

          handlers[event][:events].each { |handler| handler.call(*args) }
        end
      end

      private

      attr_reader :handlers

      def method_missing(method, *args, &block)
        @self_before_instance_eval.send method, *args, &block
      end
    end
  end
end
