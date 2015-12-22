module Vedeu

  module Colours

    # The class represents one half (the other, can be found at
    # {Vedeu::Colours::Background}) of a terminal colour escape
    # sequence.
    #
    # @api private
    #
    class Foreground < Vedeu::Colours::Translator

      # @return [Boolean]
      def foreground?
        present?(to_s)
      end

      private

      # @return [String]
      def prefix
        "\e[38;".freeze
      end

      # Returns an escape sequence for a named colour.
      #
      # @note
      #   Valid names can be found at
      #   {Vedeu::EscapeSequences::Esc#valid_codes}
      #
      # @return [String]
      def named_code
        Vedeu::EscapeSequences::Esc.foreground_colour(colour)
      end

      # @return [Vedeu::Colours::Foregrounds]
      def repository
        Vedeu.foreground_colours
      end

    end # Foreground

  end # Colours

end # Vedeu
