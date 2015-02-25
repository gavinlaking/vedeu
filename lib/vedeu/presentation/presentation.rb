module Vedeu

  # This module allows the sharing of presentation concerns between the models:
  # Interface, Line and Stream.
  #
  # @api private
  #
  module Presentation

    # @return [Vedeu::Background|NilClass]
    def background
      if colour
        colour.background
      end
    end

    # @return [Vedeu::Foreground|NilClass]
    def foreground
      if colour
        colour.foreground
      end
    end

    # @return [Vedeu::Background|NilClass]
    def parent_background
      if parent_colour
        parent_colour.background
      end
    end

    # @return [Vedeu::Foreground|NilClass]
    def parent_foreground
      if parent_colour
        parent_colour.foreground
      end
    end

    # @return [Vedeu::Colour]
    def colour
      Vedeu::Colour.coerce(@colour)
    end

    # @return [Vedeu::Colour]
    def colour=(value)
      @colour = Vedeu::Colour.coerce(value)
    end

    # @return [Vedeu::Style]
    def style
      Vedeu::Style.coerce(@style)
    end

    # @return [Vedeu::Style]
    def style=(value)
      @style = Vedeu::Style.coerce(value)
    end

    # Converts the colours and styles to escape sequences, and if the parent
    # model has previously set the colour and style, reverts back to that for
    # consistent formatting.
    #
    # @return [String] An escape sequence with value interpolated.
    def to_s
      render_position { render_colour { render_style { render_border { value } } } }
    end

    private

    # @return [String|NilClass]
    def parent_colour
      parent.colour if parent
    end

    # @return [String|NilClass]
    def parent_style
      parent.style if parent
    end

    # @return [String]
    def render_border
      if self.respond_to?(:border) && !border.nil?
        Esc.border { yield }

      else
        yield

      end
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
