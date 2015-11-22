module Vedeu

  module Cursors

    # Handle the refreshing (redrawing) of a cursor, without redrawing
    # the whole interface; unless the cursor's offset has caused the
    # view to change.
    #
    # @api private
    #
    class Refresh

      extend Forwardable
      include Vedeu::Common

      def_delegators :cursor,
                     :ox,
                     :oy,
                     :render,
                     :visible,
                     :visible?,
                     :x,
                     :y

      def_delegators :geometry,
                     :bordered_height,
                     :bordered_width

      # @example
      #   Vedeu.trigger(:_refresh_cursor_, name)
      #
      # @param (see #initialize)
      # @return (see #by_name)
      def self.by_name(name = Vedeu.focus)
        new(name).by_name
      end

      # Returns a new instance of Vedeu::Cursors::Refresh.
      #
      # @param name [String|Symbol] The name of the interface/view
      #   cursor to be refreshed. Defaults to `Vedeu.focus`.
      # @return [Vedeu::Cursors::Refresh]
      def initialize(name)
        @name = name
      end

      # Renders the cursor in the terminal. If the cursor's x or y
      # offsets are greater or equal to the interface's width or
      # height respectively, then the view is also refreshed, causing
      # the content to be offset also.
      #
      # @return [Array]
      def by_name
        refresh_view if refresh_view?

        Vedeu.log(type:    :output,
                  message: "Refreshing cursor: '#{name}' (x:#{x}, y:#{y}, " \
                           "ox:#{ox}, oy:#{oy}, visible:#{visible})".freeze)

        render
      end

      private

      # @return [String|Symbol]
      def name
        present?(@name) ? @name : Vedeu.focus
      end

      # @return [void]
      def refresh_view
        Vedeu.trigger(:_refresh_view_content_, name)
      end

      # Returns true when the view should be refreshed. This is
      # determined by checking that the offsets for x and y are
      # outside the (bordered) width and (bordered) height of the
      # named interface.
      #
      # @return [Boolean]
      def refresh_view?
        visible? && (ox >= bordered_width || oy >= bordered_height)
      end

      # @return [Vedeu::Cursors::Cursor]
      # @see Vedeu::Cursors::Repository#by_name
      def cursor
        @cursor ||= Vedeu.cursors.by_name(name)
      end

      # Fetch the geometry by name.
      #
      # @return (see Vedeu::Geometries::Repository#by_name)
      def geometry
        @geometry ||= Vedeu.geometries.by_name(name)
      end

    end # Refresh

  end # Cursors

  # :nocov:

  # See {file:docs/events/refresh.md#\_refresh_cursor_}
  Vedeu.bind(:_refresh_cursor_) do |name|
    Vedeu::Cursors::Refresh.by_name(name)
  end

  # :nocov:

end # Vedeu
