module Vedeu

  # Store foreground colour escape sequences by HTML/CSS code.
  #
  # @api public
  class Foregrounds < Colours

    # @example
    #   Vedeu.foreground_colours
    #
    # @return [Vedeu::Foregrounds]
    def self.foreground_colours
      @foreground_colours ||= new
    end

  end # Foregrounds

end # Vedeu
