module Vedeu

  # Represent a boolean object.
  #
  # @api private
  #
  class Boolean

    # @param value [void]
    # @return [Vedeu::Boolean]
    def initialize(value = nil)
      @value = value
    end

    # @return [Boolean]
    def false?
      value.nil? || value == false
    end

    # @return [Boolean]
    def true?
      return false if false?

      true
    end

    private

    # @!attribute [r] value
    # @return [void]
    attr_reader :value

  end # Boolean

end # Vedeu
