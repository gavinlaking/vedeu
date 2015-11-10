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

    # Removes the module part from the expression in the string.
    #
    # @example
    #   demodulize('Vedeu::SomeModule::SomeClass') # => "SomeClass"
    #
    # @param klass [Class|String]
    # @return [String]
    def demodulize(klass)
      klass = klass.to_s

      klass[(klass.rindex('::') + 2)..-1]
    end

    # Returns a boolean indicating whether a variable has a useful
    # value.
    #
    # @param variable [String|Symbol|Array|Fixnum] The variable to
    #   check.
    # @return [Boolean]
    def present?(variable)
      return true if variable.is_a?(Fixnum)
      return true unless variable.nil? || variable.empty?

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

  end # Common

end # Vedeu
