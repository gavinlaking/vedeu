module Vedeu

  # During the conversion of a Vedeu::Char object into a string of escape
  # sequences, this class removes multiple occurences of the same escape
  # sequence, resulting in a smaller payload being sent to the renderer.
  #
  class Compressor

    # @param output [Array<Array<Vedeu::Char>>]
    # @return [Vedeu::Compressor]
    def initialize(output)
      @output = output
    end

    # @return [String]
    def render
      @colour = ''
      @style  = ''

      Array(output).flatten.map do |char|
        if char.is_a?(Vedeu::Char)
          out = ''

          out << char.position.to_s

          unless char.colour == @colour
            @colour = char.colour
            out << @colour.to_s
          end

          unless char.style == @style
            @style = char.style
            out << @style.to_s
          end

          out << char.value

          out

        else
          char.to_s

        end
      end.join
    end

    private

    attr_reader :output

  end # Compressor

end # Vedeu
