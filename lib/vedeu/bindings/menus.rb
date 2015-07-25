module Vedeu

  module Bindings

    # Each of the Bindings::Menus events require a target menu name as an
    # argument.
    #
    # :nocov:
    module Menus

      extend self

      # Setup events relating to menus. This method is called by Vedeu.
      #
      # @return [void]
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

      # Makes the last menu item the current menu item.
      #
      # @example
      #   Vedeu.trigger(:_menu_bottom_, name)
      #
      # @return [void]
      def menu_bottom!
        Vedeu.bind(:_menu_bottom_) do |name|
          Vedeu.menus.by_name(name).bottom_item
        end
      end

      # Returns the current menu item.
      #
      # @example
      #   Vedeu.trigger(:_menu_current_, name)
      #
      # @return [void]
      def menu_current!
        Vedeu.bind(:_menu_current_) do |name|
          Vedeu.menus.by_name(name).current_item
        end
      end

      # Deselects all menu items.
      #
      # @example
      #   Vedeu.trigger(:_menu_deselect_, name)
      #
      # @return [void]
      def menu_deselect!
        Vedeu.bind(:_menu_deselect_) do |name|
          Vedeu.menus.by_name(name).deselect_item
        end
      end

      # Returns all the menu items with respective `current` or `selected`
      # boolean indicators.
      #
      # @example
      #   Vedeu.trigger(:_menu_items_, name)
      #
      # @return [void]
      def menu_items!
        Vedeu.bind(:_menu_items_) { |name| Vedeu.menus.by_name(name).items }
      end

      # Makes the next menu item the current menu item, until it reaches the
      # last item.
      #
      # @example
      #   Vedeu.trigger(:_menu_next_, name)
      #
      # @return [void]
      def menu_next!
        Vedeu.bind(:_menu_next_) { |name| Vedeu.menus.by_name(name).next_item }
      end

      # Makes the previous menu item the current menu item, until it reaches the
      # first item.
      #
      # @example
      #   Vedeu.trigger(:_menu_prev_, name)
      #
      # @return [void]
      def menu_prev!
        Vedeu.bind(:_menu_prev_) { |name| Vedeu.menus.by_name(name).prev_item }
      end

      # Returns the selected menu item.
      #
      # @example
      #   Vedeu.trigger(:_menu_selected_, name)
      #
      # @return [void]
      def menu_selected!
        Vedeu.bind(:_menu_selected_) do |name|
          Vedeu.menus.by_name(name).selected_item
        end
      end

      # Makes the current menu item also the selected menu item.
      #
      # @example
      #   Vedeu.trigger(:_menu_select_, name)
      #
      # @return [void]
      def menu_select!
        Vedeu.bind(:_menu_select_) do |name|
          Vedeu.menus.by_name(name).select_item
        end
      end

      # Makes the first menu item the current menu item.
      #
      # @example
      #   Vedeu.trigger(:_menu_top_, name)
      #
      # @return [void]
      def menu_top!
        Vedeu.bind(:_menu_top_) { |name| Vedeu.menus.by_name(name).top_item }
      end

      # Returns a subset of the menu items; starting at the current item to the
      # last item.
      #
      # @example
      #   Vedeu.trigger(:_menu_view_, name)
      #
      # @return [void]
      def menu_view!
        Vedeu.bind(:_menu_view_) { |name| Vedeu.menus.by_name(name).view }
      end

    end # Menus
    # :nocov:

  end # Bindings

end # Vedeu
