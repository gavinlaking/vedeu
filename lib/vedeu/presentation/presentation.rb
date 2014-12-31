module Vedeu

  # This module allows the sharing of presentation concerns between the models:
  # Interface, Line and Stream.
  #
  # @api private
  module Presentation

    # Converts the colours and styles to escape sequences, and if the parent
    # model has previously set the colour and style, reverts back to that for
    # consistent formatting.
    #
    # @return [String]
    def to_s
      render_colour do
        render_style do
          data
        end
      end
    end

    private

    # Renders the colour attributes of the receiver, yields (to then render the
    # the styles) and once returned, attempts to set the colours back to the
    # those of the receiver's parent.
    #
    # @return [String]
    def render_colour(&block)
      [ colour.to_s, yield, parent.colour.to_s ].join
    end

    # Renders the style attributes of the receiver, yields (to then render the
    # next model, or finally, the content) and once returned, attempts to set
    # the style back to that of the receiver's parent.
    #
    # @return [String]
    def render_style(&block)
      [ style.to_s, yield, parent.style.to_s ].join
    end

  end # Presentation

end # Vedeu
