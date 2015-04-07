module Vedeu

  # This module allows the sharing of presentation concerns between the models:
  # Interface, Line and Stream.
  #
  module Presentation

    # @return [Vedeu::Background|NilClass]
    def background
      colour.background if colour
    end

    # @return [Vedeu::Colour]
    def colour
      if @colour
        @colour ||= Vedeu::Colour.coerce(@colour)

      elsif parent && parent.colour
        @colour ||= Vedeu::Colour.coerce(parent.colour)

      else
        Vedeu::Colour.coerce(nil)

      end
    end

    # @return [Vedeu::Colour]
    def colour=(value)
      @colour = Vedeu::Colour.coerce(value)
    end

    # @return [Vedeu::Foreground|NilClass]
    def foreground
      colour.foreground if colour
    end

    # @return [Vedeu::Background|NilClass]
    def parent_background
      parent_colour.background if parent_colour
    end

    # @return [String|NilClass]
    def parent_colour
      parent.colour if parent
    end

    # @return [Vedeu::Foreground|NilClass]
    def parent_foreground
      parent_colour.foreground if parent_colour
    end

    # @return [String|NilClass]
    def parent_style
      parent.style if parent
    end

    # @return [Vedeu::Style]
    def style
      if @style
        @style ||= Vedeu::Style.coerce(@style)

      elsif parent && parent.style
        @style ||= Vedeu::Style.coerce(parent.style)

      else
        Vedeu::Style.coerce(nil)

      end
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

    # Renders the colour attributes of the receiver and yields (to then render
    # the styles).
    #
    # @return [String]
    def render_colour
      [colour, yield].join
    end

    # @return [String]
    def render_position
      if self.respond_to?(:position) && self.position.is_a?(Vedeu::Position)
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

  end # Presentation

end # Vedeu
