module Vedeu

  module Templating

    # Provide helpers to be used with your Vedeu templates.
    #
    module ViewHelpers

      include Vedeu::Templating::Helpers

      private

      # @see Vedeu::Templating::Helpers#colour
      def define_stream(attributes = {}, &block)
        fail Vedeu::InvalidSyntax, 'block not given' unless block_given?

        encode(
          Vedeu::Stream.build(colour: Vedeu::Colour.new(attributes),
                              style:  Vedeu::Style.new(attributes[:style]),
                              value:  block.call))
      end

      # @param data [String]
      # @return [String]
      def encode(data)
        Vedeu::Templating::Encoder.process(data)
      end

    end # ViewHelpers

  end # Templating

end # Vedeu
