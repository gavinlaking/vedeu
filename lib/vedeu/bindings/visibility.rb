module Vedeu

  module Bindings

    # System events relating to the visibility of cursors or interfaces.
    #
    # @api public
    # {include:file:docs/events/visibility.md}
    # :nocov:
    module Visibility

      extend self

      # Setup events relating to visibility.
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

      def hide_cursor!
        Vedeu.bind(:_hide_cursor_) do |name|
          Vedeu::Visibility.hide_cursor(name)
        end
        Vedeu.bind(:_cursor_hide_) do |name|
          Vedeu.trigger(:_hide_cursor_, name)
        end
      end

      def hide_group!
        Vedeu.bind(:_hide_group_) do |name|
          Vedeu.trigger(:_clear_group_, name)
        end
      end

      def hide_interface!
        Vedeu.bind(:_hide_interface_) do |name|
          Vedeu.buffers.by_name(name).hide
        end
      end

      def show_cursor!
        Vedeu.bind(:_show_cursor_) do |name|
          Vedeu::Visibility.show_cursor(name)
        end
        Vedeu.bind(:_cursor_show_) do |name|
          Vedeu.trigger(:_show_cursor_, name)
        end
      end

      def show_group!
        Vedeu.bind(:_show_group_) do |name|
          Vedeu.trigger(:_clear_)
          Vedeu.trigger(:_refresh_group_, name)
        end
      end

      def show_interface!
        Vedeu.bind(:_show_interface_) do |name|
          Vedeu.buffers.by_name(name).show
        end
      end

      def toggle_interface!
        Vedeu.bind(:_toggle_interface_) do |name|
          Vedeu.buffers.by_name(name).toggle
        end
      end

    end # Visibility
    # :nocov:

  end # Bindings

end # Vedeu
