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
        Vedeu.timer("Compression for #{content.size} objects".freeze) do
          out = ''

          content.each do |cell|
            out << position_for(cell)
            out << colour_for(cell)
            out << style_for(cell)
            out << cell.value
          end

          Vedeu.log(type:    :output,
                    message: "Compression: #{content.size} objects -> " \
                             "#{out.size} characters".freeze)

          out
        end
      end

      # @return [String]
      def uncompress
        out = ''

        content.each do |cell|
          out << cell.to_s
        end

        Vedeu.log(type:    :output,
                  message: "No compression: #{content.size} objects -> " \
                           "#{out.size} characters".freeze)

        out
      end

      # Compress by not repeatedly sending a position when only the x
      # coordinate has changed; i.e. we are on the same line, just
      # advancing a character.
      #
      # @param char [Vedeu::Views::Char]
      # @return [String]
      def position_for(char)
        return ''.freeze if char.position.y == @y

        @y = char.position.y
        char.position.to_s
      end

      # Compress by not repeatedly sending the same colours for each
      # character which has the same colours as the last character
      # output.
      #
      # @param char [Vedeu::Views::Char]
      # @return [String]
      def colour_for(char)
        return ''.freeze if char.colour == @colour

        @colour = char.colour
        @colour.to_s
      end

      # Compress by not repeatedly sending the same style(s) for each
      # character which has the same style(s) as the last character
      # output.
      #
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
