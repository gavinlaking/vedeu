module Vedeu
  class Colour
    def initialize(attributes = {})
      @attributes = attributes
    end

    def attributes
      defaults.merge!(@attributes)
    end

    def foreground
      @foreground ||= ColourTranslator
        .new(attributes[:foreground], { truecolor: false }).foreground
    end

    def background
      @background ||= ColourTranslator
        .new(attributes[:background], { truecolor: false }).background
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
