module Vedeu

  # This module allows the sharing of presentation concerns between the models:
  # Interface, Line and Stream.
  #
  # @api private
  module Presentation

    # @return [Vedeu::Colour]
    def colour
      Colour.coerce(@colour)
    end

    # @return [Vedeu::Colour]
    def colour=(value)
      @colour = Colour.coerce(value)
    end

    # @return [Vedeu::Style]
    def style
      Style.coerce(@style)
    end

    # @return [Vedeu::Style]
    def style=(value)
      @style = Style.coerce(value)
    end

    # Converts the colours and styles to escape sequences, and if the parent
    # model has previously set the colour and style, reverts back to that for
    # consistent formatting.
    #
    # @return [String] An escape sequence with value interpolated.
    def to_s
      render_position { render_colour { render_style { value } } }
    end

    private

    def parent_colour
      return '' unless parent

      parent.colour
    end

    def parent_style
      return '' unless parent

      parent.style
    end

    # Renders the colour attributes of the receiver, yields (to then render the
    # the styles) and once returned, attempts to set the colours back to the
    # those of the receiver's parent.
    #
    # @return [String]
    def render_colour
      [
        colour,
        yield,
        parent_colour
      ].join
    end

    # @return [String]
    def render_position
      if self.respond_to?(:position) && position.is_a?(Position)
        position.to_s { yield }

      else
        yield

      end
    end

    # Renders the style attributes of the receiver, yields (to then render the
    # next model, or finally, the content) and once returned, attempts to set
    # the style back to that of the receiver's parent.
    #
    # @return [String]
    def render_style
      [
        style,
        yield,
        parent_style
      ].join
    end

  end # Presentation

end # Vedeu
