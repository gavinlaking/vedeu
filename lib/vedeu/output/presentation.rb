module Vedeu

  # This module allows the sharing of presentation concerns between the models:
  # Interface, Line and Stream.
  #
  module Presentation

    # @return [Vedeu::Background]
    def background
      if colour
        colour.background

      else
        Vedeu::Background.new

      end
    end

    # @return [Vedeu::Colour]
    def colour
      @colour ||= Vedeu::Colour.coerce(_colour)
    end

    # @return [Vedeu::Colour]
    def colour=(value)
      @colour = Vedeu::Colour.coerce(value)
    end

    # @return [Vedeu::Foreground]
    def foreground
      if colour
        colour.foreground

      else
        Vedeu::Foreground.new

      end
    end

    # @return [Vedeu::Background]
    def parent_background
      if parent_colour
        parent_colour.background

      else
        Vedeu::Background.new

      end
    end

    # @return [String|NilClass]
    def parent_colour
      parent.colour if parent
    end

    # @return [Vedeu::Foreground]
    def parent_foreground
      if parent_colour
        parent_colour.foreground

      else
        Vedeu::Foreground.new

      end
    end

    # @return [String|NilClass]
    def parent_style
      parent.style if parent
    end

    # @return [Vedeu::Style]
    def style
      @style ||= Vedeu::Style.coerce(_style)
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
      render_position { render_colour { render_style { value } } }
    end

    private

    # @return [void]
    def _colour
      if attributes[:colour]
        attributes[:colour]

      elsif parent_colour
        parent_colour

      end
    end

    # Renders the colour attributes of the receiver and yields (to then render
    # the styles).
    #
    # @return [String]
    def render_colour
      [colour, yield].join
    end

    # @return [String]
    def render_position
      if self.respond_to?(:position) && position.is_a?(Vedeu::Position)
        position.to_s { yield }

      else
        yield

      end
    end

    # Renders the style attributes of the receiver and yields (to then render
    # the next model, or finally, the content).
    #
    # @return [String]
    def render_style
      [style, yield].join
    end

    # @return [void]
    def _style
      if attributes[:style]
        attributes[:style]

      elsif parent_style
        parent_style

      end
    end

  end # Presentation

end # Vedeu
