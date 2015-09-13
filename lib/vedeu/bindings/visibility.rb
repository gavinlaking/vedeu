module Vedeu

  module Bindings

    # System events relating to the visibility of cursors or interfaces.
    #
    # :nocov:
    module Visibility

      extend self

      # Setup events relating to visibility. This method is called by Vedeu.
      #
      # @return [TrueClass]
      def setup!
        clear_group!
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

      # Clears the spaces occupied by the interfaces belonging to the named
      # group.
      #
      # @example
      #   Vedeu.trigger(:_clear_group_, name)
      #   Vedeu.clear_by_group(name)
      #
      # @return [TrueClass]
      def clear_group!
        Vedeu.bind(:_clear_group_) do |name|
          Vedeu::Clear::NamedGroup.render(name)
        end
      end

      # Hide the cursor of the named interface or when a name is not given, the
      # interface currently in focus.
      #
      # @example
      #   Vedeu.trigger(:_hide_cursor_, name)
      #   Vedeu.trigger(:_cursor_hide_, name)
      #   Vedeu.hide_cursor(name)
      #
      # @return [TrueClass]
      def hide_cursor!
        Vedeu.bind(:_hide_cursor_) do |name|
          Vedeu::Cursors::Cursor.hide_cursor(name)
        end

        Vedeu.bind_alias(:_cursor_hide_, :_hide_cursor_)
      end

      # @see Vedeu::Group#hide
      def hide_group!
        Vedeu.bind(:_hide_group_) { |name| Vedeu::Group.hide_group(name) }
      end

      # Hiding an interface.
      #
      # @example
      #   Vedeu.trigger(:_hide_interface_, name)
      #   Vedeu.hide_interface(name)
      #
      # @return [TrueClass]
      def hide_interface!
        Vedeu.bind(:_hide_interface_) do |name|
          Vedeu::Interface.hide_interface(name)
        end
      end

      # Show the cursor of the named interface or when a name is not given, the
      # interface currently in focus.
      #
      # @example
      #   Vedeu.trigger(:_show_cursor_, name)
      #   Vedeu.trigger(:_cursor_show_, name)
      #   Vedeu.show_cursor(name)
      #
      # @return [TrueClass]
      def show_cursor!
        Vedeu.bind(:_show_cursor_) do |name|
          Vedeu::Cursors::Cursor.show_cursor(name)
        end

        Vedeu.bind_alias(:_cursor_show_, :_show_cursor_)
      end

      # @see Vedeu::Group#show
      def show_group!
        Vedeu.bind(:_show_group_) { |name| Vedeu::Group.show_group(name) }
      end

      # Showing an interface.
      #
      # @example
      #   Vedeu.trigger(:_show_interface_, name)
      #   Vedeu.show_interface(name)
      #
      # @return [TrueClass]
      def show_interface!
        Vedeu.bind(:_show_interface_) do |name|
          Vedeu::Interface.show_interface(name)
        end
      end

      # Toggling a cursor.
      #
      # @example
      #   Vedeu.trigger(:_toggle_cursor_, name)
      #   Vedeu.toggle_cursor(name)
      #
      # @return [TrueClass]
      def toggle_cursor!
        Vedeu.bind(:_toggle_cursor_) do |name|
          Vedeu::Cursors::Cursor.toggle_cursor(name)
        end
      end

      # Toggling a group.
      #
      # @example
      #   Vedeu.trigger(:_toggle_group_, name)
      #   Vedeu.toggle_group(name)
      #
      # @return [TrueClass]
      def toggle_group!
        Vedeu.bind(:_toggle_group_) do |name|
          Vedeu::Group.toggle_group(name)
        end
      end

      # Toggling an interface.
      #
      # @example
      #   Vedeu.trigger(:_toggle_interface_, name)
      #   Vedeu.toggle_interface(name)
      #
      # @return [TrueClass]
      def toggle_interface!
        Vedeu.bind(:_toggle_interface_) do |name|
          Vedeu::Interface.toggle_interface(name)
        end
      end

    end # Visibility
    # :nocov:

  end # Bindings

end # Vedeu
