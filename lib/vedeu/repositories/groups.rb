module Vedeu

  # Repository for storing and retrieving interfaces by their group name.
  module Groups

    extend self

    # Add an interface name to a group, creating the group if it doesn't already
    # exist, and rejecting the interface if it is already known.
    #
    # @param attributes [Hash]
    # @return [Groups|FalseClass]
    def add(attributes)
      return false if attributes[:group].empty?

      storage[attributes[:group]] << attributes[:name]
    end

    # Return the whole repository.
    #
    # @return [Set]
    def all
      storage
    end

    # Find a group by name and return all of its associated interfaces.
    #
    # @param group_name [String]
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
    # @return [TrueClass|FalseClass]
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
