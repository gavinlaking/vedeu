module Vedeu

  module Bindings

    # Each of the Bindings::Menus events require a target menu name as an
    # argument.
    #
    # @api public
    # {include:file:docs/events/menus.md}
    # :nocov:
    module Menus

      Vedeu.bind(:_menu_bottom_) { |name| Vedeu.menus.find(name).bottom_item }
      Vedeu.bind(:_menu_current_) { |name| Vedeu.menus.find(name).current_item }

      Vedeu.bind(:_menu_deselect_) do |name|
        Vedeu.menus.find(name).deselect_item
      end

      Vedeu.bind(:_menu_items_) { |name| Vedeu.menus.find(name).items }
      Vedeu.bind(:_menu_next_) { |name| Vedeu.menus.find(name).next_item }
      Vedeu.bind(:_menu_prev_) { |name| Vedeu.menus.find(name).prev_item }

      Vedeu.bind(:_menu_selected_) do |name|
        Vedeu.menus.find(name).selected_item
      end

      Vedeu.bind(:_menu_select_) { |name| Vedeu.menus.find(name).select_item }
      Vedeu.bind(:_menu_top_) { |name| Vedeu.menus.find(name).top_item }
      Vedeu.bind(:_menu_view_) { |name| Vedeu.menus.find(name).view }

    end # Menus
    # :nocov:

  end # Bindings

end # Vedeu
