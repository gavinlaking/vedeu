module Vedeu

  # Store foreground colour escape sequences by HTML/CSS code.
  #
  # @api public
  class ForegroundColours < Colours

    # @example
    #   Vedeu.foreground_colours
    #
    # @return [Vedeu::ForegroundColours]
    def self.foreground_colours
      @foreground_colours ||= new
    end

  end # ForegroundColours

end # Vedeu
