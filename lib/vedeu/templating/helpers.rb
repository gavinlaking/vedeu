module Vedeu

  module Templating

    module Helpers

      # @param value [String] The HTML/CSS colour.
      # @param block [Proc]
      # @return [Vedeu::Stream]
      # @raise [InvalidSyntax] The required block was not given.
      def background(value, &block)
        define_stream({ background: value }, &block)
      end
      alias_method :bg, :background

      # @param attributes [Hash]
      # @option attributes foreground [String] The HTML/CSS foreground colour.
      # @option attributes background [String] The HTML/CSS background colour.
      # @param block [Proc]
      # @return [Vedeu::Stream]
      # @raise [InvalidSyntax] The required block was not given.
      def colour(attributes = {}, &block)
        define_stream(attributes, &block)
      end

      # @example
      #   Roses are {{ foreground('#ff0000', 'red') }}, violets are {{ fg('#0000ff', 'blue') }}
      #
      #   {{ foreground('#00ff00'), 'The test suite is all green!' }}
      #
      # @param value [String] The HTML/CSS colour.
      # @param block [Proc]
      # @return [Vedeu::Stream]
      # @raise [InvalidSyntax] The required block was not given.
      def foreground(value, &block)
        define_stream({ foreground: value }, &block)
      end
      alias_method :fg, :foreground

      private

      # @param see Vedeu::Templating::Helpers#colours
      def define_colour(attributes = {})
        attributes.delete_if do |k, v|
          [:background, :foreground].include?(k) == false || v.nil? || v.empty?
        end

        Vedeu::Colour.new(attributes)
      end

      # @param see Vedeu::Templating::Helpers#colours
      def define_stream(attributes = {}, &block)
        fail InvalidSyntax, 'block not given' unless block_given?

        Vedeu::Stream.build({ colour: define_colour(attributes), value: block.call })
      end

    end # Helpers

  end # Templating

end # Vedeu
