require 'vedeu/support/common'
require 'vedeu/support/coercions'

module Vedeu

  # Converts the style value or value collection into a terminal escape
  # sequence. Unrecognised values are discarded- an empty string is returned.
  #
  # @api private
  class Style

    include Vedeu::Common
    include Vedeu::Coercions

    attr_accessor :value

    # Return a new instance of Style.
    #
    # @param value [Array|Array<String>|Array<Symbol>|String|Symbol]
    #   The style value or a collection of values.
    # @return [Style]
    def initialize(value = nil)
      @value = value
    end

    # Return an attributes hash for this class.
    #
    # @return [Hash]
    def attributes
      {
        style: value
      }
    end

    # Return the terminal escape sequences after converting the style or styles.
    #
    # @return [String]
    def to_s
      return '' unless defined_value?(value)

      @sequences ||= Array(value).flatten.map { |v| Esc.string(v) }.join
    end
    alias_method :escape_sequences, :to_s

  end # Style

end # Vedeu
