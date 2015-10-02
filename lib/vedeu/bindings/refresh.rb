module Vedeu

  module Bindings

    # Provides events to refresh the view.
    #
    module Refresh

      extend self

      # Setup events relating to running Vedeu. This method is called
      # by Vedeu.
      #
      # @return [TrueClass]
      def setup!
        refresh!
        refresh_border!
        refresh_cursor!
        refresh_group!
        refresh_view!
        refresh_view_content!
      end

      private

      # :nocov:

      # See {file:docs/events/refresh.md#\_refresh_}
      def refresh!
        Vedeu.bind(:_refresh_) { Vedeu::Output::Refresh.all }
      end

      # See {file:docs/events/refresh.md#\_refresh_border_}
      def refresh_border!
        Vedeu.bind(:_refresh_border_) do |name|
          Vedeu::Borders::Render.by_name(name)
        end
      end

      # See {file:docs/events/refresh.md#\_refresh_cursor_}
      def refresh_cursor!
        Vedeu.bind(:_refresh_cursor_) do |name|
          Vedeu::Cursors::Refresh.by_name(name)
        end
      end

      # See {file:docs/events/refresh.md#\_refresh_group_}
      def refresh_group!
        Vedeu.bind(:_refresh_group_) do |name|
          Vedeu::Groups::Refresh.by_name(name)
        end
      end

      # See {file:docs/events/refresh.md#\_refresh_view_}
      def refresh_view!
        Vedeu.bind(:_refresh_view_) do |name|
          Vedeu::Buffers::Refresh.by_name(name)
        end
      end

      # See {file:docs/events/refresh.md#\_refresh_view_content_}
      def refresh_view_content!
        Vedeu.bind(:_refresh_view_content_) do |name|
          Vedeu::Buffers::Refresh.refresh_content_by_name(name)
        end
      end

      # :nocov:

    end # Refresh

  end # Bindings

end # Vedeu
