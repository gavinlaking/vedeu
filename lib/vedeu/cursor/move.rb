require 'vedeu/cursor/cursor'
require 'vedeu/geometry/coordinate'
require 'vedeu/geometry/position_validator'

module Vedeu

  # Adjusts the position of the cursor. To use this class, call the appropriate
  # event:
  #
  # @example
  #   Vedeu.trigger(:_cursor_down_)
  #
  #   Vedeu.trigger(:_cursor_left_) # When a name is not given, the cursor in
  #                                 # the interface which is currently in focus
  #                                 # should move to the left.
  #
  #   Vedeu.trigger(:_cursor_left_, 'my_interface')
  #                                 # When a name is given, the cursor instance
  #                                 # belonging to this interface moves to the
  #                                 # left.
  #
  #   Vedeu.trigger(:_cursor_right_)
  #   Vedeu.trigger(:_cursor_up_)
  #
  #   Vedeu.trigger(:_cursor_origin_)                 # /or/
  #   Vedeu.trigger(:_cursor_origin_, 'my_interface')
  #                                 # Moves the cursor to the top left of the
  #                                 # named or current interface in focus.
  #
  # @note
  #   The cursor may not be visible, but it will still move if requested.
  #   The cursor will not exceed the border or boundary of the interface.
  #   The cursor will move freely within the bounds of the interface,
  #     irrespective of content.
  #
  class Move

    extend Forwardable

    def_delegators :border,
                   :height,
                   :width,
                   :x,
                   :y

    # Returns an instance of Vedeu::Move.
    #
    # @param name [String] The name of the cursor.
    # @param dy [Fixnum] Move up (-1), or down (1), or no action (0).
    # @param dx [Fixnum] Move left (-1), or right (1), or no action (0).
    # @return [Move]
    def initialize(name, dy = 0, dx = 0)
      @name = name
      @dy   = dy
      @dx   = dx
    end

    # Move the named cursor, or that which is currently in focus in the
    # specified direction.
    #
    # @param direction [Symbol] The direction of travel. Directions include:
    #   (:down, :left, :right, :up, :origin). When ':origin' the cursor is moved
    #   to the top left of the interface.
    # @param name [String|NilClass] The name of the interface/cursor to be
    #   moved; when not given, the interface currently in focus determines which
    #   cursor instance to move.
    # @return [Cursor]
    def self.by_name(direction, name = nil)
      name = name ? name : Vedeu.focus

      Vedeu::Move.send(direction, name)
    end

    # Moves the cursor down by one row.
    #
    # @param name [String]
    # @return [Cursor]
    def self.down(name)
      new(name, 1, 0).move
    end

    # Moves the cursor left by one column.
    #
    # @param name [String]
    # @return [Cursor]
    def self.left(name)
      new(name, 0, -1).move
    end

    # Moves the cursor right by one column.
    #
    # @param name [String]
    # @return [Cursor]
    def self.right(name)
      new(name, 0, 1).move
    end

    # Moves the cursor up by one row.
    #
    # @param name [String]
    # @return [Cursor]
    def self.up(name)
      new(name, -1, 0).move
    end

    # Moves the cursor to the top left coordinate of the interface.
    #
    # @param name [String]
    # @return [Cursor]
    def self.origin(name)
      new(name, -2000, -2000).move
    end

    # Returns a newly positioned and stored Cursor.
    #
    # @return [Cursor]
    def move
      cursor = Vedeu::Cursor.new(attributes.merge!(new_attributes)).store

      Vedeu.trigger(:_refresh_cursor_, name)

      cursor
    end

    private

    # @!attribute [r] dx
    # @return [Fixnum]
    attr_reader :dx

    # @!attribute [r] dy
    # @return [Fixnum]
    attr_reader :dy

    # @!attribute [r] name
    # @return [String]
    attr_reader :name

    # @return [Hash<Symbol => Fixnum, String>]
    def attributes
      cursor.attributes
    end

    # @return [Hash<Symbol => Fixnum>]
    def new_attributes
      {
        x:  validator.x,
        y:  validator.y,
        ox: ox,
        oy: oy,
      }
    end

    # @return [PositionValidator]
    def validator
      @validator ||= Vedeu::PositionValidator.validate(name,
                                                       x_position,
                                                       y_position)
    end

    # @return [Fixnum]
    def x_position
      coordinate.x_position(ox)
    end

    # @return [Fixnum]
    def y_position
      coordinate.y_position(oy)
    end

    # @return (see Vedeu::Borders#by_name)
    def border
      @border ||= Vedeu.borders.by_name(name)
    end

    # @return [Coordinate]
    def coordinate
      @coordinate ||= Vedeu::Coordinate.new(height, width, x, y)
    end

    # @return (see Vedeu::Cursors#by_name)
    def cursor
      @cursor ||= Vedeu.cursors.by_name(name)
    end

    # Apply the direction amount to the cursor offset. If the offset is less
    # than 0, correct to 0.
    #
    # @return [Fixnum]
    def ox
      ox = cursor.ox + dx
      ox = 0 if ox < 0
      ox
    end

    # Apply the direction amount to the cursor offset. If the offset is less
    # than 0, correct to 0.
    #
    # @return [Fixnum]
    def oy
      oy = cursor.oy + dy
      oy = 0 if oy < 0
      oy
    end

  end # Move

end # Vedeu
