module Vedeu

  module Output

    # During the conversion of a Vedeu::Views::Char object into a
    # string of escape sequences, this class removes multiple
    # occurences of the same escape sequence, resulting in a smaller
    # payload being sent to the renderer.
    #
    class Compressor

      # @param output [Array<Array<Vedeu::Views::Char>>]
      # @return [String]
      def self.render(output)
        new(output).render
      end

      # Returns a new instance of Vedeu::Output::Compressor.
      #
      # @param output [Array<Array<Vedeu::Views::Char>>]
      # @return [Vedeu::Output::Compressor]
      def initialize(output)
        @output = output
        @colour = ''
        @style  = ''
      end

      # @note
      #   Takes approximately ~25ms for 2100 chars. (2015-07-25)
      # @return [String]
      def render
        return compress if Vedeu::Configuration.compression?

        uncompress
      end

      protected

      # @!attribute [r] output
      # @return [Array<Array<Vedeu::Views::Char>>]
      attr_reader :output

      private

      def content
        return [] if output.nil? || output.empty?

        output.content.delete_if { |cell| cell.is_a?(Vedeu::Models::Cell) }
      end

      # @return [String]
      def compress
        Vedeu.timer('Compression') do
          out = ''

          content.each do |cell|
            out << cell.position.to_s
            out << colour_for(cell)
            out << style_for(cell)
            out << cell.value
          end

          out
        end
      end

      # @return [String]
      def uncompress
        out = ''

        content.each { |cell| out << cell.to_s }

        out
      end

      # @param char [Vedeu::Views::Char]
      # @return [String]
      def colour_for(char)
        return '' if char.colour == @colour

        @colour = char.colour
        @colour.to_s
      end

      # @param char [Vedeu::Views::Char]
      # @return [String]
      def style_for(char)
        return '' if char.style == @style

        @style = char.style
        @style.to_s
      end

    end # Compressor

  end # Output

end # Vedeu
