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
    end

    def value
      return '' unless @value

      @value[0]
    end


  end # Char

end # Vedeu
