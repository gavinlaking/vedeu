module Vedeu
  module API
    module Helpers

      # Define either or both foreground and background colours for an
      # interface, line or a stream.
      #
      # @param values [Hash]
      #
      # @example
      #   interface 'my_interface' do
      #     colour background: '#000000', foreground: '#ffffff'
      #     ... some interface attributes ...
      #
      #   line do
      #     colour background: '#000000', foreground: '#ffffff'
      #     ... some line attributes ...
      #
      #   stream do
      #     colour background: '#000000', foreground: '#ffffff'
      #     ... some stream attributes ...
      #
      # @return []
      def colour(values = {})
        fail InvalidArgument, '#colour expects a Hash containing :foreground,' \
                              ' :background or both.' unless values.is_a?(Hash)

        attributes[:colour] = values
      end

      # Define a style for an interface, line or a stream.
      #
      # @param values [Array|String]
      # @param block  [Proc]
      #
      # @example
      #   interface 'my_interface' do
      #     style 'normal'
      #     ... some interface attributes ...
      #   end
      #
      #   line do
      #     style ['bold', 'underline']
      #     ... some line attributes ...
      #
      #   stream do
      #     style 'blink'
      #     ... some stream attributes ...
      #
      # @return []
      def style(values = [], &block)
        if block_given?
          attributes[:streams] << API::Stream.build({ style: [values] }, &block)

        else
          [values].flatten.each { |value| attributes[:style] << value }

        end
      end

    end
  end
end
