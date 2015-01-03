require 'vedeu/support/coercions'

module Vedeu

  # Provides a container for terminal escape sequences controlling the
  # foreground and background colours of a character or collection of
  # characters.
  #
  # @api private
  class Colour

    include Vedeu::Coercions

    attr_reader :attributes, :background, :foreground

    # Returns a new instance of Colour.
    #
    # @param attributes [Hash]
    # @return [Colour]
    def initialize(attributes = {})
      @attributes = defaults.merge(attributes)

      @background = Background.escape_sequence(@attributes[:background])
      @foreground = Foreground.escape_sequence(@attributes[:foreground])
    end

    # Converts the value into a terminal escape sequence.
    #
    # @param value [String]
    # @return [String]
    def foreground=(value)
      @foreground = Foreground.escape_sequence(value)
    end

    # Converts the value into a terminal escape sequence.
    #
    # @param value [String]
    # @return [String]
    def background=(value)
      @background = Background.escape_sequence(value)
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
