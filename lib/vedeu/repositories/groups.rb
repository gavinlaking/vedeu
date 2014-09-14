module Vedeu

  # Repository for storing and retrieving interfaces by their group name.
  #
  # @api private
  module Groups

    include Vedeu::Common
    extend self

    # Add an interface name to a group, creating the group if it doesn't already
    # exist, and rejecting the interface if it is already known.
    #
    # @param attributes [Hash]
    # @return [Groups|FalseClass]
    def add(attributes)
      return false unless defined_value?(attributes[:group])

      storage[attributes[:group]] << attributes[:name]

      register_event(attributes)

      true
    end

    # Return the whole repository.
    #
    # @return [Set]
    def all
      storage
    end

    # Find a group by name and return all of its associated interfaces.
    #
    # @param name [String]
    # @return [Set]
    def find(name)
      storage.fetch(name) do
        fail GroupNotFound,
          "Cannot find interface group with this name: #{name.to_s}."
      end
    end

    # Returns a collection of the names of all registered groups.
    #
    # @return [Array]
    def registered
      storage.keys
    end

    # Returns a Boolean indicating whether the named group is registered.
    #
    # @return [Boolean]
    def registered?(name)
      storage.key?(name)
    end

    # Reset the groups repository; removing all groups. This does not delete
    # the interfaces themselves.
    #
    # @return [Hash]
    def reset
      @_storage = in_memory
    end

    private

    # @see Vedeu::Refresh.register_event
    # @api private
    # @param attributes [Hash]
    # @return [Boolean]
    def register_event(attributes)
      name       = attributes[:group]
      delay      = attributes[:delay] || 0.0

      Vedeu::Refresh.register_event(:by_group, name, delay)
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
      Hash.new { |hash, key| hash[key] = Set.new }
    end

  end
end
