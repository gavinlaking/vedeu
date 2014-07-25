module Vedeu
  class Events
    def initialize(&block)
      @handlers = Hash.new { |h, k| h[k] = [] }

      log("self: #{self.object_id}")

      self.instance_eval(&block) if block_given?

      self
    end

    def add(object, &block)
      log("self: #{self.object_id}")
      log("object: #{object.object_id}")

      @self_before_instance_eval = eval 'self', block.binding

      self.instance_eval(&block)
    end

    def on(event, &block)
      log("self: #{self.object_id}")
      log("block: #{block.object_id}")
      log("storing: #{event.inspect}")

      handlers[event] << block
    end

    def trigger(event, *args)
      handlers[event].each do |handler|
        log("self: #{self.object_id}")
        log("handler: #{handler.object_id}")
        log("running: #{event.inspect}")

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

    def log(message)
      Vedeu.log(sprintf("%42s%s", '', message)) if Vedeu.debug?
    end
  end
end
