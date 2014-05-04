module Vedeu
  module Colour
    class UndefinedColour < StandardError; end

    class Style
      def self.define(name, foreground, background)
        new(name, foreground, background).define
      end

      def initialize(name, foreground, background)
        @name, @foreground, @background = name, foreground, background
      end

      def define
        Colour::Palette
         .create(name, nil).fetch(name)
      end

      private

      attr_reader :name

      def foreground
        Colour::Palette.find(@foreground) if exists?(@foreground)
      end

      def background
        Colour::Palette.find(@background) if exists?(@background)
      end

      def pair_id
        @pair_id = Colour::Palette.next_id
      end

      def exists?(name)
        unless Colour::Palette.exists?(name)
          raise Colour::UndefinedColour, message(name)
        end
      end

      def message(name)
        "Use `Colour::Custom.define(#{name}, '#rrggbb')` to define " \
        "this colour first, replacing 'rrggbb' with a valid HTML colour."
      end
    end
  end
end
