module Vedeu

  # Store background colour escape sequences by HTML/CSS code.
  #
  # @api public
  class Backgrounds < Colours

    # @example
    #   Vedeu.background_colours
    #
    # @return [Vedeu::Backgrounds]
    def self.background_colours
      @background_colours ||= new
    end

  end # Backgrounds

end # Vedeu
