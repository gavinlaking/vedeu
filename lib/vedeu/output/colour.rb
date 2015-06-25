module Vedeu

  # Provides a container for terminal escape sequences controlling the
  # foreground and background colours of a character or collection of
  # characters.
  #
  # Vedeu uses HTML/CSS style notation (i.e. '#aadd00'), they can be used at the
  # stream level, the line level or for the whole interface. Terminals generally
  # support either 8, 16 or 256 colours, with few supporting full 24-bit colour
  # (see notes below).
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
  # Notes:
  # Terminals which support the 24-bit colour mode include (but are not limited
  # to): iTerm2 (OSX), Gnome Terminal (Linux).
  #
  # Setting your `$TERM` environment variable as above gets you up to 256
  # colours, but if you then add the `colour_mode 16_777_216` configuration to
  # your client application, it's really a hit and miss affair. iTerm2 renders
  # all the colours correctly as does Gnome Terminal. Terminator (Linux) goes
  # crazy though and defaults to 16 colours despite the `$TERM` setting. This
  # area needs more work in Vedeu.
  #
  # @todo Fix colours in all terminals. (GL: 2015-04-13)
  # @api private
  class Colour

    # @!attribute [r] attributes
    # @return [Hash]
    attr_reader :attributes

    # @param value []
    # @return [Object]
    def self.coerce(value)
      # Vedeu::ColourCoercer.coerce(value)
      return value if value.is_a?(self)
      return new unless value.is_a?(Hash)

      if value[:colour]
        return value[:colour] if value[:colour].is_a?(self)
        return new unless value[:colour].is_a?(Hash)
        return new(value[:colour]) if value[:colour][:background] ||
                                      value[:colour][:foreground]

      elsif value[:background] || value[:foreground]
        new(value)

      else
        new

      end
    end

    # Returns a new instance of Vedeu::Colour.
    #
    # @param attributes [Hash]
    # @option attributes background [String]
    # @option attributes foreground [String]
    # @return [Vedeu::Colour]
    def initialize(attributes = {})
      @attributes = defaults.merge!(attributes)
    end

    # Returns the background colour as a Vedeu::Background.
    #
    # @return [Vedeu::Background]
    def background
      @background ||= Vedeu::Background.coerce(attributes[:background])
    end

    # Converts the value into a Vedeu::Background.
    #
    # @param value [String]
    # @return [String]
    def background=(value)
      @background = @attributes[:background] = Vedeu::Background.coerce(value)
    end

    # An object is equal when its values are the same.
    #
    # @param other [Vedeu::Char]
    # @return [Boolean]
    def eql?(other)
      self.class == other.class && background == other.background &&
        foreground == other.foreground
    end
    alias_method :==, :eql?

    # Returns the foreground colour as a Vedeu::Foreground.
    #
    # @return [Vedeu::Foreground]
    def foreground
      @foreground ||= Vedeu::Foreground.coerce(attributes[:foreground])
    end

    # Converts the value into a Vedeu::Foreground.
    #
    # @param value [String]
    # @return [String]
    def foreground=(value)
      @foreground = @attributes[:foreground] = Vedeu::Foreground.coerce(value)
    end

    # Returns both or either of the converted attributes into a single escape
    # sequence.
    #
    # @return [String]
    def to_s
      foreground.to_s + background.to_s
    end
    alias_method :to_str, :to_s

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
