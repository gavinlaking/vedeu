module Vedeu
  class Colour

    # @param  []
    # @return []
    def initialize(attributes = {})
      @attributes = attributes
    end

    # @return []
    def attributes
      defaults.merge!(@attributes)
    end

    # @return []
    def foreground
      @foreground ||= Foreground.escape_sequence(attributes[:foreground])
    end

    # @return []
    def background
      @background ||= Background.escape_sequence(attributes[:background])
    end

    # @return []
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
