module Vedeu

  module Terminal

    class Buffer

      # private

      def column(y = 1, x = 1)
        return false if y < 1 || y > Vedeu.height
        return false if x < 1 || x > Vedeu.width

      end

      def row(y = 1)
        return false if y < 1 || y > Vedeu.height

      end

      # @return [Array<Array<Vedeu::Cell>>]
      def terminal
        Array.new(Vedeu.height) do |y|
          Array.new(Vedeu.width) do |x|
            Vedeu::Cell.new(y: y + 1, x: x + 1)
          end
        end
      end

      def write(value, y = 1, x = 1)
        return false if value.nil?
        return false if y < 1 || y > Vedeu.height
        return false if x < 1 || x > Vedeu.width

        terminal[y][x] = value
      end

    end # Buffer

  end # Terminal

end # Vedeu
