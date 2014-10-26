module Vedeu

  # Repository for storing and retrieving defined interfaces.
  #
  # @api private
  module Interfaces

    include Repository
    extend self

    # Stores the interface attributes defined by the API.
    #
    # @param attributes [Hash]
    # @return [Hash|FalseClass]
    def add(attributes)
      validate_attributes!(attributes)

      Vedeu.log("Registering interface: '#{attributes[:name]}'")

      storage.store(attributes[:name], attributes)

      register_event(attributes)

      true
    end

    # Create an instance of Interface from the stored attributes.
    #
    # @param name [String]
    # @return [Interface]
    def build(name)
      Interface.new(find(name))
    end

    # Reset the interfaces repository; removing all registered interfaces.
    # This will delete the interfaces themselves, and the client application
    # will need to either redefine interfaces before using them, or restart.
    #
    # Note: It also resets repositories which depend on interfaces being
    # registered.
    #
    # @return [Hash]
    def reset
      @_storage = in_memory

      Vedeu::Buffers.reset
      Vedeu::Cursors.reset
      Vedeu::Focus.reset
      Vedeu::Groups.reset

      @_storage
    end

    private

    # @see Vedeu::Refresh.register_event
    # @param attributes [Hash]
    # @return [Boolean]
    def register_event(attributes)
      name  = attributes[:name]
      delay = attributes[:delay] || 0.0

      Vedeu::Refresh.register_event(:by_name, name, delay)
    end

    # @return [Hash]
    def in_memory
      {}
    end

    # @param name [String]
    # @raise [InterfaceNotFound] When the entity cannot be found with this name.
    # @return [InterfaceNotFound]
    def not_found(name)
      fail InterfaceNotFound,
        "Interface was not found with this name: #{name}."
    end

  end # Interfaces

end # Vedeu
