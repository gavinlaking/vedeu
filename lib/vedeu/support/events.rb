module Vedeu
  class Events
    def initialize(&block)
      @handlers = Hash.new { |h, k| h[k] = [] }

      Vedeu.log((' ' * 42) + "self: #{self.object_id}")

      self.instance_eval(&block) if block_given?

      self
    end

    def add(object, &block)
      Vedeu.log((' ' * 42) + "self: #{self.object_id}")
      Vedeu.log((' ' * 42) + "menu: #{object.object_id}")

      @self_before_instance_eval = eval "self", block.binding

      self.instance_eval(&block)
    end

    def on(event, &block)
      Vedeu.log((' ' * 42) + "self: #{self.object_id}")
      Vedeu.log((' ' * 42) + "block: #{block.object_id}")
      Vedeu.log((' ' * 42) + "event: #{event.inspect}")

      handlers[event] << block
    end

    def trigger(event, *args)
      handlers[event].each do |handler|
        Vedeu.log((' ' * 42) + "self: #{self.object_id}")
        Vedeu.log((' ' * 42) + "handler: #{handler.object_id}")
        Vedeu.log((' ' * 42) + "event: #{event.inspect}")

        handler.call(*args)
      end
    end

    def method_missing(method, *args, &block)
      @self_before_instance_eval.send method, *args, &block
    end

    private

    attr_reader :handlers
  end
end
