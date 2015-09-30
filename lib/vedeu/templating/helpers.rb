module Vedeu

  module Templating

    # Provide helpers to be used with your Vedeu templates.
    #
    module Helpers

      include Vedeu::View

      # @param value [String] The HTML/CSS colour.
      # @param block [Proc]
      # @raise [Vedeu::Error::RequiresBlock]
      # @return [Vedeu::Views::Stream]
      def background(value, &block)
        define_stream(background: value, &block)
      end
      alias_method :bg, :background

      # @param attributes [Hash]
      # @option attributes foreground [String] The HTML/CSS foreground
      #   colour.
      # @option attributes background [String] The HTML/CSS background
      #   colour.
      # @param block [Proc]
      # @raise [Vedeu::Error::RequiresBlock]
      # @return [Vedeu::Views::Stream]
      def colour(attributes = {}, &block)
        define_stream(attributes, &block)
      end

      # @param value [String] The HTML/CSS colour.
      # @param block [Proc]
      # @raise [Vedeu::Error::RequiresBlock]
      # @return [Vedeu::Views::Stream]
      def foreground(value, &block)
        define_stream(foreground: value, &block)
      end
      alias_method :fg, :foreground

      # @param value [Symbol]
      # @param block [Proc]
      # @return [Vedeu::Views::Stream]
      def style(value, &block)
        define_stream(style: value, &block)
      end

      private

      # @see Vedeu::Templating::Helpers#colour
      def define_stream(attributes = {}, &block)
        fail Vedeu::Error::RequiresBlock unless block_given?

        encode(
          Vedeu::Views::Stream.build(
            colour: Vedeu::Colours::Colour.new(attributes),
            style:  Vedeu::Presentation::Style.new(attributes[:style]),
            value:  block.call))
      end

      # @param data [String]
      # @return [String]
      def encode(data)
        Vedeu::Templating::Encoder.process(data)
      end

    end # Helpers

  end # Templating

end # Vedeu
