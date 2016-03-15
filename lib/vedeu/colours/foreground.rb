# frozen_string_literal: true

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

      # @return [String]
      def to_ast
        return ''    unless foreground?
        return ':fg' unless rgb?

        ":fg_#{colour.to_s.slice(1..-1)}"
      end

      # @return [Hash<Symbol => String>]
      def to_h
        {
          foreground: colour.to_s,
        }
      end
      alias to_hash to_h

      # @param _options [Hash] Ignored.
      # @return [String]
      def to_html(_options = {})
        return '' unless rgb?

        "color:#{colour};"
      end

      private

      # @return [String]
      def prefix
        "\e[38;"
      end

      # Returns an escape sequence for a named colour.
      #
      # @note
      #   Valid names can be found at
      #   {Vedeu::EscapeSequences::Esc#valid_codes}
      #
      # @return [String]
      def named
        Vedeu.esc.foreground_colour(colour)
      end

      # @return [Vedeu::Colours::Foregrounds]
      def repository
        Vedeu.foreground_colours
      end

    end # Foreground

  end # Colours

end # Vedeu
