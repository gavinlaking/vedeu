module Vedeu

  module Bindings

    # Each of the Bindings::Menus events require a target menu name as an
    # argument.
    #
    # @api public
    module Menus

      # Makes the last menu item the current menu item.
      Vedeu.bind(:_menu_bottom_) { |name| Vedeu.menus.find(name).bottom_item }

      # Returns the current menu item.
      Vedeu.bind(:_menu_current_) { |name| Vedeu.menus.find(name).current_item }

      # Deselects all menu items.
      Vedeu.bind(:_menu_deselect_) do |name|
        Vedeu.menus.find(name).deselect_item
      end

      # Returns all the menu items with respective `current` or `selected`
      # boolean indicators.
      Vedeu.bind(:_menu_items_) { |name| Vedeu.menus.find(name).items }

      # Makes the next menu item the current menu item, until it reaches the
      # last item.
      Vedeu.bind(:_menu_next_) { |name| Vedeu.menus.find(name).next_item }

      # Makes the previous menu item the current menu item, until it reaches the
      # first item.
      Vedeu.bind(:_menu_prev_) { |name| Vedeu.menus.find(name).prev_item }

      # Returns the selected menu item.
      Vedeu.bind(:_menu_selected_) { |name| Vedeu.menus.find(name).selected_item }

      # Makes the current menu item also the selected menu item.
      Vedeu.bind(:_menu_select_) { |name| Vedeu.menus.find(name).select_item }

      # Makes the first menu item the current menu item.
      Vedeu.bind(:_menu_top_) { |name| Vedeu.menus.find(name).top_item }

      # Returns a subset of the menu items; starting at the current item to the
      # last item.
      Vedeu.bind(:_menu_view_) { |name| Vedeu.menus.find(name).view }

    end # Menus

  end # Bindings

end # Vedeu
