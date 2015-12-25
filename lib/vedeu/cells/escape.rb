# frozen_string_literal: true

module Vedeu

  module Cells

    # Provides the character/escape sequence to draw one cell of a
    # with a custom value, colour and style.
    #
    # The Vedeu::Cells::Escape object represents an escape sequence as
    # a single character, meaning they will behave dependent on the
    # context in which they are used.
    #
    # (In a terminal, an escape sequence makes sense, when a view is
    # being rendered as HTML, the sequence may be meaningless, for
    # example; the sequence to show or hide the cursor.)
    #
    # @api private
    #
    class Escape < Vedeu::Cells::Empty

      include Vedeu::Geometries::Positionable

      # @return [Boolean]
      def cell?
        false
      end

      # @return [NilClass]
      def null
        nil
      end
      alias_method :background, :null
      alias_method :colour,     :null
      alias_method :foreground, :null
      alias_method :style,      :null

      # Return an empty hash as most escape sequences won't make
      # sense as JSON.
      #
      # @return [Hash<void>]
      def to_h
        {}
      end
      alias_method :to_hash, :to_h

      # Return an empty string as most escape sequences won't make
      # sense as HTML.
      #
      # @param _options [Hash] Ignored.
      # @return [String]
      def to_html(_options = {})
        ''
      end

      # @return [String]
      def to_s
        "#{position}#{value}"
      end
      alias_method :to_str, :to_s

      private

      # @return [Hash]
      def defaults
        super.merge!(position: [1, 1], value: '')
      end

    end # Escape

  end # Cells

end # Vedeu
