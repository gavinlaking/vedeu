require 'vedeu/cursor/cursor'
require 'vedeu/support/terminal'

module Vedeu

  # Adjusts the position of the cursor.
  #
  class MoveCursor

    extend Forwardable

    def_delegators :@interface, :border,
                                :border?,
                                :content,
                                :content?,
                                :geometry

    def_delegators :border, :left?,
                            :right?,
                            :top?,
                            :bottom?

    def_delegators :geometry, :left,
                              :right,
                              :top,
                              :bottom,
                              :height,
                              :width,
                              :x,
                              :y

    # @param cursor    [Cursor]
    # @param interface [Interface]
    # @param dy        [Fixnum] Move up (-1), or down (1), or no action (0).
    # @param dx        [Fixnum] Move left (-1), or right (1), or no action (0).
    # @return [MoveCursor]
    def initialize(cursor, interface, dy, dx)
      @cursor    = cursor
      @dy        = dy
      @dx        = dx
      @interface = interface
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
      Cursor.new(cursor.attributes.merge({
        x:  coordinate.x_position(ox),
        y:  coordinate.y_position(oy),
        ox: ox,
        oy: oy,
      })).store
    end

    private

    attr_reader :cursor, :dx, :dy, :interface

    def ox
      cursor.ox + dx
    end

    def oy
      cursor.oy + dy
    end

    def coordinate
      @coordinate ||= Coordinate.new(oheight, owidth, oleft, otop)
    end

    def oheight
      return height unless border?

      if top? && bottom?
        height - 2

      elsif top? || bottom?
        height - 1

      else
        height

      end
    end

    def owidth
      return width unless border?

      if left? && right?
        width - 2

      elsif left? || right?
        width - 1

      else
        width

      end
    end

    def oleft
      return left unless border? && left?

      left + 1
    end

    def otop
      return top unless border? && top?

      top + 1
    end

  end # MoveCursor

end # Vedeu
