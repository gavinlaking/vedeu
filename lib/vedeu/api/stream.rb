module Vedeu
  module API

    # Provides methods to be used to define views.
    class Stream < Vedeu::Stream

      include Helpers

      # Specify the alignment of the stream within the line. Useful in
      # combination with #width to provide simple formatting effects.
      #
      # @api public
      # @param value [Symbol] `:left`, `:centre` and `right` are valid values
      #   and will align accordingly. If not value is specified, the stream will
      #   left align.
      #
      # @example
      #   ...
      #     stream do
      #       align :right
      #       ...
      #
      # @return [Symbol]
      def align(value)
        unless [:left, :right, :centre].include?(value.to_sym)
          fail InvalidSyntax, '`align` requires a value of `:left`, `:right` ' \
                              'or `centre`.'
        end

        attributes[:align] = value.to_sym
      end

      # Add textual data to the stream via this method.
      #
      # @api public
      # @param value [String] The text to be added to the stream. If the length
      #   of the text is greater than the interface's width, it will be
      #   truncated and ellipsized.
      #
      # @example
      #   ...
      #     stream do
      #       text 'Some text to display...'
      #       ...
      #
      # @return [String]
      def text(value)
        attributes[:text] = value
      end

      # Provides the ability to arbitrarily set the width of content for a
      # stream. Useful in combination with #align to provide simple formatting
      # effects.
      #
      # @api public
      # @param value [Fixnum] The width in characters.
      #
      # @example
      #   ...
      #     stream do
      #       width 20
      #       ...
      #
      # @return [Fixnum]
      def width(value)
        attributes[:width] = value
      end

    end
  end
end
