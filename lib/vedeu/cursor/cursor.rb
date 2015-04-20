module Vedeu

  # Each interface has its own Cursor which maintains the position and
  # visibility of the cursor within that interface.
  class Cursor

    extend Forwardable
    include Vedeu::Model

    def_delegators Vedeu::Esc, :hide_cursor, :show_cursor

    # @!attribute [r] attributes
    # @return [Hash]
    attr_reader :attributes

    # @!attribute [r] name
    # @return [String]
    attr_reader :name

    # @!attribute [r] ox
    # @return [Fixnum]
    attr_reader :ox

    # @!attribute [r] oy
    # @return [Fixnum]
    attr_reader :oy

    # @!attribute [r] state
    # @return [Boolean|Symbol]
    attr_reader :state

    # @!attribute [r] visible
    # @return [Boolean|Symbol]
    attr_reader :visible
    alias_method :visible?, :visible

    # @!attribute [r] x
    # @return [Fixnum]
    attr_reader :x

    # @!attribute [r] y
    # @return [Fixnum]
    attr_reader :y

    # Returns a new instance of Vedeu::Cursor.
    #
    # @param attributes [Hash]
    # @option attributes name [String] The name of the interface this cursor
    #   belongs to.
    # @option attributes ox [Fixnum] The offset x coordinate.
    # @option attributes oy [Fixnum] The offset y coordinate.
    # @option attributes repository [Vedeu::Repository]
    # @option attributes visible [Boolean] The visibility of the cursor.
    # @option attributes x [Fixnum] The terminal x coordinate for the cursor.
    # @option attributes y [Fixnum] The terminal y coordinate for the cursor.
    #
    # @return [Cursor]
    def initialize(attributes = {})
      # Hack because Repository#by_name creates Cursor objects with just a
      # name.
      attributes = { name: attributes } if attributes.is_a?(String)

      @attributes = defaults.merge!(attributes)

      @name       = @attributes.fetch(:name)
      @ox         = @attributes.fetch(:ox)
      @oy         = @attributes.fetch(:oy)
      @repository = @attributes.fetch(:repository)
      @visible    = @attributes.fetch(:visible)
      @x          = @attributes.fetch(:x)
      @y          = @attributes.fetch(:y)

      @position   = Vedeu::Position.new(@y, @x)
    end

    # @return [String]
    def inspect
      "<Vedeu::Cursor (#{name}, " \
      "#{visible}, "              \
      "x:#{x}, "                  \
      "y:#{y}, "                  \
      "ox:#{ox}, "                \
      "oy:#{oy})>"
    end

    # Returns an escape sequence to position the cursor and set its visibility.
    # When passed a block, will position the cursor, yield and return the
    # original position.
    #
    # @return [String]
    def to_s
      if block_given?
        [sequence, yield, sequence].join

      else
        sequence

      end
    end

    private

    # @return [Vedeu::Position]
    def position
      @position ||= Vedeu::Position.new(y, x)
    end

    # The default values for a new instance of this class.
    #
    # @return [Hash]
    def defaults
      {
        name:       '',
        ox:         0,
        oy:         0,
        repository: Vedeu.cursors,
        visible:    false,
        x:          1,
        y:          1,
      }
    end

    # Returns the escape sequence to position the cursor and set its visibility.
    #
    # @return [String]
    def sequence
      [position, visibility].join
    end

    # Returns the escape sequence for setting the visibility of the cursor.
    #
    # @return [String]
    def visibility
      if visible?
        show_cursor

      else
        hide_cursor

      end
    end

  end # Cursor

end # Vedeu
