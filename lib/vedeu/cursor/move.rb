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

    def_delegators :@interface, :border,
                   :border?,
                   :geometry

    def_delegators :geometry, :left,
                   :top,
                   :height,
                   :width

    # Returns an instance of Vedeu::Move.
    #
    # @param cursor    [Cursor]
    # @param interface [Interface]
    # @param dy        [Fixnum] Move up (-1), or down (1), or no action (0).
    # @param dx        [Fixnum] Move left (-1), or right (1), or no action (0).
    # @return [Move]
    def initialize(cursor, interface, dy = 0, dx = 0)
      @cursor    = cursor
      @dy        = dy || 0
      @dx        = dx || 0
      @interface = interface
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
      if name
        cursor     = Vedeu.cursors.by_name(name)
        interface  = Vedeu.interfaces.find(name)

      else
        cursor     = Vedeu.cursor
        interface  = Vedeu.interfaces.current

      end

      new_cursor = Vedeu::Move.send(direction, cursor, interface)

      Vedeu.trigger(:_refresh_cursor_, new_cursor.name)

      new_cursor
    end

    # Moves the cursor down by one row.
    #
    # @param cursor    [Cursor]
    # @param interface [Interface]
    # @return [Cursor]
    def self.down(cursor, interface)
      new(cursor, interface, 1, 0).move
    end

    # Moves the cursor left by one column.
    #
    # @param cursor    [Cursor]
    # @param interface [Interface]
    # @return [Cursor]
    def self.left(cursor, interface)
      return cursor unless cursor.ox > 0

      new(cursor, interface, 0, -1).move
    end

    # Moves the cursor right by one column.
    #
    # @param cursor    [Cursor]
    # @param interface [Interface]
    # @return [Cursor]
    def self.right(cursor, interface)
      new(cursor, interface, 0, 1).move
    end

    # Moves the cursor up by one row.
    #
    # @param cursor    [Cursor]
    # @param interface [Interface]
    # @return [Cursor]
    def self.up(cursor, interface)
      return cursor unless cursor.oy > 0

      new(cursor, interface, -1, 0).move
    end

    # Moves the cursor to the top left coordinate of the interface.
    #
    # @param cursor    [Cursor]
    # @param interface [Interface]
    # @return [Cursor]
    def self.origin(cursor, interface)
      new(cursor, interface, (0 - cursor.y), (0 - cursor.x)).move
    end

    # Returns a newly positioned and stored Cursor.
    #
    # @return [Cursor]
    def move
      Vedeu::Cursor.new(cursor.attributes.merge!(moved_attributes)).store
    end

    private

    # @!attribute [r] cursor
    # @return [Vedeu::Cursor]
    attr_reader :cursor

    # @!attribute [r] dx
    # @return [Fixnum]
    attr_reader :dx

    # @!attribute [r] dy
    # @return [Fixnum]
    attr_reader :dy

    # @!attribute [r] interface
    # @return [Vedeu::Interface]
    attr_reader :interface

    # @return [Hash<Symbol => Fixnum>]
    def moved_attributes
      {
        x:  validator.x,
        y:  validator.y,
        ox: ox,
        oy: oy,
      }
    end

    # @return [PositionValidator]
    def validator
      @validator ||= Vedeu::PositionValidator.validate(interface,
                                                       coordinate.x_position(ox),
                                                       coordinate.y_position(oy))
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

    # @return [Coordinate]
    def coordinate
      @coordinate ||= Vedeu::Coordinate.new(bordered_height,
                                            bordered_width,
                                            left,
                                            top)
    end

    # Return the height of the interface, minus any borders.
    #
    # @return [Fixnum]
    def bordered_height
      return border.height if border?

      height
    end

    # Return the width of the interface, minus any borders.
    #
    # @return [Fixnum]
    def bordered_width
      return border.width if border?

      width
    end

  end # Move

end # Vedeu
