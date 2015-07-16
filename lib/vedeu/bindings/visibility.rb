module Vedeu

  module Bindings

    # System events relating to the visibility of cursors or interfaces.
    #
    # @api public
    # :nocov:
    module Visibility

      extend self

      # Setup events relating to visibility. This method is called by Vedeu.
      #
      # @return [void]
      def setup!
        hide_cursor!
        hide_group!
        hide_interface!
        show_cursor!
        show_group!
        show_interface!
        toggle_interface!
      end

      private

      # Hide the cursor of the named interface or if a name is not given, the
      # interface currently in focus.
      #
      # @example
      #   Vedeu.trigger(:_hide_cursor_, name)
      #   Vedeu.trigger(:_cursor_hide_, name)
      #   Vedeu.hide_cursor(name)
      #
      # @return [void]
      def hide_cursor!
        Vedeu.bind(:_hide_cursor_) do |name|
          Vedeu::Visibility.hide_cursor(name)
        end
        Vedeu.bind(:_cursor_hide_) do |name|
          Vedeu.trigger(:_hide_cursor_, name)
        end
      end

      # Will hide all of the interfaces belonging to the named group. Useful for
      # hiding part of that which is currently displaying in the terminal.

      # This may be rarely used, since the action of showing a group will
      # effectively clear the terminal and show the new group.
      #
      # @example
      #   Vedeu.trigger(:_hide_group_, group_name)
      #
      # @return [void]
      def hide_group!
        Vedeu.bind(:_hide_group_) do |name|
          Vedeu.trigger(:_clear_group_, name)
        end
      end

      # Hiding an interface.
      #
      # @example
      #   Vedeu.trigger(:_hide_interface_, name)
      #
      # @return [void]
      # @see Vedeu::Buffer#hide
      def hide_interface!
        Vedeu.bind(:_hide_interface_) do |name|
          Vedeu.buffers.by_name(name).hide
        end
      end

      # Show the cursor of the named interface or if a name is not given, the
      # interface currently in focus.
      #
      # @example
      #   Vedeu.trigger(:_show_cursor_, name)
      #   Vedeu.trigger(:_cursor_show_, name)
      #   Vedeu.show_cursor(name)
      #
      # @return [void]
      def show_cursor!
        Vedeu.bind(:_show_cursor_) do |name|
          Vedeu::Visibility.show_cursor(name)
        end
        Vedeu.bind(:_cursor_show_) do |name|
          Vedeu.trigger(:_show_cursor_, name)
        end
      end

      # Will clear the terminal and then show all of the interfaces belonging to
      # the named group.
      #
      # @example
      #   Vedeu.trigger(:_show_group_, group_name)
      #
      # @return [void]
      def show_group!
        Vedeu.bind(:_show_group_) do |name|
          Vedeu.trigger(:_clear_)
          Vedeu.trigger(:_refresh_group_, name)
        end
      end

      # Showing an interface.
      #
      # @example
      #   Vedeu.trigger(:_show_interface_, name)
      #
      # @return [void]
      # @see Vedeu::Buffer#show
      def show_interface!
        Vedeu.bind(:_show_interface_) do |name|
          Vedeu.buffers.by_name(name).show
        end
      end

      # Toggling an interface.
      #
      # @example
      #   Vedeu.trigger(:_toggle_interface_, name)
      #
      # @return [void]
      # @see Vedeu::Buffer#toggle
      def toggle_interface!
        Vedeu.bind(:_toggle_interface_) do |name|
          Vedeu.buffers.by_name(name).toggle
        end
      end

    end # Visibility
    # :nocov:

  end # Bindings

end # Vedeu
