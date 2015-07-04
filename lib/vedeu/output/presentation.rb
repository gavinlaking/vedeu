module Vedeu

  # This module allows the sharing of presentation concerns between the models:
  # Interface, Line and Stream.
  #
  # @api private
  module Presentation

    # @return [Vedeu::Background]
    def background
      @background ||= if colour
                        colour.background

                      else
                        parent_background

                      end
    end

    # @return [Vedeu::Background]
    def background=(value)
      self.colour = Vedeu::Colour.coerce(
        background: Vedeu::Background.coerce(value),
        foreground: colour.foreground)
    end

    # @return [Vedeu::Colour]
    def colour
      @colour ||= if attributes[:colour]
                    Vedeu::Colour.coerce(attributes[:colour])

                  elsif parent_colour
                    Vedeu::Colour.coerce(parent_colour)

                  else
                    Vedeu::Colour.new

                  end
    end

    # @return [Vedeu::Colour]
    def colour=(value)
      @colour = attributes[:colour] = Vedeu::Colour.coerce(value)
    end

    # @return [Vedeu::Foreground]
    def foreground
      @foreground ||= if colour
                        colour.foreground

                      else
                        parent_foreground

                      end
    end

    # @return [Vedeu::Foreground]
    def foreground=(value)
      self.colour = Vedeu::Colour.coerce(
        foreground: Vedeu::Foreground.coerce(value),
        background: colour.background)
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
      if parent
        parent.style

      else
        Vedeu::Style.new

      end
    end

    # @return [Vedeu::Style]
    def style
      @style ||= if attributes[:style]
                   Vedeu::Style.coerce(attributes[:style])

                 elsif parent_style
                   Vedeu::Style.coerce(parent_style)

                 else
                   Vedeu::Style.new

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
    alias_method :to_str, :to_s

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

  end # Presentation

end # Vedeu
