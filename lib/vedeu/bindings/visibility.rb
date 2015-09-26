module Vedeu

  module Bindings

    # System events relating to the visibility of cursors or
    # interfaces.
    #
    module Visibility

      extend self

      # Setup events relating to visibility. This method is called by
      # Vedeu.
      #
      # @return [TrueClass]
      def setup!
        clear!
        clear_group!
        clear_view!
        hide_cursor!
        hide_group!
        hide_interface!
        show_cursor!
        show_group!
        show_interface!
        toggle_cursor!
        toggle_group!
        toggle_interface!
      end

      private

      # :nocov:

      # See {file:docs/events/visibility.md#\_cleanup_}
      def clear!
        Vedeu.bind(:_clear_) { Vedeu::Terminal::Buffer.clear }
      end

      # See {file:docs/events/visibility.md#\_clear_group_}
      def clear_group!
        Vedeu.bind(:_clear_group_) { |name| Vedeu::Clear::Group.render(name) }
      end

      # See {file:docs/events/visibility.md#\_clear_view_}
      def clear_view!
        Vedeu.bind(:_clear_view_) do |name|
          Vedeu::Clear::Interface.render(name)
        end
      end

      # See {file:docs/events/visibility.md#\_hide_cursor_}
      def hide_cursor!
        Vedeu.bind(:_hide_cursor_) do |name|
          Vedeu::Cursors::Cursor.hide_cursor(name)
        end

        Vedeu.bind_alias(:_cursor_hide_, :_hide_cursor_)
      end

      # See {file:docs/events/visibility.md#\_hide_group_}
      def hide_group!
        Vedeu.bind(:_hide_group_) do |name|
          Vedeu::Models::Group.hide_group(name)
        end
      end

      # See {file:docs/events/visibility.md#\_hide_interface_}
      def hide_interface!
        Vedeu.bind(:_hide_interface_) do |name|
          Vedeu::Models::Interface.hide_interface(name)
        end
      end

      # See {file:docs/events/visibility.md#\_show_cursor_}
      def show_cursor!
        Vedeu.bind(:_show_cursor_) do |name|
          Vedeu::Cursors::Cursor.show_cursor(name)
        end

        Vedeu.bind_alias(:_cursor_show_, :_show_cursor_)
      end

      # See {file:docs/events/visibility.md#\_show_group_}
      def show_group!
        Vedeu.bind(:_show_group_) do |name|
          Vedeu::Models::Group.show_group(name)
        end
      end

      # See {file:docs/events/visibility.md#\_show_interface_}
      def show_interface!
        Vedeu.bind(:_show_interface_) do |name|
          Vedeu::Models::Interface.show_interface(name)
        end
      end

      # See {file:docs/events/visibility.md#\_toggle_cursor_}
      def toggle_cursor!
        Vedeu.bind(:_toggle_cursor_) do |name|
          Vedeu::Cursors::Cursor.toggle_cursor(name)
        end
      end

      # See {file:docs/events/visibility.md#\_toggle_group_}
      def toggle_group!
        Vedeu.bind(:_toggle_group_) do |name|
          Vedeu::Models::Group.toggle_group(name)
        end
      end

      # See {file:docs/events/visibility.md#\_toggle_interface_}
      def toggle_interface!
        Vedeu.bind(:_toggle_interface_) do |name|
          Vedeu::Models::Interface.toggle_interface(name)
        end
      end

      # :nocov:

    end # Visibility

  end # Bindings

end # Vedeu
