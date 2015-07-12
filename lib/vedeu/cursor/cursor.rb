module Vedeu

  # Each interface has its own Cursor which maintains the position and
  # visibility of the cursor within that interface.
  #
  # @api private
  class Cursor

    include Vedeu::Model

    # @!attribute [r] attributes
    # @return [Hash]
    attr_reader :attributes

    # @!attribute [r] name
    # @return [String]
    attr_reader :name

    # @!attribute [rw] ox
    # @return [Fixnum]
    attr_accessor :ox

    # @!attribute [rw] oy
    # @return [Fixnum]
    attr_accessor :oy

    # @!attribute [r] state
    # @return [Boolean|Symbol]
    attr_reader :state

    # @!attribute [r] visible
    # @return [Boolean|Symbol]
    attr_reader :visible
    alias_method :visible?, :visible

    # @!attribute [rw] x
    # @return [Fixnum]
    attr_accessor :x

    # @!attribute [rw] y
    # @return [Fixnum]
    attr_accessor :y

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

      @attributes.each { |key, value| instance_variable_set("@#{key}", value) }

      @position   = Vedeu::Position[@y, @x]
    end

    # Override Ruby's Object#inspect method to provide a more helpful output.
    #
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
    alias_method :to_str, :to_s

    # @return [Vedeu::EscapeChar]
    def hide_cursor
      @hide_cursor ||= Vedeu::EscapeChar.new(Vedeu::Esc.hide_cursor)
    end

    # Return the position of this cursor.
    #
    # @return [Vedeu::Position]
    def position
      @position ||= Vedeu::Position[y, x]
    end

    # @return [Vedeu::EscapeChar]
    def show_cursor
      @show_cursor ||= Vedeu::EscapeChar.new(Vedeu::Esc.show_cursor)
    end

    # @param value [Boolean]
    # @return [void]
    def visible=(value)
      @visible = @attributes[:visible] = value
    end

    private

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
      return show_cursor if visible?

      hide_cursor
    end

  end # Cursor

end # Vedeu
