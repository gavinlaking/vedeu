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

    extend Forwardable

    def_delegators :state, :visible?, :invisible?

    include Vedeu::Model

    attr_reader :attributes, :name, :ox, :oy, :repository, :state, :x, :y

    # Provides a new instance of Cursor.
    #
    # @param name  [String] The name of the interface this cursor belongs to.
    # @param state [Boolean|Symbol] The visibility of the cursor, either +true+
    #   or +false+, +:hide+ or +:show+.
    # @param x     [Fixnum] The terminal x coordinate for the cursor.
    # @param y     [Fixnum] The terminal y coordinate for the cursor.
    #
    # @return [Cursor]
    def initialize(attributes = {})
      # Hack because Repository#by_name creates Cursor objects with just a
      # name.
      if attributes.is_a?(String)
        attributes = { name: attributes }
      end

      @attributes = default_attributes.merge(attributes)

      @name       = @attributes.fetch(:name)
      @ox         = @attributes.fetch(:ox)
      @oy         = @attributes.fetch(:oy)
      @repository = @attributes.fetch(:repository)
      @state      = Vedeu::Visible.coerce(@attributes.fetch(:state))
      @x          = @attributes.fetch(:x)
      @y          = @attributes.fetch(:y)
    end

    def inspect
      "<#{self.class.name} (#{@name}: x:#{@x} y:#{@y} ox:#{@ox} oy:#{@oy})>"
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

    def default_attributes
      {
        name:       '',
        ox:         0,
        oy:         0,
        repository: Vedeu.cursors,
        state:      Vedeu::Visible.new(false),
        x:          1,
        y:          1,
      }
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
      Vedeu::Position.new(y, x).to_s
    end

    # Returns the escape sequence for setting the visibility of the cursor.
    #
    # @return [String]
    def visibility
      state.cursor
    end

  end # Cursor

end # Vedeu
