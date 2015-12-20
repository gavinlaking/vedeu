module Vedeu

  module Colours

    # The class represents one half (the other, can be found at
    # {Vedeu::Colours::Foreground}) of a terminal colour escape
    # sequence.
    #
    # @api private
    #
    class Background < Vedeu::Colours::Translator

      # @return [Boolean]
      def background?
        present?(to_s)
      end

      private

      # @return [String]
      def prefix
        "\e[48;".freeze
      end

      # @return [String]
      def named_codes
        Vedeu::EscapeSequences::Esc.background_codes[colour]
      end

      # @return [Vedeu::Colours::Backgrounds]
      def repository
        Vedeu.background_colours
      end

    end # Background

  end # Colours

end # Vedeu
