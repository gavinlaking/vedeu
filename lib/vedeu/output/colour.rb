require 'vedeu/support/coercions'

module Vedeu

  # Provides a container for terminal escape sequences controlling the
  # foreground and background colours of a character or collection of
  # characters.
  #
  class Colour

    include Vedeu::Coercions

    # @!attribute [r] attributes
    # @return [Hash]
    attr_reader :attributes

    # @!attribute [r] background
    # @return [Background|String]
    attr_reader :background

    # @!attribute [r] foreground
    # @return [Foreground|String]
    attr_reader :foreground

    # Returns a new instance of Colour.
    #
    # @param attributes [Hash]
    # @option attributes background [String]
    # @option attributes foreground [String]
    # @return [Colour]
    def initialize(attributes = {})
      @attributes = defaults.merge!(attributes)

      @background = Background.coerce(@attributes[:background])
      @foreground = Foreground.coerce(@attributes[:foreground])
    end

    # Converts the value into a Vedeu::Foreground.
    #
    # @param value [String]
    # @return [String]
    def foreground=(value)
      @foreground = Foreground.coerce(value)
    end

    # Converts the value into a Vedeu::Background.
    #
    # @param value [String]
    # @return [String]
    def background=(value)
      @background = Background.coerce(value)
    end

    # Returns both or either of the converted attributes into a single escape
    # sequence.
    #
    # @return [String]
    def to_s
      foreground.to_s + background.to_s
    end

    private

    # The default values for a new instance of this class.
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
