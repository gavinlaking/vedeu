module Vedeu

  # Handle the refreshing (redrawing) of a cursor, without redrawing the whole
  # interface; unless the cursor's offset has caused the view to change.
  #
  class RefreshCursor

    extend Forwardable

    def_delegators :border,
                   :height,
                   :width

    # @param (see #initialize)
    def self.render(name = Vedeu.focus)
      new(name).render
    end

    # Returns a new instance of Vedeu::RefreshCursor.
    #
    # @param name [String] The name of the cursor.
    # @return [Vedeu::RefreshCursor]
    def initialize(name)
      @name = name
    end

    # Renders the cursor in the terminal. If the cursor's x or y offsets are
    # greater or equal to the interface's width or height respectively, then
    # the view is also refreshed, causing the content to be offset also.
    #
    # @return [Array]
    def render
      Vedeu.log(type: :info, message: "Refreshing cursor: '#{name}'")

      Vedeu::Refresh.by_name(name) if refresh_view?

      Vedeu::Terminal.output(new_cursor.to_s)
    end

    protected

    # @!attribute [r] name
    # @return [String]
    attr_reader :name

    private

    # Returns true when the view should be refreshed. This is determined by
    # checking that the offsets for x and y are outside the width and height
    # of the named interface.
    #
    # @return [Boolean]
    def refresh_view?
      new_cursor.ox >= width || new_cursor.oy >= height
    end

    # @return [Vedeu::Cursor]
    def new_cursor
      @new_cursor ||= Vedeu::Cursor.new(cursor.attributes.merge(position))
    end

    # @return [Hash<Symbol => Fixnum>]
    def position
      {
        x: cursor.x,
        y: cursor.y,
      }
    end

    # @return [Vedeu::Cursor]
    def cursor
      @cursor ||= Vedeu.cursors.by_name(name)
    end

    # Fetch the border by name.
    #
    # @note
    #   Vedeu::Border is used in this way because when there is not a border
    #   defined, it will fallback to a Vedeu::Null::Border which uses
    #   Vedeu::Geometry to determine it's dimensions based on the name also.
    #   When a Vedeu::Geometry cannot be found, this falls back to a
    #   Vedeu::Null::Geometry which uses the current terminal's dimensions.
    #
    # @return (see Vedeu::Borders#by_name)
    def border
      @border ||= Vedeu.borders.by_name(name)
    end

  end # RefreshCursor

end # Vedeu
