require 'vedeu/geometries/positionable'

module Vedeu

  module Presentation

    include Vedeu::Geometries::Positionable
    include Vedeu::Presentation::Colour
    include Vedeu::Presentation::Styles

    # Converts the colours and styles to escape sequences, and when
    # the parent model has previously set the colour and style,
    # reverts back to that for consistent formatting.
    #
    # @return [String] An escape sequence with value interpolated.
    def to_s
      render_position { render_colour { render_style { value } } }
    end
    alias_method :to_str, :to_s

    private

    # Renders the colour attributes of the receiver and yields (to
    # then render the styles).
    #
    # @return [String]
    def render_colour
      "#{colour}#{yield}".freeze
    end

    # @return [String]
    def render_position
      return position.to_s { yield } if position?

      yield
    end

    # Renders the style attributes of the receiver and yields (to
    # then render the next model, or finally, the content).
    #
    # @return [String]
    def render_style
      "#{style}#{yield}".freeze
    end

  end # Presentation

end # Vedeu
