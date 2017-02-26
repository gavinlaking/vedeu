# frozen_string_literal: true

module Vedeu

  module Borders

    # When a {Vedeu::Borders::Border} has a title, truncate it if the
    # title is longer than the interface is wide, and pad with a space
    # either side.
    #
    # The title is displayed within the top border of the interface/
    # view.
    #
    # @api private
    #
    class Title

      # @param (see #initialize)
      # @return (see #render)
      def self.render(name, value = '', horizontal = [])
        new(name, value, horizontal).render
      end

      # Returns a new instance of Vedeu::Borders::Title or
      # Vedeu::Borders::Caption.
      #
      # @macro param_name
      # @param value [String|Vedeu::Borders::Title|
      # @param horizontal [Array<Vedeu::Cells::Horizontal>]
      #   Vedeu::Borders::Caption]
      # @return [Vedeu::Borders::Title|Vedeu::Borders::Caption]
      def initialize(name, value = '', horizontal = [])
        @name       = name
        @value      = value
        @horizontal = horizontal
      end

      # An object is equal when its values are the same.
      #
      # @param other [Vedeu::Borders::Title|Vedeu::Borders::Caption]
      # @return [Boolean]
      def eql?(other)
        self.class.equal?(other.class) && value == other.value
      end
      alias == eql?

      # Overwrite the border from
      # {Vedeu::Borders::Border#build_horizontal} on the top border to
      # include the title if given.
      #
      # @return [Array<Vedeu::Cells::Horizontal|Vedeu::Cells::Char>]
      def render
        return horizontal if empty?

        horizontal[start_index..end_index] = chars

        horizontal
      end

      # Convert the value to a string.
      #
      # @return [String]
      def to_s
        value.to_s
      end
      alias to_str to_s

      # Return the value (a title or a caption) or an empty string.
      #
      # @return [String]
      def value
        @value || ''
      end
      alias title value
      alias caption value

      protected

      # @!attribute [r] horizontal
      # @return [Array<Vedeu::Cells::Horizontal>] An array of border
      #   characters.
      attr_reader :horizontal

      # @!attribute [r] name
      # @macro return_name
      attr_reader :name

      private

      # @param char [String]
      # @param x [Integer]
      # @return [Hash<Symbol => void>]
      def attributes(char, x)
        border.attributes.merge(position: Vedeu::Geometries::Position.new(y, x),
                                value:    char)
      end

      # @macro border_by_name
      def border
        @_border ||= Vedeu.borders.by_name(name)
      end

      # @return [Array<Vedeu::Cells::Horizontal|Vedeu::Cells::Char>]
      def chars
        characters.each_with_index.map do |char, index|
          Vedeu::Cells::Char.new(attributes(char, x + index))
        end
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

      # @return [Integer]
      def end_index
        start_index + (size - 1)
      end

      # @macro geometry_by_name
      def geometry
        @_geometry ||= Vedeu.geometries.by_name(name)
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
      # @return [Integer]
      def size
        pad.size
      end

      # Provides the index on the horizontal border for where the
      # title (or caption) should start. The title will appear
      # top-left, whilst the caption will be justified bottom-right.
      #
      # @return [Integer]
      def start_index
        1
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
        value.chomp.slice(0...(width - 4))
      end

      # Return the size of the horizontal border given.
      #
      # @return [Integer]
      def width
        horizontal.size
      end

      # @return [Integer]
      def x
        geometry.bx + start_index
      end

      # Return the vertical position for the title (or caption).
      #
      # @return [Integer]
      def y
        geometry.y
      end

    end # Title

  end # Borders

end # Vedeu
