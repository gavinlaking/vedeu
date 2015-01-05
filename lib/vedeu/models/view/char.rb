require 'vedeu/presentation/presentation'

module Vedeu

  #
  # A Char represents a single character of the terminal. It is a container for
  # the a single character in a {Vedeu::Stream}.
  #
  # Though a multi-character String can be passed as a value, only the first
  # character is returned in the escape sequence.
  #
  # @api private
  #
  class Char

    include Vedeu::Presentation

    attr_accessor :parent
    attr_reader :position

    def self.coerce(value = nil, parent = nil, colour = nil, style = nil, position = nil)
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

    #
    # Returns a new instance of Char.
    #
    # @param  value    [String]
    # @param  parent   [Line]
    # @param  colour   [Colour]
    # @param  style    [Style]
    # @param  position [Position]
    # @return [Char]
    #
    def initialize(value = nil, parent = nil, colour = nil, style = nil, position = nil)
      @value    = value
      @parent   = parent
      @colour   = colour
      @style    = style
      @position = position
    end

    #
    # @return [String] The character.
    def value
      return '' unless @value

      @value[0]
    end

    private

  end # Char

end # Vedeu
