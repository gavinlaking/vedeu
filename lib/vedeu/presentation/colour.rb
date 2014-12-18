module Vedeu

  # Provides a container for terminal escape sequences controlling the
  # foreground and background colours of a character or collection of
  # characters.
  #
  # @api private
  class Colour

    attr_reader :attributes
    attr_writer :background, :foreground

    # Returns a new instance of Colour.
    #
    # @param attributes [Hash]
    # @return [Colour]
    def initialize(attributes = {})
      @attributes = defaults.merge(attributes)
      @background = @attributes[:background]
      @foreground = @attributes[:foreground]
    end

    # Converts the `:foreground` attribute into a terminal escape sequence.
    #
    # @return [String]
    def foreground
      Foreground.escape_sequence(@foreground)
    end

    # Converts the `:background` attribute into a terminal escape sequence.
    #
    # @return [String]
    def background
      Background.escape_sequence(@background)
    end

    # Returns both or either of the converted attributes into a single escape
    # sequence.
    #
    # @return [String]
    def to_s
      foreground + background
    end

    private

    # The default values for a new instance of Colour.
    #
    # @return [Hash]
    def defaults
      {
        foreground: '',
        background: ''
      }
    end

  end # Colour

end # Vedeu
