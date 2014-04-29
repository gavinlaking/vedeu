module Vedeu
  module Colours
    class Custom
      class << self
        def define(name, html_colour)
          new(name, html_colour).define
        end
      end

      def initialize(name, html_colour)
        @name, @html_colour = name, html_colour
      end

      def define
        Colours::Palette.create(name, id)
      end

      private

      attr_reader :name, :html_colour

      def id
        Colours::Translator.translate(html_colour)
      end
    end
  end
end
