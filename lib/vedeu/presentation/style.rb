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
    # @api private
    #
    class Style

      class << self

        extend Forwardable

        def_delegators Vedeu::Coercers::Style,
                       :coerce

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
          style: value,
        }
      end

      # An object is equal when its values are the same.
      #
      # @param other [void]
      # @return [Boolean]
      def eql?(other)
        self.class.equal?(other.class) && value == other.value
      end
      alias == eql?

      # @return [String]
      def to_ast
        ':s'
      end

      # Return the terminal escape sequences after converting the
      # style or styles.
      #
      # @return [String]
      def to_s
        return '' unless present?(value)

        @sequences ||= Array(value).flat_map { |v| Vedeu.esc.string(v) }.join
      end
      alias escape_sequences to_s
      alias to_str to_s

    end # Style

  end # Presentation

end # Vedeu
