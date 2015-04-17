module Vedeu

  module Renderers

    # A renderer which returns the escape sequence for each character.
    #
    class EscapeSequence

      # @param output [Array<Array<Vedeu::Char>>]
      # @return [String]
      def self.render(output)
        new(output).render
      end

      # @param output [Array<Array<Vedeu::Char>>]
      def initialize(output)
        @output = output
      end

      # @return [String]
      def render
        Vedeu.log(type:    :debug,
                  message: "#{self.class.name}:\n#{parsed}")

        parsed
      end

      private

      # @!attribute [r] output
      # @return [Array<Array<Vedeu::Char>>]
      attr_reader :output

      # Escapes the escape sequences.
      #
      # @return [String]
      def parsed
        @parsed ||= Array(output).flatten.map do |char|
          Esc.escape(char.to_s) + "\n"
        end.join
      end

    end # EscapeSequence

  end # Renderers

end # Vedeu
