
module Vedeu

  module DSL

    # Provides helper methods for building views.
    #
    module Text

      # Specify the content for a view. Provides the means to align a
      # string (or object responding to `to_s`), and add it as a Line
      # or to the Stream.
      #
      # @note If using the convenience methods; left, centre, center
      #   or right, then a specified anchor will be ignored.
      #
      # @example
      #   lines do
      #     centre '...'
      #   end
      #
      #   line do
      #     right '...'
      #   end
      #
      #   line do
      #     stream do
      #       text '...'
      #     end
      #   end
      #
      #   left 'This will be left aligned.', width: 35
      #   # => 'This will be left aligned.         '
      #
      #   centre 'This will be aligned centrally.', width: 35
      #   # => '  This will be aligned centrally.  '
      #   # centre is also aliased to center
      #
      #   right 'This will be right aligned.', width: 35
      #   # => '        This will be right aligned.'
      #
      #   right 'This will be right aligned.', width: 35,
      #     anchor: centre
      #
      #   text 'This will be truncated here. More text here.',
      #     width: 28 # => 'This will be truncated here.'
      #
      #   text 'Padded with hyphens.', width: 25, pad: '-',
      #     anchor: :right # => '-----Padded with hyphens.'
      #
      # @param value [String|Object] A string or object that responds
      #   to `to_s`.
      # @param options [Hash<Symbol => void>] Text options.
      # @option options :anchor [Symbol] One of `:left`,
      #   `:centre`/`:center`, or `:right`.
      # @option options :width [Integer|NilClass] The width of the
      #   text stream to add. If the `string` provided is longer than
      #   this value, the string will be truncated. If no width is
      #   provided in the context of 'lines', then the interface width
      #   is used. If no width is provided in the context of a
      #   'stream', then no alignment will occur.
      # @option options :pad [String] The character to use to pad the
      #   width, by default uses an empty space (0x20). Only when the
      #   string is shorter than the specified width.
      # @return [String]
      def text(value = '', options = {})
        options.merge!(anchor: __callee__, model: model, client: client)

        Vedeu::Output::Text.add(value, options)
      end
      alias_method :text=,   :text
      alias_method :align,   :text
      alias_method :center,  :text
      alias_method :centre,  :text
      alias_method :left,    :text
      alias_method :right,   :text
      alias_method :align=,  :text
      alias_method :center=, :text
      alias_method :centre=, :text
      alias_method :left=,   :text
      alias_method :right=,  :text

    end # Text

  end # DSL

end # Vedeu
