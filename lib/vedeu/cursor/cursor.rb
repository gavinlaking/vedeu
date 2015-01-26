require 'vedeu/models/model'
require 'vedeu/support/esc'
require 'vedeu/support/position'
require 'vedeu/support/visible'

module Vedeu

  # Each interface has its own Cursor which maintains the position and
  # visibility of the cursor within that interface.
  #
  # @api private
  class Cursor

    include Vedeu::Model

    attr_reader :name, :state, :x, :y, :repository

    # Provides a new instance of Cursor.
    #
    # @param name  [String] The name of the interface this cursor belongs to.
    # @param state [Boolean|Symbol] The visibility of the cursor, either +true+
    #   or +false+, +:hide+ or +:show+.
    # @param x     [Fixnum] The terminal x coordinate for the cursor.
    # @param y     [Fixnum] The terminal y coordinate for the cursor.
    #
    # @return [Cursor]
    def initialize(name = '', state = false, x = 1, y = 1, repository = nil)
      @name       = name
      @state      = state
      @x          = x
      @y          = y
      @repository = repository || Vedeu.cursors
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
      Position.new(y, x).to_s
    end

    # Returns the escape sequence for setting the visibility of the cursor.
    #
    # @return [String]
    def visibility
      Visible.new(state).cursor
    end

  end # Cursor

end # Vedeu
