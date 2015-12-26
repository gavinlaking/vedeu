# frozen_string_literal: true

module Vedeu

  module Presentation

    # Converts the style value or value collection into a terminal
    # escape sequence. Unrecognised values are discarded- an empty
    # string is returned.
    #
    # Vedeu has a range of symbol styles which are compatible with
    # most terminals which are ANSI compatible. Like colours, they can
    # be defined in either interfaces, for specific lines or within
    # streams. Styles are applied as encountered.
    #
    # @see Vedeu::EscapeSequences::Esc
    #
    class Style

      class << self

        include Vedeu::Common

        # Produces new objects of the correct class from the value,
        # ignores objects that have already been coerced.
        #
        # @param value [Object|NilClass]
        # @return [Object]
        def coerce(value)
          return value if value.is_a?(Vedeu::Presentation::Style)
          return new(value) unless value.is_a?(Hash)
          return new unless present?(value[:style])

          if value[:style].is_a?(Vedeu::Presentation::Style)
            value[:style]

          else
            new(value[:style])

          end
        end

      end # Eigenclass

      include Vedeu::Common

      # @!attribute [rw] value
      # @return [String|Symbol]
      attr_accessor :value

      # Return a new instance of Vedeu::Presentation::Style.
      #
      # @param value [Array<String|Symbol>|String|Symbol]
      #   The style value or a collection of values.
      # @return [Vedeu::Presentation::Style]
      def initialize(value = nil)
        @value = value
      end

      # Return an attributes hash for this class.
      #
      # @return [Hash<Symbol => Array<String|Symbol>|String|Symbol>]
      def attributes
        {
          style: value
        }
      end

      # An object is equal when its values are the same.
      #
      # @param other [Vedeu::Views::Char]
      # @return [Boolean]
      def eql?(other)
        self.class == other.class && value == other.value
      end
      alias_method :==, :eql?

      # Return the terminal escape sequences after converting the
      # style or styles.
      #
      # @return [String]
      def to_s
        return '' unless present?(value)

        @sequences ||= Array(value).flat_map { |v| Vedeu.esc.string(v) }.join
      end
      alias_method :escape_sequences, :to_s
      alias_method :to_str, :to_s

    end # Style

  end # Presentation

end # Vedeu
