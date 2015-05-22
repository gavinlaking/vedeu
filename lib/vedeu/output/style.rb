module Vedeu

  # Converts the style value or value collection into a terminal escape
  # sequence. Unrecognised values are discarded- an empty string is returned.
  #
  # Vedeu has a range of symbol styles which are compatible with most terminals
  # which are ANSI compatible. Like colours, they can be defined in either
  # interfaces, for specific lines or within streams.
  # Styles are applied as encountered.
  #
  # @see Vedeu::Esc
  class Style

    include Vedeu::Common

    # @!attribute [rw] value
    # @return [String|Symbol]
    attr_accessor :value

    # Produces new objects of the correct class from the value, ignores objects
    # that have already been coerced.
    #
    # @param value [Object|NilClass]
    # @return [Object]
    def self.coerce(value)
      if value.nil?
        new

      elsif value.is_a?(self)
        value

      else
        new(value)

      end
    end

    # Return a new instance of Vedeu::Style.
    #
    # @param value [Array<String|Symbol>|String|Symbol]
    #   The style value or a collection of values.
    # @return [Style]
    def initialize(value = nil)
      @value = value
    end

    # Return an attributes hash for this class.
    #
    # @return [Array<String|Symbol>|String|Symbol]
    def attributes
      {
        style: value,
      }
    end

    # An object is equal when its values are the same.
    #
    # @param other [Vedeu::Char]
    # @return [Boolean]
    def eql?(other)
      self.class == other.class && value == other.value
    end
    alias_method :==, :eql?

    # Return the terminal escape sequences after converting the style or styles.
    #
    # @return [String]
    def to_s
      return '' unless defined_value?(value)

      @sequences ||= Array(value).flatten.map { |v| Vedeu::Esc.string(v) }.join
    end
    alias_method :escape_sequences, :to_s

  end # Style

end # Vedeu
