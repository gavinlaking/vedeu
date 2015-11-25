module Vedeu

  module Repositories

    # Some classes expect a certain set of attributes when
    # initialized, this module uses the #defaults method of the class
    # to provide missing attribute keys (and values).
    #
    # @api private
    #
    module Defaults

      # @!attribute [r] attributes
      # @return [Hash<void>]
      attr_reader :attributes

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
        @attributes = attributes.keep_if { |key, _| defaults.key?(key) }

        defaults.merge!(@attributes).each do |key, value|
          instance_variable_set("@#{key}", value || defaults.fetch(key))
        end
      end

      private

      # @return [Hash<void>]
      def defaults
        {}
      end

    end # Defaults

  end # Repositories

end # Vedeu
