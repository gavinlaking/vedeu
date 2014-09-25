module Vedeu

  # A module for common methods used throughout Vedeu.
  #
  # @api private
  module Common

    # Returns a boolean indicating whether a variable has a useful value.
    #
    # @param variable [String|Symbol|Array|Fixnum] The variable to check.
    # @return [Boolean]
    def defined_value?(variable)
      return true if variable.is_a?(Fixnum)
      return true unless variable.nil? || variable.empty?

      false
    end

    private

    # At present, validates that attributes has a `:name` key that is not nil or
    # empty.
    #
    # @api private
    # @param attributes [Hash]
    # @return [TrueClass|MissingRequired]
    def validate_attributes!(attributes)
      return missing_required unless attributes.key?(:name)
      return missing_required unless defined_value?(attributes[:name])

      true
    end

    # Raises the MissingRequired exception.
    #
    # @param attr [String] A textual representation of the attribute.
    # @return [MissingRequired]
    def missing_required(attr = 'name')
      fail MissingRequired, "Cannot store data without a #{attr} attribute."
    end

  end
end

