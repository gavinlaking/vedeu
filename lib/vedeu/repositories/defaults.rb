# frozen_string_literal: true

module Vedeu

  module Repositories

    # Some classes expect a certain set of attributes when
    # initialized, this module uses the #defaults method of the class
    # to provide missing attribute keys (and values).
    #
    # @api private
    #
    module Defaults

      include Vedeu::Common

      # Returns a new instance of the class including this module.
      #
      # @note
      #   If a particular key is missing from the attributes
      #   parameter, then it is added with the respective value from
      #   #defaults.
      #
      # @param attributes [Hash]
      # @return [void] A new instance of the class including this
      #   module.
      def initialize(attributes = {})
        defaults.merge!(validate(attributes)).each do |key, value|
          instance_variable_set("@#{key}", value || defaults.fetch(key))
        end
      end

      private

      # @macro defaults_method
      def defaults
        {}
      end

      # @param attributes [Hash]
      # @macro raise_invalid_syntax
      # @return [Hash]
      def validate(attributes)
        fail Vedeu::Error::InvalidSyntax,
             'Argument :attributes is not a Hash.' unless hash?(attributes)

        attributes.keep_if { |key, _| defaults.key?(key) }
      end

    end # Defaults

  end # Repositories

end # Vedeu
