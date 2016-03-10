# frozen_string_literal: true

module Vedeu

  module Presentation

    # Converts the colours and styles to escape sequences, and when
    # the parent model has previously set the colour and style,
    # reverts back to that for consistent formatting.
    #
    # @return [String] An escape sequence with value interpolated.
    def to_s
      render_position { render_colour { render_style { value } } }
    end
    alias to_str to_s

  end # Presentation

end # Vedeu
