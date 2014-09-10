module Vedeu

  # Repository for storing and retrieving defined interfaces.
  #
  # @api private
  module Interfaces

    include Vedeu::Common
    extend self

    # Stores the interface attributes defined by the API.
    #
    # @param attributes [Hash]
    # @return [Hash|FalseClass]
    def add(attributes)
      return false unless defined_value?(attributes[:name])

      storage.store(attributes[:name], attributes)

      register_event(attributes)

      true
    end

    # Return the whole repository.
    #
    # @return [Hash]
    def all
      storage
    end

    # Find an interface by name and return the attributes used to define it.
    #
    # @param name [String]
    # @return [Hash]
    def find(name)
      storage.fetch(name) do
        fail InterfaceNotFound,
          "Interface was not found with this name: #{name.to_s}."
      end
    end

    # Returns a collection of the names of all the registered interfaces.
    #
    # @return [Array]
    def registered
      storage.keys
    end

    # Returns a boolean indicating whether the named interface is registered.
    #
    # @return [TrueClass|FalseClass]
    def registered?(name)
      storage.key?(name)
    end

    # Reset the interfaces repository; removing all registered interfaces.
    # This will delete the interfaces themselves, and the client application
    # will need to either redefine interfaces before using them, or restart.
    #
    # @return [Hash]
    def reset
      @_storage = in_memory
    end

    private

    # Register a refresh event for an interface by name. When the event is
    # called, the interface with this name will be refreshed.
    #
    # @api private
    # @param attributes [Hash]
    # @return []
    def register_event(attributes)
      name       = attributes[:name]
      delay      = attributes[:delay] || 0.0
      event_name = "_refresh_#{name}_".to_sym

      return false if Vedeu.events.registered?(name)

      Vedeu.event(event_name, { delay: delay }) do
        Vedeu::Refresh.by_name(name)
      end

      true
    end

    # Access to the storage for this repository.
    #
    # @api private
    # @return [Hash]
    def storage
      @_storage ||= in_memory
    end

    # @api private
    # @return [Hash]
    def in_memory
      {}
    end

  end
end
