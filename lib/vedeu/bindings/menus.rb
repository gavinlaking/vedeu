module Vedeu

  module Bindings

    # Each of the Bindings::Menus events require a target menu name as
    # an argument.
    #
    module Menus

      extend self

      # Setup events relating to menus. This method is called by
      # Vedeu.
      #
      # @return [TrueClass]
      def setup!
        menu_bottom!
        menu_current!
        menu_deselect!
        menu_items!
        menu_next!
        menu_prev!
        menu_selected!
        menu_select!
        menu_top!
        menu_view!
      end

      private

      # See {file:docs/events.md#\_menu_bottom_}
      def menu_bottom!
        Vedeu.bind(:_menu_bottom_) do |name|
          Vedeu.menus.by_name(name).bottom_item
        end
      end

      # See {file:docs/events.md#\_menu_current_}
      def menu_current!
        Vedeu.bind(:_menu_current_) do |name|
          Vedeu.menus.by_name(name).current_item
        end
      end

      # See {file:docs/events.md#\_menu_deselect_}
      def menu_deselect!
        Vedeu.bind(:_menu_deselect_) do |name|
          Vedeu.menus.by_name(name).deselect_item
        end
      end

      # See {file:docs/events.md#\_menu_items_}
      def menu_items!
        Vedeu.bind(:_menu_items_) { |name| Vedeu.menus.by_name(name).items }
      end

      # See {file:docs/events.md#\_menu_next_}
      def menu_next!
        Vedeu.bind(:_menu_next_) { |name| Vedeu.menus.by_name(name).next_item }
      end

      # See {file:docs/events.md#\_menu_prev_}
      def menu_prev!
        Vedeu.bind(:_menu_prev_) { |name| Vedeu.menus.by_name(name).prev_item }
      end

      # See {file:docs/events.md#\_menu_selected_}
      def menu_selected!
        Vedeu.bind(:_menu_selected_) do |name|
          Vedeu.menus.by_name(name).selected_item
        end
      end

      # See {file:docs/events.md#\_menu_select_}
      def menu_select!
        Vedeu.bind(:_menu_select_) do |name|
          Vedeu.menus.by_name(name).select_item
        end
      end

      # See {file:docs/events.md#\_menu_top_}
      def menu_top!
        Vedeu.bind(:_menu_top_) { |name| Vedeu.menus.by_name(name).top_item }
      end

      # See {file:docs/events.md#\_menu_view_}
      def menu_view!
        Vedeu.bind(:_menu_view_) { |name| Vedeu.menus.by_name(name).view }
      end

    end # Menus

  end # Bindings

end # Vedeu
