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

    # @return [Array]
    def render
      Vedeu.log(type: :info, message: "Refreshing cursor: '#{name}'")

      Vedeu::Refresh.by_name(name) if refresh_view?

      Vedeu::Terminal.output(new_cursor.to_s)
    end

    private

    # @!attribute [r] name
    # @return [String]
    attr_reader :name

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
        x: validated_position.x,
        y: validated_position.y,
      }
    end

    # @return [Vedeu::PositionValidator]
    def validated_position
      @position ||= Vedeu::PositionValidator.validate(name, cursor.x, cursor.y)
    end

    # @return [Vedeu::Cursor]
    def cursor
      @cursor ||= Vedeu.cursors.by_name(name)
    end

    # @return (see Vedeu::Borders#by_name)
    def border
      @border ||= Vedeu.borders.by_name(name)
    end

  end # RefreshCursor

end # Vedeu
