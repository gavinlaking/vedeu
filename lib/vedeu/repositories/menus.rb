module Vedeu

  # Repository for storing and retrieving defined menus.
  #
  # @api private
  module Menus

    include Common
    extend self

    # System events which when called with the appropriate menu name will
    # update the menu accordingly.
    Vedeu.event(:_menu_current_)  { |name| Menus.use(name).current_item  }
    Vedeu.event(:_menu_selected_) { |name| Menus.use(name).selected_item }
    Vedeu.event(:_menu_next_)     { |name| Menus.use(name).next_item     }
    Vedeu.event(:_menu_prev_)     { |name| Menus.use(name).prev_item     }
    Vedeu.event(:_menu_top_)      { |name| Menus.use(name).top_item      }
    Vedeu.event(:_menu_bottom_)   { |name| Menus.use(name).bottom_item   }
    Vedeu.event(:_menu_select_)   { |name| Menus.use(name).select_item   }
    Vedeu.event(:_menu_deselect_) { |name| Menus.use(name).deselect_item }
    Vedeu.event(:_menu_items_)    { |name| Menus.use(name).items         }
    Vedeu.event(:_menu_view_)     { |name| Menus.use(name).view          }

    # Stores the menu attributes defined by the API.
    #
    # @param attributes [Hash]
    # @return [Hash|FalseClass]
    def add(attributes)
      return false unless defined_value?(attributes[:name])

      Vedeu.log("Registering menu: '#{attributes[:name]}'")

      attributes.merge!({ items: Vedeu::Menu.new(attributes[:items]) })

      storage.store(attributes[:name], attributes)
    end

    # Return the whole repository of menus.
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
    # @param name [String]
    # @return [Boolean]
    def registered?(name)
      storage.key?(name)
    end

    # Removes the menu from the repository and associated events.
    #
    # @param name [String]
    # @return [Boolean]
    def remove(name)
      return false unless registered?(name)

      storage.delete(name) { false }

      true
    end

    # Reset the menus repository; removing all registered menus.
    # This will delete the menus themselves, and the client application
    # will need to either redefine menus before using them, or restart.
    #
    # @return [Hash]
    def reset
      @_storage = in_memory
    end

    # Access a menu by name.
    #
    # @param name [String]
    # @return [Vedeu::Menu]
    def use(name)
      find(name).fetch(:items)
    end

    private

    # Access to the storage for this repository.
    #
    # @api private
    # @return [Hash]
    def storage
      @_storage ||= in_memory
    end

    # Returns an empty collection ready for the storing of menus by name with
    # associated menu instance.
    #
    # @api private
    # @return [Hash]
    def in_memory
      {}
    end

  end # Menus

end # Vedeu
