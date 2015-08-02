module Vedeu

  module Views

    # A Char represents a single character of the terminal. It is a container
    # for the a single character in a {Vedeu::Views::Stream}.
    #
    # Though a multi-character String can be passed as a value, only the first
    # character is returned in the escape sequence.
    #
    class Char

      include Comparable
      include Vedeu::Presentation

      # @!attribute [rw] border
      # @return [NilClass|Symbol]
      attr_accessor :border

      # @!attribute [rw] parent
      # @return [Vedeu::Views::Line]
      attr_accessor :parent

      # @!attribute [r] attributes
      # @return [Hash]
      attr_reader :attributes

      # @!attribute [r] position
      # @return [Vedeu::Position]
      attr_reader :position

      # @!attribute [w] value
      # @return [String]
      attr_writer :value

      # Returns a new instance of Vedeu::Views::Char.
      #
      # @param attributes [Hash]
      # @option attributes value    [String]
      # @option attributes parent   [Vedeu::Views::Line]
      # @option attributes colour   [Vedeu::Colour]
      # @option attributes style    [Vedeu::Style]
      # @option attributes position [Vedeu::Position]
      # @option attributes border   [NilClass|Symbol] A symbol representing the
      #   border 'piece' this Vedeu::Views::Char represents.
      # @return [Vedeu::Views::Char]
      def initialize(attributes = {})
        @attributes = attributes
        @border     = @attributes[:border]
        @parent     = @attributes[:parent]
        @value      = @attributes[:value]
      end

      # When {Vedeu::Viewport#padded_lines} has less lines that required to fill
      # the visible area of the interface, it creates a line that contains a
      # single {Vedeu::Views::Char} containing a space (0x20); later,
      # {Vedeu::Viewport#padded_columns} will attempts to call `#chars` on an
      # expected {Vedeu::Views::Line} and fail; this method fixes that.
      #
      # @return [Array]
      def chars
        []
      end

      # An object is equal when its values are the same.
      #
      # @param other [Vedeu::Views::Char]
      # @return [Boolean]
      def eql?(other)
        self.class == other.class && value == other.value &&
          position == other.position
      end
      alias_method :==, :eql?

      # Override Ruby's Object#inspect method to provide a more helpful output.
      #
      # @return [String]
      def inspect
        "<Vedeu::Views::Char '#{Vedeu::Esc.escape(to_s)}'>"
      end

      # @return [Vedeu::Position]
      def position
        @position = Vedeu::Position.coerce(@attributes[:position])
      end

      # Sets the position of the Vedeu::Views::Char.
      #
      # @param value [Vedeu::Position]
      # @return [Vedeu::Position]
      def position=(value)
        @position = @attributes[:position] = Vedeu::Position.coerce(value)
      end

      # @return [String]
      def value
        if border
          Vedeu::Esc.border { @value }

        else
          @value

        end
      end

      # Returns the x position for the Vedeu::Views::Char when set.
      #
      # @return [Fixnum|NilClass]
      def x
        position.x if position
      end

      # Returns the y position for the Vedeu::Views::Char when set.
      #
      # @return [Fixnum|NilClass]
      def y
        position.y if position
      end

      # Returns a Hash of all the values before coercion.
      #
      # @note
      #   From this hash we should be able to construct a new instance of
      #   Vedeu::Views::Char, however, at the moment, `:parent` cannot be
      #   coerced.
      #
      # @return [Hash]
      def to_hash
        {
          border:   border.to_s,
          colour:   colour_to_hash,
          parent:   parent_to_hash,
          position: position_to_hash,
          style:    style.to_s,
          value:    value,
        }
      end

      # @return [String]
      def to_html
        @to_html ||= Vedeu::HTMLChar.render(self)
      end

      private

      # @return [Hash]
      def colour_to_hash
        {
          background: background.to_s,
          foreground: foreground.to_s,
        }
      end

      # @return [Hash]
      def parent_to_hash
        {
          background: parent_background.to_s,
          foreground: parent_foreground.to_s,
          style:      parent_style.to_s,
        }
      end

      # @return [Hash]
      def position_to_hash
        {
          y: y,
          x: x,
        }
      end

    end # Char

  end # Views

end # Vedeu
