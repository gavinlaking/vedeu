module Vedeu
  module Colour
    class Palette
      class << self
        def all
          @colour_map ||= new.colour_map
        end

        def exists?(name)
          !!(find(name))
        end

        def find(name)
          all[name] || [:default, :default]
        end

        def create(name, mask)
          all.merge!(name => mask)
        end

        def reset!
          @colour_map = new.colour_map
        end
      end

      def colour_map
        {
          black:   '',
          red:     '',
          green:   '',
          yellow:  '',
          blue:    '',
          magenta: '',
          cyan:    '',
          white:   '',
          default: ''
        }
      end
    end
  end
end
