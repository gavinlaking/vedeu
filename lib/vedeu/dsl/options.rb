module Vedeu

  module DSL

    class Options

      include Vedeu::Common

      # @param opts [Hash]
      # @return [Vedeu::DSL::Options]
      def initialize(opts = {})
        @opts = opts || {}
      end

      # @return [NilClass|Vedeu::Colours::Colour]
      def colour
        return nil unless colour_options?

        Vedeu::Colours::Colour.coerce(opts)
      end

      # @return [Hash]
      def options
        {
          colour: colour,
          style:  style,
        }
      end

      # @return [NilClass|Vedeu::Presentation::Style]
      def style
        return nil unless style_options?

        Vedeu::Presentation::Style.coerce(opts)
      end

      protected

      # @!attribute [r] opts
      # @return [Hash]
      attr_reader :opts

      private

      # @return [Array<Symbol>]
      def colour_options
        [:colour, :background, :foreground]
      end

      # @return [Boolean]
      def colour_options?
        return false unless options?

        (opts.keys & colour_options).any? { |opt| present?(opts[opt]) }
      end

      # @return [Boolean]
      def options?
        present?(opts)
      end

      # @return [Boolean]
      def style_options?
        return false unless options?

        opts.include?(:style) && present?(opts[:style])
      end

    end # Options

  end # DSL

end # Vedeu
