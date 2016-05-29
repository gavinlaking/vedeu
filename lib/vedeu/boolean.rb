# frozen_string_literal: true

module Vedeu

  # Represent a boolean object.
  #
  # @api private
  #
  class Boolean

    # @return [Boolean]
    def self.coerce(value = nil)
      new(value).coerce
    end

    # @param value [void]
    # @return [Vedeu::Boolean]
    def initialize(value = nil)
      @value = value
    end

    # @return [Boolean]
    def coerce
      value ? true : false
    end

    # Returns a boolean indicating whether the value should be
    # considered false.
    #
    # @return [Boolean]
    def false?
      value.nil? || value == false
    end
    alias falsy? false?

    # Returns a boolean indicating whether the value should be
    # considered true.
    #
    # @return [Boolean]
    def true?
      !false?
    end
    alias truthy? true?

    private

    # @!attribute [r] value
    # @return [void]
    attr_reader :value

  end # Boolean

end # Vedeu
