module Vedeu

  module Output

    # During the conversion of a Vedeu::Views::Char object into a
    # string of escape sequences, this class removes multiple
    # occurences of the same escape sequence, resulting in a smaller
    # payload being sent to the renderer.
    #
    # @api private
    #
    class Compressor

      include Vedeu::Common

      # @param (see #initialize)
      # @return [String]
      def self.render(output, options = {})
        new(output, options).render
      end

      # Returns a new instance of Vedeu::Output::Compressor.
      #
      # @param output [Array<Array<Vedeu::Views::Char>>]
      # @param options [Hash]
      # @option options compression [Boolean]
      # @return [Vedeu::Output::Compressor]
      def initialize(output, options = {})
        @output  = output
        @options = options
        @colour  = ''
        @style   = ''
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

      # @return [Array]
      def content
        return [] if absent?(output)

        @content ||= output.content.reject(&:cell?)
      end

      # @return [String]
      def compress
        Vedeu.timer("Compression for #{content.size} characters".freeze) do
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

        content.each do |cell|
          out << cell.to_s
        end

        out
      end

      # @param char [Vedeu::Views::Char]
      # @return [String]
      def colour_for(char)
        return ''.freeze if char.colour == @colour

        @colour = char.colour
        @colour.to_s
      end

      # @param char [Vedeu::Views::Char]
      # @return [String]
      def style_for(char)
        return ''.freeze if char.style == @style

        @style = char.style
        @style.to_s
      end

    end # Compressor

  end # Output

end # Vedeu
