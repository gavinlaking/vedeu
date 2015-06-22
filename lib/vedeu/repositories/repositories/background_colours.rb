module Vedeu

  # Store background colour escape sequences by HTML/CSS code.
  #
  # @api public
  class BackgroundColours < Colours

    # @return [Vedeu::BackgroundColours]
    def self.background_colours
      @background_colours ||= new
    end

  end # BackgroundColours

end # Vedeu
