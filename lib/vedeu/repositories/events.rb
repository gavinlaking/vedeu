module Vedeu

  # Provides a mechanism for storing and retrieving events by name. A single
  # name can contain many events. Also an event can trigger other events.
  #
  # @api private
  class Events

    # Initializes a new Events class.
    #
    # @param block [Proc]
    # @return [Events]
    def initialize(&block)
      @handlers = Hash.new { |hash, key| hash[key] = { events: [] } }

      instance_eval(&block) if block_given?
    end

    # @param object []
    # @param block [Proc]
    # @return []
    def add(object, &block)
      @self_before_instance_eval = eval('self', block.binding)

      instance_eval(&block)
    end

    # @see Vedeu::API#event
    def event(name, opts = {}, &block)
      handlers[name][:events] << Event.new(block, opts)
      handlers[name]
    end

    # @see Vedeu::API#unevent
    def unevent(name)
      handlers.delete_if { |k, v| k == name }
    end

    # Returns a collection of the names of all the registered events.
    #
    # @return [Array]
    def registered
      handlers.keys
    end

    # Returns a Boolean indicating whether the named event is registered.
    #
    # @return [TrueClass|FalseClass]
    def registered?(name)
      handlers.key?(name)
    end

    # @see Vedeu::API#trigger
    def trigger(name, *args)
      results = handlers[name][:events].map { |event| event.trigger(*args) }

      if results.one?
        results.first

      else
        results

      end
    end

    # Remove all registered events. Used for testing purposes.
    #
    # @return [Hash]
    def reset
      @handlers = Hash.new { |hash, key| hash[key] = { events: [] } }
    end

    private

    # @return [Hash]
    attr_reader :handlers

    # @api private
    # @return []
    def method_missing(method, *args, &block)
      @self_before_instance_eval.send(method, *args, &block)
    end

  end
end
