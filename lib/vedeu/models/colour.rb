module Vedeu
  class Colour

    attr_reader :attributes

    # @param attributes [Hash]
    # @return [Colour]
    def initialize(attributes = {})
      @attributes = defaults.merge!(attributes)
    end

    # Converts the `:foreground` attribute into a terminal escape sequence.
    #
    # @return [String]
    def foreground
      @foreground ||= Foreground.escape_sequence(attributes[:foreground])
    end

    # Converts the `:background` attribute into a terminal escape sequence.
    #
    # @return [String]
    def background
      @background ||= Background.escape_sequence(attributes[:background])
    end

    # Returns both or either of the converted attributes into a single escape
    # sequence.
    #
    # @return [String]
    def to_s
      foreground + background
    end

    private

    # @return [Hash]
    def defaults
      {
        foreground: '',
        background: ''
      }
    end

  end
end
