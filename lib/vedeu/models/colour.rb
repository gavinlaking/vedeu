module Vedeu
  class Colour
    def initialize(_attributes = {})
      @_attributes = _attributes
    end

    def attributes
      _attributes
    end

    def foreground
      @foreground ||= ColourTranslator.new(_attributes[:foreground]).foreground
    end

    def background
      @background ||= ColourTranslator.new(_attributes[:background]).background
    end

    def to_s
      foreground + background
    end

    private

    def _attributes
      defaults.merge!(@_attributes)
    end

    def defaults
      {
        foreground: '',
        background: ''
      }
    end
  end
end
