module Vedeu

  module Borders

    # When a {Vedeu::Borders::Border} has a title, truncate it if the
    # title is longer than the interface is wide, and pad with a space
    # either side.
    #
    class Title

      # @param value [String|Vedeu::Borders::Title|
      #   Vedeu::Borders::Caption]
      # @param width [Fixnum]
      # @return [Vedeu::Borders::Title|Vedeu::Borders::Caption]
      def self.coerce(value = '', width = Vedeu.width)
        if value.is_a?(self)
          value

        else
          new(value, width)

        end
      end

      # Returns a new instance of Vedeu::Borders::Title or
      # Vedeu::Borders::Caption.
      #
      # @param value [String|Vedeu::Borders::Title|
      #   Vedeu::Borders::Caption]
      # @param width [Fixnum]
      # @return [Vedeu::Borders::Title|Vedeu::Borders::Caption]
      def initialize(value = '', width = Vedeu.width)
        @value = value
        @width = width
      end

      # Return the padded, truncated value as an Array of String.
      #
      # @return [Array<String>]
      def characters
        pad.chars
      end

      # Return boolean indicating whether the value is empty.
      #
      # @return [Boolean]
      def empty?
        value.empty?
      end

      # An object is equal when its values are the same.
      #
      # @param other [Vedeu::Borders::Title]
      # @return [Boolean]
      def eql?(other)
        self.class == other.class && value == other.value
      end
      alias_method :==, :eql?

      # Return the size of the padded, truncated value.
      #
      # @return [Fixnum]
      def size
        pad.size
      end

      # Convert the value to a string.
      #
      # @return [String]
      def to_s
        value.to_s
      end

      # Return the value or an empty string.
      #
      # @return [String]
      def value
        @value || ''
      end
      alias_method :title, :value
      alias_method :caption, :value

      private

      # Pads the value with a single whitespace either side.
      #
      # @example
      #   value = 'Truncated!'
      #   width = 20
      #   # => ' Truncated! '
      #
      #   width = 10
      #   # => ' Trunca '
      #
      # @return [String]
      # @see #truncate
      def pad
        truncate.center(truncate.size + 2)
      end

      # Truncates the value to the width of the interface, minus
      # characters needed to ensure there is at least a single
      # character of horizontal border and a whitespace on either side
      # of the value.
      #
      # @example
      #   value = 'Truncated!'
      #   width = 20
      #   # => 'Truncated!'
      #
      #   width = 10
      #   # => 'Trunca'
      #
      # @return [String]
      def truncate
        title.chomp.slice(0...(width - 4))
      end

      # Return the given width or the width of the terminal.
      #
      # @return [Fixnum]
      def width
        @width || Vedeu.width
      end

    end # Title

    # When a {Vedeu::Borders::Border} has a caption, truncate it if
    # the caption is longer than the interface is wide, and pad with a
    # space either side.
    #
    class Caption < Title

    end # Caption

  end # Borders

end # Vedeu
