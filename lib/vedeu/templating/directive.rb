module Vedeu

  module Templating

    # Converts a directive found in a template into a Vedeu::Stream object.
    class Directive

      include Vedeu::Templating::Helpers

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

      # @return [Proc]
      def proc
        @proc ||= Proc.new {}
      end

    end # Directive

  end # Templating

end # Vedeu
