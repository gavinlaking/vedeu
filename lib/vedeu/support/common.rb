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

    # Sends a warning to STDOUT indicating that a Vedeu method being used by the
    # client application is being deprecated and an alternative should be
    # sought.
    #
    # @param old_method [String] e.g. Vedeu::API::Interface#width
    # @param new_method [String] e.g. Vedeu::DSL::Geometry#width
    # @param version [String] e.g. 0.3.0
    # @param hint [String] e.g. /Vedeu/DSL/Geometry#width-instance-method
    # @raise DeprecationError
    # @return [NilClass]
    def deprecated(old_method, new_method, version, hint)
      raise DeprecationError, "#{old_method} is now deprecated, and will be
        removed in version #{version}.\nUse: #{new_method} (#{DOCS_URL}#{hint})"
    end

    # Raises an exception which includes in the message the method which
    # requires a block to be passed to it.
    #
    # @param method [String|Symbol] The method which requires a block.
    # @raise [InvalidSyntax]
    def requires_block(method)
      fail InvalidSyntax, "`#{method}` requires a block."
    end

    # Returns the array as a sentence.
    #
    # @param array [Array]
    # @return [String]
    def to_sentence(array)
      Vedeu::Sentence.construct(array)
    end

  end # Common

end # Vedeu
