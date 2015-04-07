module Vedeu

  # Provides a container for terminal escape sequences controlling the
  # foreground and background colours of a character or collection of
  # characters.
  #
  # Vedeu uses HTML/CSS style notation (i.e. '#aadd00'), they can be used at the
  # stream level, the line level or for the whole interface. Terminals generally
  # support either 8, 16 or 256 colours, with few supporting full 24-bit colour.
  #
  # Vedeu attempts to detect the colour depth using the `$TERM` environment
  # variable.
  #
  # To set your `$TERM` variable to allow 256 colour support:
  #
  # ```bash
  # echo "export TERM=xterm-256color" >> ~/.bashrc
  # ```
  #
  class Colour

    # @!attribute [r] attributes
    # @return [Hash]
    attr_reader :attributes

    # @!attribute [r] background
    # @return [Background|String]
    attr_reader :background

    # @!attribute [r] foreground
    # @return [Foreground|String]
    attr_reader :foreground

    # @param value []
    # @return [Object]
    def self.coerce(value)
      if value.nil?
        new

      elsif value.is_a?(self)
        value

      elsif value.is_a?(Hash)
        if value.key?(:colour) && value[:colour].is_a?(self)
          value

        elsif value.key?(:background) || value.key?(:foreground)
          new(value)

        else
          new

        end

      else
        new(value)

      end
    end

    # Returns a new instance of Vedeu::Colour.
    #
    # @param attributes [Hash]
    # @option attributes background [String]
    # @option attributes foreground [String]
    # @return [Colour]
    def initialize(attributes = {})
      @attributes = defaults.merge!(attributes)

      @background = Vedeu::Background.coerce(@attributes[:background])
      @foreground = Vedeu::Foreground.coerce(@attributes[:foreground])
    end

    # Converts the value into a Vedeu::Background.
    #
    # @param value [String]
    # @return [String]
    def background=(value)
      @background = Vedeu::Background.coerce(value)
    end

    # @param other [Vedeu::Char]
    # @return [Boolean]
    def eql?(other)
      self.class == other.class && background == other.background &&
        foreground == other.foreground
    end
    alias_method :==, :eql?

    # Converts the value into a Vedeu::Foreground.
    #
    # @param value [String]
    # @return [String]
    def foreground=(value)
      @foreground = Vedeu::Foreground.coerce(value)
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
    # @return [Hash<Symbol => NilClass>]
    def defaults
      {
        background: '',
        foreground: '',
      }
    end

  end # Colour

end # Vedeu
