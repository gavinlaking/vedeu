module Vedeu

  # Repository for storing and retrieving defined menus.
  #
  # @api private
  module Menus

    include Repository
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
