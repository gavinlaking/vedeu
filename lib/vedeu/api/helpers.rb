module Vedeu
  module API

    # Provides colour and style helpers for use in the {API::Interface},
    # {API::Line} and {API::Stream} classes.
    #
    # @api public
    module Helpers

      # Define either or both foreground and background colours for an
      # interface, line or a stream.
      #
      # @param values [Hash]
      #
      # @example
      #   interface 'my_interface' do
      #     colour background: '#000000', foreground: '#ffffff'
      #     ...
      #
      #   line do
      #     colour background: '#000000', foreground: '#ffffff'
      #     ...
      #
      #   stream do
      #     colour background: '#000000', foreground: '#ffffff'
      #     ...
      #
      # @return [Hash]
      def colour(values)
        unless values.key?(:foreground) || values.key?(:background)
          fail InvalidSyntax, '#colour expects a Hash containing ' \
            ':foreground or :background or both.'
        end

        attributes[:colour] = values
      end

      # Define a style or styles for an interface, line or a stream.
      #
      # @param values [Array|String]
      # @param block  [Proc]
      #
      # @example
      #   interface 'my_interface' do
      #     style 'normal'
      #     ...
      #
      #   line do
      #     style ['bold', 'underline']
      #     ...
      #
      #   stream do
      #     style 'blink'
      #     ...
      #
      # @return [Array]
      def style(values = [], &block)
        if block_given?
          attributes[:streams] << API::Stream
                                    .build({ style: Array(values) }, &block)

        else
          Array(values).each { |value| attributes[:style] << value }

        end
      end

    end
  end
end
