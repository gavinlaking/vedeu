module Vedeu

  # Store background colour escape sequences by HTML/CSS code.
  #
  class Backgrounds < Colours

    # @return [Vedeu::Backgrounds]
    # @see Vedeu::Repository
    def self.background_colours
      @background_colours ||= new
    end

  end # Backgrounds

end # Vedeu
