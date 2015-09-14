module Vedeu

  module Bindings

    # Creates system events which when called provide a variety of
    # core functions and behaviours. They are soft-namespaced using
    # underscores.
    #
    # :nocov:
    module Refresh

      extend self

      # Setup events relating to running Vedeu. This method is called
      # by Vedeu.
      #
      # @return [TrueClass]
      def setup!
        refresh!
        refresh_cursor!
        refresh_group!
      end

      private

      # Refreshes all registered interfaces or the named interface.
      #
      # @note
      #   The interfaces will be refreshed in z-index order, meaning
      #   that interfaces with a lower z-index will be drawn first.
      #   This means overlapping interfaces will be drawn as
      #   specified. Hidden interfaces will be still refreshed in
      #   memory but not shown.
      #
      # @example
      #   Vedeu.trigger(:_refresh_)
      #   Vedeu.trigger(:_refresh_, name)
      #
      # @return [TrueClass]
      def refresh!
        Vedeu.bind(:_refresh_) do |name|
          name ? Vedeu::Buffers::Refresh.by_name(name) : Vedeu::Refresh.all
        end
      end

      # Will cause the named cursor to refresh, or the cursor of the
      # interface which is currently in focus.
      #
      # @example
      #   Vedeu.trigger(:_refresh_cursor_, name)
      #
      # @return [TrueClass]
      def refresh_cursor!
        Vedeu.bind(:_refresh_cursor_) do |name|
          Vedeu::Cursors::Refresh.by_name(name)
        end
      end

      # Will cause all interfaces in the named group to refresh.
      #
      # @example
      #   Vedeu.trigger(:_refresh_group_, name)
      #
      # @return [TrueClass]
      def refresh_group!
        Vedeu.bind(:_refresh_group_) do |name|
          Vedeu::RefreshGroup.by_name(name)
        end
      end

    end # Refresh
    # :nocov:

  end # Bindings

end # Vedeu
