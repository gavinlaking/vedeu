module Vedeu

  # Repository for storing and retrieving defined interfaces.
  #
  # @api private
  module Interfaces

    include Repository
    extend self

    # # Stores the interface attributes defined by the API.
    # #
    # # @param attributes [Hash]
    # # @return [Hash|FalseClass]
    # def add(attributes)
    #   Vedeu.log("Registering interface: '#{attributes[:name]}'")

    #   storage.store(attributes[:name], attributes)

    #   register_event(attributes)

    #   true
    # end

    # Create an instance of Interface from the stored attributes.
    #
    # @param name [String]
    # @return [Interface]
    # def build(name)
    #   model.new(find(name))
    # end

    # Return the Interface currently in focus.
    #
    # @return [Interface]
    def current
      find(Focus.current)
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
      super

      Vedeu::Buffers.reset
      Vedeu::Cursors.reset
      Vedeu::Focus.reset
      Vedeu::Groups.reset

      @_storage
    end

    # @see Vedeu::Repository#store
    def store(model)
      super

      Vedeu::Refresh.register_event(:by_name, model.name, model.delay)

      if model.group
        Vedeu::Refresh.register_event(:by_group, model.group, model.delay)
      end

      model
    end

    private

    # @return [Class] The model class for this repository.
    def model
      Vedeu::Interface
    end

    # @return [Hash]
    def in_memory
      {}
    end

  end # Interfaces

end # Vedeu
