module Vedeu

  class Cell

    # @!attribute [r] background
    # @return [NilClass|String]
    attr_reader :background

    # @!attribute [r] foreground
    # @return [NilClass|String]
    attr_reader :foreground

    # @!attribute [r] style
    # @return [NilClass|Array<Symbol|String>|Symbol|String]
    attr_reader :style

    # @!attribute [r] value
    # @return [NilClass|String]
    attr_reader :value

    # @!attribute [r] x
    # @return [NilClass|Fixnum]
    attr_reader :x

    # @!attribute [r] y
    # @return [NilClass|Fixnum]
    attr_reader :y

    # @param attributes [Hash<Symbol => Array<Symbol|String>, Fixnum, String, Symbol]
    # @option attributes background [NilClass|String]
    # @option attributes foreground [NilClass|String]
    # @option attributes style [NilClass|Array<Symbol|String>|Symbol|String]
    # @option attributes value [NilClass|String]
    # @option attributes x [NilClass|Fixnum]
    # @option attributes y [NilClass|Fixnum]
    # @return [Vedeu::Cell]
    def initialize(attributes = {})
      @background = attributes[:background]
      @foreground = attributes[:foreground]
      @style      = attributes[:style]
      @value      = attributes[:value]
      @x          = attributes[:x]
      @y          = attributes[:y]
    end

    # @param other [Vedeu::Cell]
    # @return [Boolean]
    def ==(other)
      eql?(other)
    end

    # @param other [Vedeu::Cell]
    # @return [Boolean]
    def eql?(other)
      self.class == other.class      &&
      background == other.background &&
      foreground == other.foreground &&
      style      == other.style      &&
      value      == other.value      &&
      x          == other.x          &&
      y          == other.y
    end

  end # Cell

end # Vedeu
