module Vedeu

  # Provides the mechanism to arbitrarily move a cursor to a given position.
  #
  class Reposition

    # @return [Vedeu::Cursor]
    # @see Vedeu::Reposition.new
    def self.to(entity, name, y, x)
      new(entity, name, y, x).to
    end

    # Returns a new instance of Vedeu::Reposition.
    #
    # @param entity [void]
    # @param name [String]
    # @param y [Fixnum] The row/line position.
    # @param x [Fixnum] The column/character position.
    # @return [Vedeu::Reposition]
    def initialize(entity, name, y, x)
      @entity = entity
      @name   = name
      @y      = y
      @x      = x
    end

    # @return [Vedeu::Cursor]
    def to
      result = entity.new(name: name,
                          y:    coordinate.y_position,
                          x:    coordinate.x_position,
                          oy:   y,
                          ox:   x).store

      Vedeu.trigger(:_clear_, name)
      Vedeu.trigger(:_refresh_, name)
      Vedeu.trigger(:_refresh_cursor_, name)

      result
    end

    protected

    # @!attribute [r] entity
    # @return [String]
    attr_reader :entity

    # @!attribute [r] name
    # @return [String]
    attr_reader :name

    # @!attribute [r] x
    # @return [Fixnum]
    attr_reader :x

    # @!attribute [r] y
    # @return [Fixnum]
    attr_reader :y

    private

    # @return [Vedeu::Coordinate]
    def coordinate
      @coordinate ||= Vedeu::Coordinate.new(name, y, x)
    end

  end # Reposition

end # Vedeu
