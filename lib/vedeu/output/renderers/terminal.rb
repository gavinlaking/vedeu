module Vedeu

  module Renderers

    # Converts a grid of {Vedeu::Char} objects into a stream of escape sequences
    # and content suitable for a terminal.
    class Terminal

      # @param output [Array<Array<Vedeu::Char>>]
      # @return [String]
      def self.render(*output)
        new(*output).render
      end

      # Returns a new instance of Vedeu::Renderers::Terminal.
      #
      # @param output [Array<Array<Vedeu::Char>>]
      # @return [Vedeu::Renderers::Terminal]
      def initialize(*output)
        @output = output
      end

      # @return [Array<String>]
      def render
        Vedeu::Terminal.output(parsed)
      end

      protected

      # @!attribute [r] output
      # @return [Array<Array<Vedeu::Char>>]
      attr_reader :output

      private

      # @return [String]
      def parsed
        Vedeu::Timer.for(:debug, "Compression") do
          Vedeu::Compressor.new(output).render
        end
      end

    end # Terminal

  end # Renderers

end # Vedeu
