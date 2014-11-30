module Vedeu

  # Repository for storing and retrieving defined menus.
  #
  # @api private
  module Menus

    include Repository
    extend self

    # Stores the menu attributes defined by the API.
    #
    # @param attributes [Hash]
    # @return [Hash|MissingRequired]
    def add(attributes)
      validate_attributes!(attributes)

      Vedeu.log("Registering menu: '#{attributes[:name]}'")

      attributes.merge!({ items: model.new(attributes[:items]) })

      storage.store(attributes[:name], attributes)
    end

    # Access a menu by name.
    #
    # @param name [String]
    # @return [Vedeu::Menu]
    def use(name)
      find(name).fetch(:items)
    end

    private

    # @return [Class] The model class for this repository.
    def model
      Vedeu::Menu
    end
    alias_method :entity, :model

    # Returns an empty collection ready for the storing of menus by name with
    # associated menu instance.
    #
    # @return [Hash]
    def in_memory
      {}
    end

    # @param name [String]
    # @raise [MenuNotFound] When the entity cannot be found with this name.
    # @return [MenuNotFound]
    def not_found(name)
      fail MenuNotFound, "Menu was not found with this name: #{name}."
    end

  end # Menus

end # Vedeu
