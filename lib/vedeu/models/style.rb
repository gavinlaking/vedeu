module Vedeu

  # Converts the style value or value collection into a terminal escape
  # sequence. Unrecognised values are discarded- an empty string is returned.
  #
  # @api private
  class Style

    include Vedeu::Common

    attr_reader :attributes, :values

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

    # Return the terminal escape sequences for the values provided.
    #
    # @return [String]
    def to_s
      escape_sequences
    end

    private

    # Converts the style or styles into terminal escape sequences.
    #
    # @api private
    # @return [String]
    def escape_sequences
      return '' unless defined_value?(values)

      @_sequences ||= Array(values).flatten.map do |value|
        Esc.string(value)
      end.join
    end

  end
end
