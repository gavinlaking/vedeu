require 'vedeu/support/align'

module Vedeu

  module DSL

    module Alignment

      # Align a string (or object responding to `to_s`), and add it as a Line or
      # to the Stream.
      #
      # @note If using the convenience methods; {left}, {centre}, {center} or
      #   {right}, then a specified anchor will be ignored.
      #
      # @example
      #   lines do
      #     centre '...'
      #
      #   line do
      #     right '...'
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

      #   right 'This will be right aligned.', width: 35, anchor: centre
      #   # => '        This will be right aligned.'
      #
      #   align 'This will be truncated here. More text here.', width: 28
      #   # => 'This will be truncated here.'
      #
      #   align 'Padded with hyphens.', width: 25, pad: '-', anchor: :right
      #   # => '-----Padded with hyphens.'
      #
      # @param value [String|Object] A string or object that responds to `to_s`.
      # @param options [Hash] Alignment options.
      # @option options :anchor [Symbol] One of `:left`, `:centre`/`:center`, or
      #   `:right`.
      # @option options :width [Integer|NilClass] The width of the text stream
      #   to add. If the `string` provided is longer than this value, the string
      #   will be truncated. If no width is provided in the context of 'lines',
      #   then the interface width is used. If no width is provided in the context
      #   of a 'stream', then no alignment will occur.
      # @option options :pad [String] The character to use to pad the width, by
      #   default uses an empty space (0x20). Only when the string is shorter
      #   than the specified width.
      # @return [String]
      def align(value = '', options = {})
        aligned = Vedeu::Align.with(value, options.merge({ anchor: __callee__ }))

        if model.is_a?(Vedeu::Line)
          line(aligned)

        elsif model.is_a?(Vedeu::Stream)
          model.value << aligned

        else
          # not supported

        end
      end
      alias_method :left,   :align
      alias_method :center, :align
      alias_method :centre, :align
      alias_method :right,  :align
      alias_method :text,   :align
      alias_method :stream, :align

      private

    end # Alignment

  end # DSL

end # Vedeu
