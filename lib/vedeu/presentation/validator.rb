require 'vedeu/support/common'

module Vedeu

  # Validates that a given hash contains foreground and/or background
  # attributes.
  #
  # @api private
  class Validator

    include Vedeu::Common

    def self.check(attributes = {})
      new(attributes).check
    end

    def initialize(attributes)
      @attributes = attributes
    end

    def check
      fail InvalidSyntax,
        "You must specify colours as key/value pairs. Valid keys are: " \
        "#{valid_keys_to_string}. Valid values are HTML/CSS colours."

      true
    end

    private

    def empty_error
      fail InvalidSyntax, 'You must specify colours as key/value pairs.'
    end

    def invalid_keys?
      attributes
    end

    def valid_keys
      [:background, :bgcolor, :bg, :foreground, :fgcolor, :fg]
    end

    def valid_keys_to_string
      to_sentence(valid_keys.map { |key| "'#{key}'" })
    end

    def validate
      return empty_error unless defined_value?(attributes)

      return key_error
    end

  end # Validator

end # Vedeu
