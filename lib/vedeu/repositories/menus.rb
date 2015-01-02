module Vedeu

  # Repository for storing and retrieving defined menus.
  #
  # @api private
  module Menus

    include Vedeu::Repository
    extend  self

    # Access a menu by name.
    #
    # @param name [String]
    # @return [Vedeu::Menu]
    def use(name)
      if registered?(name)
        find(name)

      else
        nil

      end
    end

    private

    # @return [Class] The model class for this repository.
    def model
      Vedeu::Menu
    end

    # Returns an empty collection ready for the storing of menus by name with
    # associated menu instance.
    #
    # @return [Hash]
    def in_memory
      {}
    end

  end # Menus

end # Vedeu
