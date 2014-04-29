module Vedeu
  module Colours
    class UndefinedColour < StandardError; end

    class Style
      class << self
        def define(name, foreground, background)
          new(name, foreground, background).define
        end
      end

      def initialize(name, foreground, background)
        @name, @foreground, @background = name, foreground, background
      end

      def define
        Colours::Wrapper.define_pair(pair_id, foreground, background)

        Colours::Palette
         .create(name, Colours::Wrapper.colour_pair(pair_id)).fetch(name)
      end

      private

      attr_reader :name

      def foreground
        Colours::Palette.find(@foreground) if exists?(@foreground)
      end

      def background
        Colours::Palette.find(@background) if exists?(@background)
      end

      def pair_id
        @pair_id = Colours::Palette.next_id
      end

      def exists?(name)
        unless Colours::Palette.exists?(name)
          raise Colours::UndefinedColour, message(name)
        end
      end

      def message(name)
        "Use `Colours::Custom.define(#{name}, '#rrggbb')` to define " \
        "this colour first, replacing 'rrggbb' with a valid HTML colour."
      end
    end
  end
end
