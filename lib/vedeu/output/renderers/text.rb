module Vedeu

  module Renderers

    # Converts a grid of {Vedeu::Char} objects into a stream of escape sequences
    # and content.
    class Text

      # @param output [Array<Array<Vedeu::Char>>]
      # @return [String]
      def self.render(*output)
        new(*output).render
      end

      # Returns a new instance of Vedeu::Renderers::Text.
      #
      # @param output [Array<Array<Vedeu::Char>>]
      # @return [Vedeu::Renderers::Text]
      def initialize(*output)
        @output  = output
      end

      # @return [String]
      def render
        parsed
      end

      protected

      # @!attribute [r] output
      # @return [Array<Array<Vedeu::Char>>]
      attr_reader :output

      private

      # @return [String]
      def parsed
        Vedeu::Compressor.new(output).render
      end

    end # Text

  end # Renderers

end # Vedeu
