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
    def initialize(value, parent, colour, style, position)
      @value    = value
      @parent   = parent
      @colour   = colour
      @style    = style
      @position = position
    end

    #
    # @return [String] An escape sequence with value interpolated.
    #
    def to_s
      render_position { render_colour { render_style { value } } }
    end

    private

    attr_reader :parent, :position

    def colour
      return '' unless @colour

      @colour
    end

    def style
      return '' unless @style

      @style
    end

    def value
      @value.nil? ? '' : @value[0]
    end

    def parent_colour
      return '' unless parent

      parent.colour
    end

    def parent_style
      return '' unless parent

      parent.style
    end

    def render_colour
      [
        colour,
        yield,
        parent_colour
      ].join
    end

    def render_position
      if position
        position.to_s { yield }

      else
        yield

      end
    end

    def render_style
      [
        style,
        yield,
        parent_style
      ].join
    end

  end # Char

end # Vedeu
