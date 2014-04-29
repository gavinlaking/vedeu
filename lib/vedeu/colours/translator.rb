module Vedeu
  module Colours
    class Translator
      def self.translate(html_colour = nil)
        new(html_colour).translate
      end

      def initialize(html_colour = nil)
        @html_colour = html_colour
      end

      def translate
        return unless html_colour
        [term_colour_base, red, green, blue].inject(:+)
      end

      private

      attr_reader :html_colour

      def red
        (html_colour[1..2].to_i(16) / colour_divide) * 36
      end

      def green
        (html_colour[3..4].to_i(16) / colour_divide) * 6
      end

      def blue
        (html_colour[5..6].to_i(16) / colour_divide) * 1
      end

      def colour_divide
        source_values / target_values
      end

      def source_values
        256
      end

      def target_values
        5
      end

      def term_colour_base
        16
      end
    end
  end
end
