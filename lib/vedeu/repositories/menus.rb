module Vedeu

  # Repository for storing and retrieving defined menus.
  #
  # @api private
  module Menus

    extend self

    # Stores the menu attributes defined by the API.
    #
    # @param attributes [Hash]
    # @return [Hash|FalseClass]
    def add(attributes)
      return false if attributes[:name].empty?

      storage.store(attributes[:name], attributes)
    end

    # Return the whole repository.
    #
    # @return [Hash]
    def all
      storage
    end

    # Find a menu by name.
    #
    # @param name [String]
    # @return [Hash]
    def find(name)
      storage.fetch(name) do
        fail MenuNotFound,
          "Menu was not found with this name: #{name.to_s}."
      end
    end

    # Returns a collection of the names of all the registered menus.
    #
    # @return [Array]
    def registered
      storage.keys
    end

    # Returns a boolean indicating whether the named menu is registered.
    #
    # @return [TrueClass|FalseClass]
    def registered?(name)
      storage.key?(name)
    end

    # Reset the menus repository; removing all registered menus.
    # This will delete the menus themselves, and the client application
    # will need to either redefine menus before using them, or restart.
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
      {}
    end

  end
end
