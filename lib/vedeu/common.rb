# frozen_string_literal: true

module Vedeu

  # A module for common methods used throughout Vedeu.
  #
  # @api private
  #
  module Common

    # Returns a boolean indicating whether a variable is nil, false or
    # empty.
    #
    # @param variable [String|Symbol|Array|Fixnum] The variable to
    #   check.
    # @return [Boolean]
    def absent?(variable)
      variable == false || !present?(variable)
    end

    # Returns a boolean indicating whether the value is an Array.
    #
    # @param value [Array|void]
    # @return [Boolean]
    def array?(value)
      value.is_a?(Array)
    end

    # Returns a boolean indicating the value is a boolean.
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

    # Returns a boolean indicating the value is empty.
    #
    # @param value [void]
    # @return [Boolean]
    def empty_value?(value)
      return true if value.respond_to?(:empty?) && value.empty?
      return true if value.nil?

      false
    end

    # Returns a boolean indicating whether the value is an escape
    # sequence object (e.g. {Vedeu::Cells::Escape}.)
    #
    # @return [Boolean]
    def escape?(value)
      value.is_a?(Vedeu::Cells::Escape) || value.is_a?(Vedeu::Cells::Cursor)
    end

    # Returns a boolean indicating whether the value should be
    # considered false.
    #
    # @param value [void]
    # @return [Boolean]
    def falsy?(value)
      Vedeu::Boolean.new(value).false?
    end

    # Returns a boolean indicating whether the value is a Hash.
    #
    # @param value [Hash|void]
    # @return [Boolean]
    def hash?(value)
      value.is_a?(Hash)
    end

    # Returns a boolean indicating the model is a
    # {Vedeu::Views::Line}.
    #
    # @return [Boolean]
    def line_model?
      if defined?(model)
        model.is_a?(Vedeu::Views::Line)

      else
        false

      end
    end

    # Returns a boolean indicating whether the value is a Fixnum.
    #
    # @param value [Fixnum|void]
    # @return [Boolean]
    def numeric?(value)
      value.is_a?(Integer) || value == Float::INFINITY
    end
    alias fixnum? numeric?

    # Returns a boolean indicating the value has a position
    # attribute.
    #
    # @param value [void]
    # @return [Boolean]
    def positionable?(value)
      value.respond_to?(:position) &&
        value.position.is_a?(Vedeu::Geometries::Position)
    end

    # Returns a boolean indicating whether a variable has a useful
    # value.
    #
    # @param variable [String|Symbol|Array|Fixnum] The variable to
    #   check.
    # @return [Boolean]
    def present?(variable)
      return true  if numeric?(variable)
      return false if variable.nil? || variable == false
      return false if empty_value?(variable)

      true
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
          chars =~ /\p{Lower}/ ? [chars, '_'] : chars
        end.flatten

        upper.map(&:downcase).join
      end.join('/')
    end

    # Returns a boolean indicating the model is a
    # {Vedeu::Views::Stream}.
    #
    # @return [Boolean]
    def stream_model?
      if defined?(model)
        model.is_a?(Vedeu::Views::Stream)

      else
        false

      end
    end

    # Returns a boolean indicating whether the value is a String.
    #
    # @param value [String|void]
    # @return [Boolean]
    def string?(value)
      value.is_a?(String)
    end

    # Returns a boolean indicating whether the value is a Symbol.
    #
    # @param value [Symbol|void]
    # @return [Boolean]
    def symbol?(value)
      value.is_a?(Symbol)
    end

    # Returns a boolean indicating whether the value should be
    # considered true.
    #
    # @param value [void]
    # @return [Boolean]
    def truthy?(value)
      Vedeu::Boolean.new(value).true?
    end

    # Returns a boolean indicating the model is a
    # {Vedeu::Views::View}.
    #
    # @return [Boolean]
    def view_model?
      if defined?(model)
        model.is_a?(Vedeu::Views::View)

      else
        false

      end
    end

  end # Common

end # Vedeu
