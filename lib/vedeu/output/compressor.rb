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
        if Vedeu::Configuration.compression?
          compress

        else
          uncompress

        end
      end

      protected

      # @!attribute [r] output
      # @return [Array<Array<Vedeu::Views::Char>>]
      attr_reader :output

      private

      # @return [String]
      def compress
        out = ''
        Array(output).flatten.each do |char|
          out << char.position.to_s
          out << colour_for(char)
          out << style_for(char)
          out << char.value
        end
        out
      end

      # @return [String]
      def uncompress
        out = ''
        Array(output).flatten.each { |char| out << char.to_s }
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
