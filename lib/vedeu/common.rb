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

  end # Common

end # Vedeu
