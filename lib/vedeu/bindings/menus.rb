module Vedeu

  module Bindings

    # Each of the Bindings::Menus events require a target menu name as an
    # argument.
    #
    # @api public
    # {include:file:docs/events/menus.md}
    # :nocov:
    module Menus

      extend self

      # Setup events relating to menus.
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

      def menu_bottom!
        Vedeu.bind(:_menu_bottom_) { |name| Vedeu.menus.find(name).bottom_item }
      end

      def menu_current!
        Vedeu.bind(:_menu_current_) do |name|
          Vedeu.menus.find(name).current_item
        end
      end

      def menu_deselect!
        Vedeu.bind(:_menu_deselect_) do |name|
          Vedeu.menus.find(name).deselect_item
        end
      end

      def menu_items!
        Vedeu.bind(:_menu_items_) { |name| Vedeu.menus.find(name).items }
      end

      def menu_next!
        Vedeu.bind(:_menu_next_) { |name| Vedeu.menus.find(name).next_item }
      end

      def menu_prev!
        Vedeu.bind(:_menu_prev_) { |name| Vedeu.menus.find(name).prev_item }
      end

      def menu_selected!
        Vedeu.bind(:_menu_selected_) do |name|
          Vedeu.menus.find(name).selected_item
        end
      end

      def menu_select!
        Vedeu.bind(:_menu_select_) { |name| Vedeu.menus.find(name).select_item }
      end

      def menu_top!
        Vedeu.bind(:_menu_top_) { |name| Vedeu.menus.find(name).top_item }
      end

      def menu_view!
        Vedeu.bind(:_menu_view_) { |name| Vedeu.menus.find(name).view }
      end

    end # Menus
    # :nocov:

  end # Bindings

end # Vedeu
