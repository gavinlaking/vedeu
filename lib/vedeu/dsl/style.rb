module Vedeu

  module DSL

    # Provides a style helper for use in the {DSL::Interface}, {DSL::Line} and
    # {DSL::Stream} classes.
    #
    # @api public
    module Style

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
