module Vedeu

  # Store foreground colour escape sequences by HTML/CSS code.
  #
  class ForegroundColours < Colours

    # @return [Vedeu::ForegroundColours]
    def self.foreground_colours
      @foreground_colours ||= new
    end

  end # ForegroundColours

end # Vedeu
