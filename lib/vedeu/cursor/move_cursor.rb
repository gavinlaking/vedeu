require 'vedeu/cursor/cursor'
require 'vedeu/geometry/coordinate'
require 'vedeu/geometry/position_validator'

module Vedeu

  # Adjusts the position of the cursor.
  #
  class MoveCursor

    extend Forwardable

    def_delegators :@interface, :border,
                                :border?,
                                :geometry

    def_delegators :geometry, :left,
                              :top,
                              :height,
                              :width

    # @param cursor    [Cursor]
    # @param interface [Interface]
    # @param dy        [Fixnum] Move up (-1), or down (1), or no action (0).
    # @param dx        [Fixnum] Move left (-1), or right (1), or no action (0).
    # @return [MoveCursor]
    def initialize(cursor, interface, dy = 0, dx = 0)
      @cursor    = cursor
      @dy        = dy || 0
      @dx        = dx || 0
      @interface = interface
    end

    # Move the named cursor, or that which is currently in focus in the
    # specified direction.
    #
    # @note
    #   Will not exceed the border or boundary of the interface.
    #
    # @param direction [Symbol] The direction of travel.
    #   (:down, :left, :right, :up)
    # @param name [String|NilClass] The name of the interface/cursor to be
    #   moved; when not given, the interface currently in focus determines which
    #   cursor instance to move.
    # @return [Cursor]
    def self.by_name(direction, name = nil)
      if name
        cursor     = Vedeu.cursors.by_name(name)
        interface  = Vedeu.interfaces.find(name)
        new_cursor = MoveCursor.send(direction, cursor, interface)
        Refresh.by_name(name)

      else
        cursor     = Vedeu.cursor
        interface  = Vedeu.interfaces.current
        new_cursor = MoveCursor.send(direction, cursor, interface)
        Refresh.by_focus

      end
      new_cursor
    end

    # Moves the cursor down by one row.
    #
    # @return [Cursor]
    def self.down(cursor, interface)
      new(cursor, interface, 1, 0).move
    end

    # Moves the cursor left by one column.
    #
    # @return [Cursor]
    def self.left(cursor, interface)
      return cursor unless cursor.ox > 0

      new(cursor, interface, 0, -1).move
    end

    # Moves the cursor right by one column.
    #
    # @return [Cursor]
    def self.right(cursor, interface)
      new(cursor, interface, 0, 1).move
    end

    # Moves the cursor up by one row.
    #
    # @return [Cursor]
    def self.up(cursor, interface)
      return cursor unless cursor.oy > 0

      new(cursor, interface, -1, 0).move
    end

    # Moves the cursor to the top left coordinate of the interface.
    #
    # @return [Cursor]
    def self.origin(cursor, interface)
      new(cursor, interface, (0 - cursor.y), (0 - cursor.x)).move
    end

    # Returns a newly positioned and stored Cursor.
    #
    # @return [Cursor]
    def move
      Cursor.new(cursor.attributes.merge!(moved_attributes)).store
    end

    private

    attr_reader :cursor, :dx, :dy, :interface

    # @return [Hash]
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

    # @return [Fixnum]
    def ox
      ox = cursor.ox + dx
      ox = 0 if ox < 0
      ox
    end

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

    # @return [Fixnum]
    def bordered_height
      return border.height if border?

      height
    end

    # @return [Fixnum]
    def bordered_width
      return border.width if border?

      width
    end

  end # MoveCursor

end # Vedeu
