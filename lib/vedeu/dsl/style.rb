module Vedeu

  module DSL

    # Provides a style helper for use in the {DSL::Interface}, {DSL::Line} and
    # {DSL::Stream} classes.
    #
    # @api public
    module Style

      # Define a style or styles for an interface, line or a stream.
      #
      # @param value [Array|Symbol|String]
      #
      # @example
      #   interface 'my_interface' do
      #     style 'normal'
      #     ...
      #
      #   lines do
      #     style ['bold', 'underline']
      #     ...
      #
      #   stream do
      #     style 'blink'
      #     ...
      #
      # @return [Vedeu::Style]
      def style(*value_or_values)
        value_or_values.each { |value| set_style(value) }
      end
      alias_method :styles, :style

      private

      # @param value [Symbol|String]
      # @return [Hash]
      def set_style(value)
        self.style << value
      end

    end # Style

  end # DSL

end # Vedeu
