module Vedeu

  # Repository for storing and retrieving interfaces by their group name.
  #
  # @api private
  module Groups

    include Common
    include Repository
    extend self

    # Add an interface name to a group, creating the group if it doesn't already
    # exist, and rejecting the interface if it is already known.
    #
    # @param attributes [Hash]
    # @return [Boolean]
    def add(attributes)
      validate_attributes!(attributes)

      return false unless defined_value?(attributes[:group])

      storage[attributes[:group]] << attributes[:name]

      register_event(attributes)

      true
    end

    private

    # @see Vedeu::Refresh.register_event
    # @param attributes [Hash]
    # @return [Boolean]
    def register_event(attributes)
      name  = attributes[:group]
      delay = attributes[:delay] || 0.0

      Vedeu::Refresh.register_event(:by_group, name, delay)
    end

    # @return [Hash]
    def in_memory
      Hash.new { |hash, key| hash[key] = Set.new }
    end

    # @param name [String]
    # @raise [GroupNotFound] When the entity cannot be found with this name.
    # @return [GroupNotFound]
    def not_found(name)
      fail GroupNotFound,
        "Cannot find interface group with this name: #{name}."
    end

  end # Groups

end # Vedeu
