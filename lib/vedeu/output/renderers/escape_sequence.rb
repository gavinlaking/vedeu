module Vedeu

  module Renderers

    # A renderer which returns the escape sequence for each character.
    #
    class EscapeSequence

      include Vedeu::RendererOptions

      # Returns a new instance of Vedeu::Renderers::EscapeSequence.
      #
      # @param options [Hash]
      # @return [Vedeu::Renderers::EscapeSequence]
      def initialize(options = {})
        @options = options || {}
      end

      # Render the output with the escape sequences escaped.
      #
      # @param output [Vedeu::Models::Page]
      # @return [String]
      def render(output)
        out = ''

        output.each do |row|
          row.each { |cell| out << Vedeu::Esc.escape(cell.to_s) }
        end

        out
      end

    end # EscapeSequence

  end # Renderers

end # Vedeu
