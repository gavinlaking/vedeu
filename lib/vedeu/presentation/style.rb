require 'vedeu/support/common'

module Vedeu

  # Converts the style value or value collection into a terminal escape
  # sequence. Unrecognised values are discarded- an empty string is returned.
  #
  # @api private
  class Style

    include Vedeu::Common

    attr_accessor :values
    attr_reader   :attributes

    # Return a new instance of Style.
    #
    # @param values [String|Array] The style value or values collection.
    # @return [Style]
    def initialize(values)
      @values = values
    end

    # Return an attributes hash for this class.
    #
    # @return [Hash]
    def attributes
      {
        style: values
      }
    end

    # Return the terminal escape sequences after converting the style or styles.
    #
    # @return [String]
    def to_s
      return '' unless defined_value?(values)

      @_sequences ||= Array(values).flatten.map do |value|
        Esc.string(value)
      end.join
    end
    alias_method :escape_sequences, :to_s

  end # Style

end # Vedeu
