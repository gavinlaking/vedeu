module Vedeu

  # Represents an invisible escape character sequence.
  #
  # @api private
  class Escape

    # @!attribute [r] value
    # @return [String]
    attr_reader :value
    alias_method :to_s, :value
    alias_method :to_str, :value

    # Returns a new instance of Vedeu::Escape.
    #
    # @param value [String]
    # @return [Vedeu::Escape]
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

    # Override Ruby's Object#inspect method to provide a more helpful output.
    #
    # @return [String]
    def inspect
      "<Vedeu::Escape '#{Vedeu::Esc.escape(to_s)}'>"
    end

    # @return [String]
    def position
      ''
    end

    # @return [String]
    def style
      ''
    end

  end # Escape

end # Vedeu
