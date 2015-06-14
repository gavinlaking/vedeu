module Vedeu

  # Represents an invisible escape character sequence.
  class EscapeChar

    # @!attribute [r] value
    # @return [String]
    attr_reader :value
    alias_method :to_s, :value
    alias_method :to_str, :value

    # @param value [String]
    # @return [Vedeu::EscapeChar]
    def initialize(value)
      @value = value
    end

    # @return [String]
    def colour
      ''
    end

    # An object is equal when its values are the same.
    #
    # @param other [Vedeu::Char]
    # @return [Boolean]
    def eql?(other)
      self.class == other.class && value == other.value
    end
    alias_method :==, :eql?

    # @return [String]
    def inspect
      "<Vedeu::EscapeChar '#{Vedeu::Esc.escape(to_s)}'>"
    end

    # @return [String]
    def position
      ''
    end

    # @return [String]
    def style
      ''
    end

  end # EscapeChar

end # Vedeu
