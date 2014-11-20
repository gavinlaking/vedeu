module Vedeu

  # Offset represents the scroll position of the content for an interface. The
  # values herein are relative to the geometry of the interface.
  #
  # @note (to self) An offset is a position. A cursor resides at a position in
  #   an interface, ergo we can calculate cursors based from offsets. Also, we
  #   could rename Offset to Position, then kill Cursor, Cursors, and the old
  #   Position class.
  #
  # @api private
  class Offset

    attr_reader :name

    # Returns a new instance of Offset.
    #
    # @param attributes [Hash]
    # @return [Offset]
    def initialize(attributes = {})
      @attributes = defaults.merge!(attributes)
      @name       = @attributes[:name]
      @y          = @attributes[:y]
      @x          = @attributes[:x]
    end

    # Return a convenient hash of the current values of this instance.
    #
    # @return [Hash]
    def attributes
      {
        name: name,
        y:    y,
        x:    x,
      }
    end

    # Adjusts the offset using the relative values provided, and updates the
    # stored attributes. The values passed are -1, 0 or 1.
    #
    # @param relative_y [Fixnum] Move up (-1), or down (1), or no action (0).
    # @param relative_x [Fixnum] Move left (-1), or right (1), or no action (0).
    # @return [Offset]
    def move(relative_y, relative_x)
      @y += relative_y
      @x += relative_x

      Offsets.update(attributes)
    end

    # Returns the current x offset, correcting to 0 if less than 0.
    #
    # @return [Fixnum]
    def x
      return @x = 0 if @x <= 0

      @x
    end

    # Returns the current y offset, correcting to 0 if less than 0.
    #
    # @return [Fixnum]
    def y
      return @y = 0 if @y <= 0

      @y
    end

    private

    # Return the default values for an instance of Offset.
    #
    # @return [Hash]
    def defaults
      {
        name: '',
        y:    0,
        x:    0,
      }
    end

  end # Offset

end # Vedeu
