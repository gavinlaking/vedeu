module Vedeu

  module Colours

    # Store background colour escape sequences by HTML/CSS code.
    #
    class Backgrounds < Vedeu::Colours::Repository

      # Manipulate the repository of background colours.
      #
      # @example
      #   Vedeu.background_colours
      #
      # @return [Vedeu::Colours::Backgrounds]
      # @see Vedeu::Repositories::Repository
      def self.background_colours
        @background_colours ||= new
      end

    end # Backgrounds

  end # Colours

  # @!method background_colours
  # @return [Vedeu::Colours::Backgrounds]
  def_delegators Vedeu::Colours::Backgrounds,
                 :background_colours

end # Vedeu
