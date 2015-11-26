module Vedeu

  module Colours

    # The class represents one half (the other, can be found at
    # {Vedeu::Colours::Background}) of a terminal colour escape
    # sequence.
    #
    # @api private
    #
    class Foreground < Vedeu::Colours::Translator

      private

      # @return [String]
      def prefix
        "\e[38;".freeze
      end

      # @return [String]
      def named_codes
        Vedeu::EscapeSequences::Esc.foreground_codes[colour]
      end

      # @return [Vedeu::Colours::Foregrounds]
      def repository
        Vedeu.foreground_colours
      end

    end # Foreground

  end # Colours

end # Vedeu
