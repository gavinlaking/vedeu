module Vedeu

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

          if char.respond_to?(:border) && !char.border.nil?
            out << Vedeu::Esc.border { char.value }

          else
            out << char.value

          end

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
