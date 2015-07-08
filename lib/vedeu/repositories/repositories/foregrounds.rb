module Vedeu

  # Store foreground colour escape sequences by HTML/CSS code.
  #
  # @api public
  class Foregrounds < Colours

    # @return [Vedeu::Foregrounds]
    # @see Vedeu::Repository
    def self.foreground_colours
      @foreground_colours ||= new
    end

  end # Foregrounds

end # Vedeu
