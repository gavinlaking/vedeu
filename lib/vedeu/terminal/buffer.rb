module Vedeu

  module Terminal

    # All output will be written to this singleton, and #render will be called
    # at the end of each run of {Vedeu::MainLoop}; effectively rendering this
    # buffer to each registered renderer. This buffer is not cleared after this
    # action though, as subsequent actions will modify the contents. This means
    # that individual parts of Vedeu can write content here at various points
    # and only at the end of each run of {Vedeu::MainLoop} will it be actually
    # output 'somewhere'.
    #
    module Buffer

      extend self

      # @return [Array<Array<void>>]
      def output
        @output ||= terminal
      end

      # @return [void|NilClass]
      def render
        Vedeu.renderers.render(output) if Vedeu.ready?
      end

      # @return [Array<Array<void>>]
      def reset
        @output = terminal
      end

      # @return [Array<Array<Vedeu::Cell>>]
      def terminal
        Array.new(Vedeu.height) do |y|
          Array.new(Vedeu.width) do |x|
            Vedeu::Cell.new(y: y + 1, x: x + 1)
          end
        end
      end

      # @param value [void]
      # @param y [Fixnum]
      # @param x [Fixnum]
      # @return [Boolean]
      def write(value, y = 1, x = 1)
        return false if value.nil?
        return false if y < 1 || y > Vedeu.height
        return false if x < 1 || x > Vedeu.width

        output[y][x] = value

        true
      end

    end # Buffer

  end # Terminal

end # Vedeu
