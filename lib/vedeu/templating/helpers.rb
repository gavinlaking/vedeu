# frozen_string_literal: true

module Vedeu

  module Templating

    # Provide helpers to be used with your Vedeu templates.
    #
    module Helpers

      include Vedeu::View

      # @param value [String] The HTML/CSS colour.
      # @macro param_block
      # @macro raise_requires_block
      # @return [Vedeu::Views::Stream]
      def background(value, &block)
        define_stream(background: value, &block)
      end
      alias bg background

      # @param attributes [Hash]
      # @option attributes foreground [String] The HTML/CSS foreground
      #   colour.
      # @option attributes background [String] The HTML/CSS background
      #   colour.
      # @macro param_block
      # @macro raise_requires_block
      # @return [Vedeu::Views::Stream]
      def colour(attributes = {}, &block)
        define_stream(attributes, &block)
      end

      # @param value [String] The HTML/CSS colour.
      # @macro param_block
      # @macro raise_requires_block
      # @return [Vedeu::Views::Stream]
      def foreground(value, &block)
        define_stream(foreground: value, &block)
      end
      alias fg foreground

      # @param value [Symbol]
      # @macro param_block
      # @return [Vedeu::Views::Stream]
      def style(value, &block)
        define_stream(style: value, &block)
      end

      private

      # @see Vedeu::Templating::Helpers#colour
      def define_stream(attributes = {}, &block)
        raise Vedeu::Error::RequiresBlock unless block_given?

        value = yield

        encode(
          Vedeu::Views::Stream.build(
            colour: Vedeu::Colours::Colour.new(attributes),
            style:  Vedeu::Presentation::Style.new(attributes[:style]),
            value:  value
          )
        )
      end

      # @param data [String]
      # @return [String]
      def encode(data)
        Vedeu::Templating::Encoder.process(data)
      end

    end # Helpers

  end # Templating

end # Vedeu
