require 'vedeu/presentation/presentation'

module Vedeu

  # A Char represents a single character of the terminal. It is a container for
  # the a single character in a {Vedeu::Stream}.
  #
  # Though a multi-character String can be passed as a value, only the first
  # character is returned in the escape sequence.
  #
  # @api private
  class Char

    include Vedeu::Presentation

    attr_accessor :parent
    attr_reader :position

    class << self
      def coerce(value = nil, parent = nil, colour = nil, style = nil, position = nil)
        if value.is_a?(self)
          value

        elsif value.is_a?(Array)
          if value.first.is_a?(self)
            value

          elsif value.first.is_a?(String)
            value.map { |char| new(char, parent, colour, style, position) }

          else
            # ...

          end
        else
          # ...

        end
      end
    end

    # Returns a new instance of Char.
    #
    # @param  value    [String]
    # @param  parent   [Line]
    # @param  colour   [Colour]
    # @param  style    [Style]
    # @param  position [Position]
    # @return [Char]
    def initialize(value = nil, parent = nil, colour = nil, style = nil, position = nil)
      @value    = value
      @parent   = parent
      @colour   = colour
      @style    = style
      @position = position
    end

    # @return [Boolean]
    def ==(other)
      eql?(other)
    end

    # @return [Boolean]
    def eql?(other)
      self.class == other.class && value == other.value
    end

    # @return [String] The character.
    def value
      return '' unless @value

      @value[0]
    end

  end # Char

end # Vedeu
