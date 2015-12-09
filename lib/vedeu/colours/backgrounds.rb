module Vedeu

  module Colours

    # Store background colour escape sequences by HTML/CSS code.
    #
    class Backgrounds < Vedeu::Colours::Repository

      # {include:file:docs/dsl/by_method/background_colours.md}
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
