module Vedeu

  module Borders

    class Title

      def self.coerce(value = '', width = Vedeu.width)
        if value.is_a?(self)
          value

        else
          new(value, width)

        end
      end

      def initialize(value = '', width = Vedeu.width)
        @value = value
        @width = width
      end

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

      # @return [Fixnum]
      def size
        pad.size
      end

      # @return [String]
      def to_s
        value.to_s
      end

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

      # @return [Fixnum]
      def width
        @width || Vedeu.width
      end

    end # Title

    class Caption < Title

    end # Caption

  end # Borders

end # Vedeu
