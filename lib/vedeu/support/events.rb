module Vedeu
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
      self
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

        handlers[event][:events].each do |handler|
          handler.call(*args)
        end
      end
    end

    # :nocov:
    def method_missing(method, *args, &block)
      @self_before_instance_eval.send method, *args, &block
    end
    # :nocov:

    private

    attr_reader :handlers, :throttles
  end
end
