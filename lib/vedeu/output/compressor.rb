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
      @colour = ''
      @style  = ''
    end

    # @return [String]
    def render
      Array(output).flatten.map do |char|
        if char.is_a?(Vedeu::Char)
          out = ''
          out << char.position.to_s
          out << colour_for(char)
          out << style_for(char)
          out << char.value
          out

        else
          char.to_s

        end
      end.join
    end

    private

    attr_reader :output

    # @param char [Vedeu::Char]
    # @return [String]
    def colour_for(char)
      return '' if char.colour == @colour

      @colour = char.colour
      @colour.to_s
    end

    # @param char [Vedeu::Char]
    # @return [String]
    def style_for(char)
      return '' if char.style == @style

      @style = char.style
      @style.to_s
    end

  end # Compressor

end # Vedeu
