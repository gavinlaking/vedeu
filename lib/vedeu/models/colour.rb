module Vedeu
  class Colour

    attr_reader :attributes

    # @param attributes [Hash]
    # @return [Colour]
    def initialize(attributes = {})
      @attributes = defaults.merge!(attributes)
    end

    # @return [String]
    def foreground
      @foreground ||= Foreground.escape_sequence(attributes[:foreground])
    end

    # @return [String]
    def background
      @background ||= Background.escape_sequence(attributes[:background])
    end

    # @return [String]
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
