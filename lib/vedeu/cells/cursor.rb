# frozen_string_literal: true

module Vedeu

  module Cells

    # Provides the position and visibility escape sequence for a
    # {Vedeu::Cursors::Cursor}
    #
    # @api private
    #
    class Cursor < Vedeu::Cells::Empty

      # @return [NilClass]
      def null
        nil
      end
      alias background null
      alias colour null
      alias foreground null
      alias style null

      # @return [String]
      def to_ast
        ''
      end

      # Return an empty hash as most escape sequences won't make
      # sense as JSON.
      #
      # @return [Hash<void>]
      def to_h
        {}.merge!(position.to_h).merge!(value: value)
      end
      alias to_hash to_h

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
      alias to_str to_s

      # @return [String]
      def text
        ''
      end

      # @return [Symbol]
      def type
        :cursor
      end

      private

      # @macro defaults_method
      def defaults
        super.merge!(position: Vedeu::Geometries::Position.new(1, 1))
      end

    end # Cursor

  end # Cells

end # Vedeu
