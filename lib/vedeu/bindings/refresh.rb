module Vedeu

  module Bindings

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

      # See {file:docs/events.md#\_refresh_}
      def refresh!
        Vedeu.bind(:_refresh_) do |name|
          name ? Vedeu::Buffers::Refresh.by_name(name) : Vedeu::Refresh.all
        end
      end

      # See {file:docs/events.md#\_refresh_cursor_}
      def refresh_cursor!
        Vedeu.bind(:_refresh_cursor_) do |name|
          Vedeu::Cursors::Refresh.by_name(name)
        end
      end

      # See {file:docs/events.md#\_refresh_group_}
      def refresh_group!
        Vedeu.bind(:_refresh_group_) do |name|
          Vedeu::RefreshGroup.by_name(name)
        end
      end

    end # Refresh

  end # Bindings

end # Vedeu
