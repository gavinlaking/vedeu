require 'vedeu/models/model'
require 'vedeu/support/esc'
require 'vedeu/support/terminal'

module Vedeu

  # Each interface has its own Cursor which maintains the position and
  # visibility of the cursor within that interface.
  #
  # @api private
  class Cursor

    include Vedeu::Model

    attr_reader :name, :state, :x, :y

    # Provides a new instance of Cursor.
    #
    # @param name  [String] The name of the interface this cursor belongs to.
    # @param state [Boolean|Symbol] The visibility of the cursor, either +true+
    #   or +false+, +:hide+ or +:show+.
    # @param x     [Fixnum] The terminal x coordinate for the cursor.
    # @param y     [Fixnum] The terminal y coordinate for the cursor.
    #
    # @return [Cursor]
    def initialize(name = '', state = false, x = 1, y = 1)
      @name    = name
      @state   = state
      @x       = x
      @y       = y
    end

    # Returns an escape sequence to position the cursor and set its visibility.
    # When passed a block, will position the cursor, yield and return the
    # original position.
    #
    # @param block [Proc]
    # @return [String]
    def to_s(&block)
      if block_given?
        [ sequence, yield, sequence ].join

      else
        sequence

      end
    end

    private

    # @return [Class] The repository class for this model.
    def repository
      Vedeu::Cursors
    end

    # Returns the escape sequence to position the cursor and set its visibility.
    #
    # @return [String]
    def sequence
      [ position, visibility ].join
    end

    # Returns the escape sequence for setting the position of the cursor.
    #
    # @return [String]
    def position
      @_position ||= Position.new(y, x).to_s
    end

    # Returns the escape sequence for setting the visibility of the cursor.
    #
    # @return [String]
    def visibility
      if visible.visible?
        Esc.string('show_cursor')

      else
        Esc.string('hide_cursor')

      end
    end

    def visible
      @visible ||= Visible.new(state)
    end

  end # Cursor

end # Vedeu
