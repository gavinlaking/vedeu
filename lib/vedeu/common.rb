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
    # @param value [FalseClass|TrueClass]
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
    # @param name [String]
    # @return [String]
    def snake_case(name)
      name.gsub!(/::/, '/')
      name.gsub!(/([A-Z]+)([A-Z][a-z])/, '\1_\2')
      name.gsub!(/([a-z\d])([A-Z])/, '\1_\2')
      name.tr!('-', '_')
      name.downcase!
      name
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
