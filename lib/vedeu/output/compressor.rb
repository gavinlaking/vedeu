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
        @content ||= if present?(output)
                       output.content.reject(&:cell?)

                     else
                       []

                     end
      end

      # @return [String]
      def compress
        Vedeu.timer("Compression for #{content.size} objects".freeze) do
          out = content.map do |cell|
            [
              # position_for(cell),
              cell.position.to_s,
              colour_for(cell),
              style_for(cell),
              cell.value,
            ].join
          end.join

          Vedeu.log(type:    :compress,
                    message: "Compression: #{content.size} objects -> " \
                             "#{out.size} characters".freeze)

          out
        end
      end

      # @return [String]
      def uncompress
        out = content.map(&:to_s).join

        Vedeu.log(type:    :compress,
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
