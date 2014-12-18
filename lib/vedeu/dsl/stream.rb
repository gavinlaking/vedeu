module Vedeu

  module DSL

    # Provides methods to be used to define views.
    #
    # @api public
    class Stream

      include DSL::Colour
      include DSL::Style

      # Returns an instance of DSL::Stream.
      #
      # @param model [Stream]
      def initialize(model)
        @model = model
      end

      # Align a string (or object responding to `to_s`), and add it to the
      # Stream.
      #
      # @note If using the convenience methods; {left}, {centre}, {center} or
      #   {right}, then a specified anchor will be ignored.
      #
      # @example
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
      #   will be truncated.
      # @option options :pad [String] The character to use to pad the width, by
      #   default uses an empty space (0x20). Only when the string is shorter
      #   than the specified width.
      # @return [String]
      def align(value = '', options = {})
        model.text << Vedeu::Align.with(value,
          options.merge({ anchor: __callee__ }))
      end
      alias_method :left,   :align
      alias_method :center, :align
      alias_method :centre, :align
      alias_method :right,  :align

      # Add textual data to the stream via this method.
      #
      # @note Calls `to_s` on the 'value' param; meaning any object which
      #   responds to `to_s` can be provided.
      #
      # @param value [String|undefined] The text to be added to this Stream.
      # @return [String] The param 'value' as a String.
      def text(value = '')
        model.text << value.to_s
      end

      # @deprecated
      def width(value)
        warn "Vedeu::API::Stream#width is now deprecated, and will be " \
             "removed in version 0.3.0. Use: Vedeu::DSL::Stream#align " \
             "(#{DOCS_URL}/Vedeu/DSL/Stream#align-instance_method)"
      end

      private

      attr_reader :model

    end # Stream

  end # DSL

end # Vedeu
