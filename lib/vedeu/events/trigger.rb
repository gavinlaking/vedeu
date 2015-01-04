module Vedeu

  class Trigger

    class << self

      # Trigger a registered or system event by name with arguments. If the
      # event stored returns a value, that is returned. If multiple events are
      # registered for a name, then the result of each event will be returned as
      # part of a collection.
      #
      # @param name [Symbol] The name of the event you wish to trigger. The event
      #   does not have to exist.
      # @param args [Array] Any arguments the event needs to execute correctly.
      #
      # @example
      #   Vedeu.trigger(:my_event, :oxidize, 'nitrogen')
      #
      # @return [Array]
      def trigger(name, *args)
        new(name, *args).trigger
      end

    end

    # @see Vedeu::Trigger.trigger
    # @return [Trigger]
    def initialize(name, *args)
      @name = name
      @args = args
    end

    # @see Vedeu::Trigger.trigger
    # @return [Array]
    def trigger
      if repository.registered?(name)
        collection = repository.find(name)
        results    = collection.map { |event| event.trigger(*args) }

        return results.first if results.one?

        results
      end

      []
    end

    private

    attr_reader :name, :args

    def repository
      Vedeu.events_repository
    end

  end # Trigger

end # Vedeu
