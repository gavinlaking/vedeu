module Vedeu

  module Borders

    # When a {Vedeu::Borders::Border} has a title, truncate it if the
    # title is longer than the interface is wide, and pad with a space
    # either side.
    #
    # @api private
    #
    class Title

      # @param chars [Array<Vedeu::Views::Char>]
      # @param value [String|Vedeu::Borders::Title|
      #   Vedeu::Borders::Caption]
      # @return [Array<Vedeu::Views::Char>]
      def self.render(value = '', chars = [])
        new(value, chars).render
      end

      # Returns a new instance of Vedeu::Borders::Title or
      # Vedeu::Borders::Caption.
      #
      # @param chars [Array<Vedeu::Views::Char>]
      # @param value [String|Vedeu::Borders::Title|
      #   Vedeu::Borders::Caption]
      # @return [Vedeu::Borders::Title|Vedeu::Borders::Caption]
      def initialize(value = '', chars = [])
        @value = value
        @chars = chars
      end

      # An object is equal when its values are the same.
      #
      # @param other [Vedeu::Borders::Title]
      # @return [Boolean]
      def eql?(other)
        self.class == other.class && value == other.value
      end
      alias_method :==, :eql?

      # Overwrite the border from
      # {Vedeu::Borders::Border#build_horizontal} on the top border to
      # include the title if given.
      #
      # @return [Array<Vedeu::Views::Char>]
      def render
        return chars if empty?

        chars.each_with_index do |char, index|
          next if index == start_index || index > size

          char.border = nil
          char.value  = characters[index - 1]
        end
      end

      # Convert the value to a string.
      #
      # @return [String]
      def to_s
        value.to_s
      end
      alias_method :to_str, :to_s

      # Return the value (a title or a caption) or an empty string.
      #
      # @return [String]
      def value
        @value || ''
      end
      alias_method :title, :value
      alias_method :caption, :value

      protected

      # @!attribute [r] chars
      # @return [Array<Vedeu::Views::Char>] An array of border
      #   characters.
      attr_reader :chars

      private

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

      # Return the size of the padded, truncated value.
      #
      # @return [Fixnum]
      def size
        pad.size
      end

      # @return [Fixnum]
      def start_index
        0
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

      # Return the size of the horizontal border given via #chars.
      #
      # @return [Fixnum]
      def width
        chars.size
      end

    end # Title

  end # Borders

end # Vedeu
