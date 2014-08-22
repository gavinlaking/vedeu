module Vedeu
  class Colour
    def initialize(attributes = {})
      @attributes = attributes
    end

    def attributes
      defaults.merge!(@attributes)
    end

    def foreground
      @foreground ||= Foreground.escape_sequence(attributes[:foreground])
    end

    def background
      @background ||= Background.escape_sequence(attributes[:background])
    end

    def to_s
      foreground + background
    end

    private

    def defaults
      {
        foreground: '',
        background: ''
      }
    end
  end
end
