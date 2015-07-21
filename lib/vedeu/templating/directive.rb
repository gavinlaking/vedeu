module Vedeu

  module Templating

    # Converts a directive found in a template into a Vedeu::Stream object.
    #
    class Directive

      include Vedeu::Templating::Helpers

      # @param code [String]
      # @return [Vedeu::Stream]
      def self.process(code)
        new(code).process
      end

      # Returns a new instance of Vedeu::Templating::Directive.
      #
      # @param code [String]
      # @return [Vedeu::Templating::Directive]
      def initialize(code)
        @code = code
      end

      # Evaluate the code/text in the template; converting any recognised
      # directives as they are encountered.
      #
      # @return [Vedeu::Stream]
      def process
        eval(code, proc {}.binding)
      end

      protected

      # @!attribute [r] code
      # @return [String]
      attr_reader :code

    end # Directive

  end # Templating

end # Vedeu
