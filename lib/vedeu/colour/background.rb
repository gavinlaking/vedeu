module Vedeu
  module Colour
    class Background < Base
      private

      def prefix
        '48;5;'
      end

      def codes
        {
          black:   40,
          red:     41,
          green:   42,
          yellow:  43,
          blue:    44,
          magenta: 45,
          cyan:    46,
          white:   47,
          default: 49,
        }
      end
    end
  end
end
