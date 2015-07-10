module Vedeu

  module Bindings

    # System events relating to the visibility of cursors or interfaces.
    #
    # @api public
    # {include:file:docs/events/visibility.md}
    module Visibility

      Vedeu.bind(:_hide_cursor_) { |name| Vedeu::Visibility.hide_cursor(name) }
      Vedeu.bind(:_cursor_hide_) { |name| Vedeu.trigger(:_hide_cursor_, name) }

      Vedeu.bind(:_show_cursor_) { |name| Vedeu::Visibility.show_cursor(name) }
      Vedeu.bind(:_cursor_show_) { |name| Vedeu.trigger(:_show_cursor_, name) }

      Vedeu.bind(:_hide_group_) { |name| Vedeu.trigger(:_clear_group_, name) }

      Vedeu.bind(:_show_group_) do |name|
        Vedeu.trigger(:_clear_)
        Vedeu.trigger(:_refresh_group_, name)
      end

      Vedeu.bind(:_hide_interface_) { |name| Vedeu.buffers.by_name(name).hide }
      Vedeu.bind(:_show_interface_) { |name| Vedeu.buffers.by_name(name).show }
      Vedeu.bind(:_toggle_interface_) do |name|
        Vedeu.buffers.by_name(name).toggle
      end

    end # Visibility

  end # Bindings

end # Vedeu
