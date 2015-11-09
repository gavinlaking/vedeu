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
      def named_codes
        Vedeu::EscapeSequences::Esc.foreground_codes[colour]
      end

      # @return [String]
      def numbered_prefix
        "\e[38;5;".freeze
      end

      # @return [Vedeu::Colours::Foregrounds]
      def repository
        Vedeu.foreground_colours
      end

      # @return [String]
      def rgb_prefix
        "\e[38;2;%s;%s;%sm".freeze
      end

    end # Foreground

  end # Colours

end # Vedeu
