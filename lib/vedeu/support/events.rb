module Vedeu
  class Events

    # @param []
    # @return []
    def initialize(&block)
      @handlers = Hash.new do |hash, key|
        hash[key] = {
          delay:     0,
          debounce:  0,
          events:    [],
          last_exec: 0,
          deadline:  0,
        }
      end
      instance_eval(&block) if block_given?
    end

    # @param []
    # @param []
    # @return []
    def add(object, &block)
      @self_before_instance_eval = eval('self', block.binding)

      instance_eval(&block)
    end

    # @see Vedeu::API#event
    def event(event, opts = {}, &block)
      options = { delay: 0, debounce: 0 }.merge!(opts)

      handlers[event][:delay]    = options.fetch(:delay, 0)
      handlers[event][:debounce] = options.fetch(:debounce, 0)

      handlers[event][:events] << block
      handlers[event]
    end

    # @see Vedeu::API#trigger
    def trigger(event, *args)
      if handlers[event][:debounce] > 0
        if deadline?(event)
          if mark_executed(event) > handlers[event][:deadline]
            clear_deadline(event)
            trigger_event(event, *args)
          else
            mark_executed(event)
          end
        else
          mark_executed(event)
          set_deadline(event)
        end
      else
        if elapsed(event) > handlers[event][:delay]
          mark_executed(event)

          trigger_event(event, *args)
        end
      end
    end

    private

    attr_reader :handlers

    def trigger_event(event, *args)
      handlers[event][:events].each { |handler| handler.call(*args) }
    end

    def clear_deadline(event)
      handlers[event][:deadline] = 0
    end

    def deadline?(event)
      handlers[event][:deadline] > 0
    end

    def set_deadline(event)
      handlers[event][:deadline] = Time.now.to_f + handlers[event][:debounce]
    end

    def elapsed(event)
      Time.now.to_f - handlers[event][:last_exec]
    end

    def mark_executed(event)
      handlers[event][:last_exec] = Time.now.to_f
    end

    def method_missing(method, *args, &block)
      @self_before_instance_eval.send(method, *args, &block)
    end

  end
end
