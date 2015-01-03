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
      def style(value)
        model.style = Vedeu::Style.coerce(value)
      end
      alias_method :styles, :style

    end # Style

  end # DSL

end # Vedeu
