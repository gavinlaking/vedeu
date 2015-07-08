module Vedeu

  module Bindings

    # System events relating to the visibility of cursors or interfaces.
    #
    # @api public
    module Visibility

      # Hide the cursor of the named interface or interface currently in focus.
      #
      # Also available as:
      #   Vedeu.hide_cursor(name)
      Vedeu.bind(:_hide_cursor_) do |name|
        Vedeu::Visibility.for_cursor(name).hide
      end
      Vedeu.bind(:_cursor_hide_) { |name| Vedeu.trigger(:_hide_cursor_, name) }

      # Will hide all of the interfaces belonging to the named group. Useful for
      # hiding part of that which is currently displaying in the terminal.
      #
      # @note
      #   This may be rarely used, since the action of showing a group using
      #   `Vedeu.trigger(:_show_group_, group_name)` will effectively clear the
      #   terminal and show the new group.}
      Vedeu.bind(:_hide_group_) { |name| Vedeu.trigger(:_clear_group_, name) }

      # @see Vedeu::Buffer#hide
      Vedeu.bind(:_hide_interface_) { |name| Vedeu.buffers.by_name(name).hide }

      # Show the cursor of the named interface or interface currently in focus.
      #
      # Also available as:
      #   Vedeu.show_cursor(name)
      Vedeu.bind(:_show_cursor_) do |name|
        Vedeu::Visibility.for_cursor(name).show
      end
      Vedeu.bind(:_cursor_show_) { |name| Vedeu.trigger(:_show_cursor_, name) }

      # Will clear the terminal and then show all of the interfaces belonging to
      # the named group.
      Vedeu.bind(:_show_group_) do |name|
        Vedeu.trigger(:_clear_)
        Vedeu.trigger(:_refresh_group_, name)
      end

      # @see Vedeu::Buffer#show
      Vedeu.bind(:_show_interface_) { |name| Vedeu.buffers.by_name(name).show }

      # @see Vedeu::Buffer#toggle
      Vedeu.bind(:_toggle_interface_) do |name|
        Vedeu.buffers.by_name(name).toggle
      end

    end # Visibility

  end # Bindings

end # Vedeu
