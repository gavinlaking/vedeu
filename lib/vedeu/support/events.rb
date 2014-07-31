module Vedeu
  class Events
    def initialize(&block)
      @handlers = Hash.new { |h, k| h[k] = [] }
      self.instance_eval(&block) if block_given?
      self
    end

    def add(object, &block)
      @self_before_instance_eval = eval 'self', block.binding

      self.instance_eval(&block)
    end

    def on(event, &block)
      handlers[event] << block
    end

    def trigger(event, *args)
      handlers[event].each do |handler|
        handler.call(*args)
      end
    end

    # :nocov:
    def method_missing(method, *args, &block)
      @self_before_instance_eval.send method, *args, &block
    end
    # :nocov:

    private

    attr_reader :handlers
  end
end
