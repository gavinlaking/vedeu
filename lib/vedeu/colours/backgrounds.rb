module Vedeu

  module Colours

    # Store background colour escape sequences by HTML/CSS code.
    #
    class Backgrounds < Vedeu::Colours::Repository

      # @return [Vedeu::Colours::Backgrounds]
      # @see Vedeu::Repositories::Repository
      def self.background_colours
        @background_colours ||= new
      end

    end # Backgrounds

  end # Colours

end # Vedeu
