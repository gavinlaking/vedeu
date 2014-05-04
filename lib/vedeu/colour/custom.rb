module Vedeu
  module Colour
    class Custom
      def self.define(name, html_colour)
        new(name, html_colour).define
      end

      def initialize(name, html_colour)
        @name, @html_colour = name, html_colour
      end

      def define
        Colour::Palette.create(name, code)
      end

      private

      attr_reader :name, :html_colour

      def code
        Colour::Translator.translate(html_colour)
      end
    end
  end
end
