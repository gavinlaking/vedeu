module Vedeu
  module Colours
    class Palette
      class << self
        def all
          @colour_map ||= new.colour_map
        end

        def exists?(name)
          !!(find(name))
        end

        def find(name)
          all[name]
        end

        def create(name, colour_id)
          all.merge!(name => colour_id)
        end

        def next_id
          all.size + 1
        end

        def reset!
          @colour_map = new.colour_map
        end
      end

      def colour_map
        {
          normal:  Colours::Wrapper.normal,
          reverse: Colours::Wrapper.reverse,
          black:   Colours::Wrapper.black,
          red:     Colours::Wrapper.red,
          green:   Colours::Wrapper.green,
          yellow:  Colours::Wrapper.yellow,
          blue:    Colours::Wrapper.blue,
          magenta: Colours::Wrapper.magenta,
          cyan:    Colours::Wrapper.cyan,
          white:   Colours::Wrapper.white,
        }
      end
    end
  end
end
