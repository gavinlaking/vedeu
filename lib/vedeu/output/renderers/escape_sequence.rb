module Vedeu

  module Renderers

    # A renderer which returns the escape sequence for each character.
    #
    class EscapeSequence

      include Vedeu::Renderers::Options

      # Returns a new instance of Vedeu::Renderers::EscapeSequence.
      #
      # @param options [Hash]
      # @return [Vedeu::Renderers::EscapeSequence]
      def initialize(options = {})
        @options = options || {}
      end

      # Render a cleared output.
      #
      # @return [String]
      def clear
        ''
      end

      # Render the output with the escape sequences escaped.
      #
      # @param output [Vedeu::Models::Page]
      # @return [String]
      def render(output)
        out = ''

        output.each do |row|
          row.each do |cell|
            out << Vedeu::EscapeSequences::Esc.escape(cell.to_s)
          end
        end

        out
      end

    end # EscapeSequence

  end # Renderers

end # Vedeu
