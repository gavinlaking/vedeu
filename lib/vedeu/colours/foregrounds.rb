module Vedeu

  module Colours

    # Store foreground colour escape sequences by HTML/CSS code.
    #
    class Foregrounds < Vedeu::Colours::Repository

      # @return [Vedeu::Colours::Foregrounds]
      # @see Vedeu::Repository
      def self.foreground_colours
        @foreground_colours ||= new
      end

    end # Foregrounds

  end # Colours

end # Vedeu
