module Vedeu

  module Colours

    # The class represents one half (the other, can be found at
    # {Vedeu::Colours::Foreground}) of a terminal colour escape
    # sequence.
    #
    # @api private
    #
    class Background < Vedeu::Colours::Translator

      private

      # @return [String]
      def named_codes
        Vedeu::EscapeSequences::Esc.background_codes[colour]
      end

      # @return [String]
      def numbered_prefix
        "\e[48;5;".freeze
      end

      # @return [Vedeu::Colours::Backgrounds]
      def repository
        Vedeu.background_colours
      end

      # @return [String]
      def rgb_prefix
        "\e[48;2;%s;%s;%sm".freeze
      end

    end # Background

  end # Colours

end # Vedeu
