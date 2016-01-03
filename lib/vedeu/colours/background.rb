# frozen_string_literal: true

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

      # @return [Hash<Symbol => String>]
      def to_h
        {
          background: colour.to_s
        }
      end
      alias_method :to_hash, :to_h

      # @param _options [Hash] Ignored.
      # @return [String]
      def to_html(_options = {})
        if rgb?
          "background-color:#{colour};"

        else
          ''

        end
      end

      private

      # @return [String]
      def prefix
        "\e[48;"
      end

      # Returns an escape sequence for a named colour.
      #
      # @note
      #   Valid names can be found at
      #   {Vedeu::EscapeSequences::Esc#valid_codes}
      #
      # @return [String]
      def named_code
        Vedeu.esc.background_colour(colour)
      end

      # @return [Vedeu::Colours::Backgrounds]
      def repository
        Vedeu.background_colours
      end

    end # Background

  end # Colours

end # Vedeu
