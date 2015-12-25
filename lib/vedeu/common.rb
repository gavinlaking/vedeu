# frozen_string_literal: true

module Vedeu

  # A module for common methods used throughout Vedeu.
  #
  # @api private
  #
  module Common

    # Returns a boolean indicating whether a variable is nil or empty.
    #
    # @param variable [String|Symbol|Array|Fixnum] The variable to
    #   check.
    # @return [Boolean]
    def absent?(variable)
      !present?(variable)
    end

    # Converts one class into another.
    #
    # @param klass [Class] The class to become an instance of.
    # @param attributes [Hash] The attributes of klass.
    # @return [Class] Returns a new instance of klass.
    def become(klass, attributes)
      klass.new(attributes)
    end

    # Returns a boolean indicating the value was a boolean.
    #
    # @param value [void]
    # @return [Boolean]
    def boolean(value)
      return value if boolean?(value)
      return false if falsy?(value)
      return true  if truthy?(value)
    end

    # Returns a boolean indicating whether the value is a Boolean.
    #
    # @param value [Boolean]
    # @return [Boolean]
    def boolean?(value)
      value.is_a?(TrueClass) || value.is_a?(FalseClass)
    end

    # Returns a boolean indicating whether the value should be
    # considered false.
    #
    # @param value [void]
    # @return [Boolean]
    def falsy?(value)
      value.nil? || value.is_a?(FalseClass)
    end

    # Returns a boolean indicating whether the value is a Hash.
    #
    # @param value [Hash|void]
    # @return [Boolean]
    def hash?(value)
      value.is_a?(Hash)
    end

    # Returns a boolean indicating whether the value is a Fixnum.
    #
    # @param value [Fixnum|void]
    # @return [Boolean]
    def numeric?(value)
      value.is_a?(Fixnum)
    end

    # Returns a boolean indicating whether a variable has a useful
    # value.
    #
    # @param variable [String|Symbol|Array|Fixnum] The variable to
    #   check.
    # @return [Boolean]
    def present?(variable)
      return true if variable.is_a?(Fixnum)
      return true unless variable.nil? ||
                         (variable.respond_to?(:empty?) && variable.empty?)

      false
    end

    # Converts a class name to a lowercase snake case string.
    #
    # @example
    #   snake_case(MyClassName) # => "my_class_name"
    #   snake_case(NameSpaced::ClassName)
    #   # => "name_spaced/class_name"
    #
    #   snake_case('MyClassName') # => "my_class_name"
    #   snake_case(NameSpaced::ClassName)
    #   # => "name_spaced/class_name"
    #
    # @param klass [Module|Class|String]
    # @return [String]
    def snake_case(klass)
      str = klass.is_a?(Module) ? klass.name : klass

      str.split(/::/).map do |namespace|
        *upper, _ = namespace.split(/([A-Z]+)/).reject(&:empty?).map do |chars|
          chars.match(/\p{Lower}/) ? [chars, '_'] : chars
        end.flatten

        upper.map(&:downcase).join
      end.join('/')
    end

    # Returns a boolean indicating whether the value is a Fixnum.
    #
    # @param value [String|void]
    # @return [Boolean]
    def string?(value)
      value.is_a?(String)
    end

    # Returns a boolean indicating whether the value should be
    # considered true.
    #
    # @param value [void]
    # @return [Boolean]
    def truthy?(value)
      !falsy?(value)
    end

  end # Common

end # Vedeu
