module Vedeu

  module Templating

    # Converts a directive found in a template into a Vedeu::Stream object.
    class Directive

      # @param code [String]
      # @return [Vedeu::Stream]
      def self.process(code)
        new(code).process
      end

      # @param code [String]
      def initialize(code)
        @code = code
      end

      # @return [Vedeu::Stream]
      def process
        eval(code, proc.binding)
      end

      protected

      # @!attribute [r] code
      # @return [String]
      attr_reader :code

      private

      # @param attributes [Hash]
      # @param block [Proc]
      # @return [Vedeu::Stream]
      def colour(attributes = {}, &block)
        Vedeu::Stream.new(colour: Vedeu::Colour.coerce(attributes),
                          value:  block.call)
      end

      # @return [Proc]
      def proc
        @proc ||= Proc.new {}
      end

    end # Directive

  end # Templating

end # Vedeu
