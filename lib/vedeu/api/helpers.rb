module Vedeu
  module API
    module Helpers

      # Define either or both foreground and background colours for an
      # interface, a stream, or a line.
      #
      # @param values [Hash]
      #
      # @example
      #   TODO
      #
      # @return []
      def colour(values = {})
        fail InvalidArgument, '#colour expects a Hash containing :foreground,' \
                              ' :background or both.' unless values.is_a?(Hash)

        attributes[:colour] = values
      end

      # Define a style for an interface, a stream or a line.
      #
      # @param values [Array|String]
      # @param block  [Proc]
      #
      # @example
      #   TODO
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
