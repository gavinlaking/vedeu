module Vedeu
  class Events
    def initialize(&block)
      @handlers = Hash.new { |h, k| h[k] = [] }

      log("Events#initialize " \
          "self: #{self.object_id}")

      self.instance_eval(&block) if block_given?

      self
    end

    def add(object, &block)
      log("Events#add " \
          "self: #{self.object_id}" \
          "menu: #{object.object_id}")

      @self_before_instance_eval = eval "self", block.binding

      self.instance_eval(&block)
    end

    def on(event, &block)
      log("Events#on " \
          "self:  #{self.object_id} " \
          "block: #{block.object_id} " \
          "event: #{event.inspect}")
      handlers[event] << block
    end

    def trigger(event, *args)
      handlers[event].each do |handler|
        log("Events#trigger " \
            "self:    #{self.object_id} " \
            "handler: #{handler.object_id} " \
            "event:   #{event.inspect}")
        handler.call(*args)
      end
    end

    def method_missing(method, *args, &block)
      @self_before_instance_eval.send method, *args, &block
    end

    private

    attr_reader :handlers

    def log(message)
      Vedeu.trigger(:_log_, message) if debug?
    end

    def debug?
      false
    end
  end
end
