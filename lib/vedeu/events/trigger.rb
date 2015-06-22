module Vedeu

  # Trigger a registered or system event by name with arguments. If the
  # event stored returns a value, that is returned. If multiple events are
  # registered for a name, then the result of each event will be returned as
  # part of a collection.
  #
  # @example
  #   Vedeu.trigger(:my_event, :oxidize, 'nitrogen')
  #
  # @api public
  class Trigger

    # @param name [Symbol] The name of the event you wish to trigger. The event
    #   does not have to exist.
    # @param args [Array] Any arguments the event needs to execute correctly.
    # @return [Array]
    def self.trigger(name, *args)
      new(name, *args).trigger
    end

    # Returns a new instance of Vedeu::Trigger.
    #
    # @param (see .trigger)
    # @return [Vedeu::Trigger]
    def initialize(name, *args)
      @name = name
      @args = args
      @repository = Vedeu.events
    end

    # Trigger the event and return the result (if one) or an array of results.
    #
    # @return [Array]
    def trigger
      if results.one?
        results.first

      else
        results

      end
    end

    protected

    # @!attribute [r] name
    # @return [Symbol]
    attr_reader :name

    # @!attribute [r] args
    # @return [Array]
    attr_reader :args

    # @!attribute [r]
    # @return [Vedeu::Repository]
    attr_reader :repository

    private

    # @return [Array<void>|void]
    def results
      @results ||= registered_events.map { |event| event.trigger(*args) }
    end

    # Return all of the registered events for this name.
    #
    # @return [Array|Array<Vedeu::Event>]
    def registered_events
      return [] unless repository.registered?(name)

      repository.find(name)
    end

  end # Trigger

end # Vedeu
