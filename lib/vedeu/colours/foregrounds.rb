module Vedeu

  module Colours

    # Store foreground colour escape sequences by HTML/CSS code.
    #
    class Foregrounds < Vedeu::Colours::Repository

      # Manipulate the repository of foreground colours.
      #
      # @example
      #   Vedeu.foreground_colours
      #
      # @return [Vedeu::Colours::Foregrounds]
      # @see Vedeu::Repositories::Repository
      def self.foreground_colours
        @foreground_colours ||= new
      end

    end # Foregrounds

  end # Colours

  # @!method foreground_colours
  # @return [Vedeu::Colours::Foregrounds]
  def_delegators Vedeu::Colours::Foregrounds, :foreground_colours

end # Vedeu
