# frozen_string_literal: true

module Vedeu

  module DSL

    # Truncates a string to an optional width, or uses the named
    # geometry width.
    #
    # @api private
    #
    class Truncate

      include Vedeu::Common

      # Returns a new instance of Vedeu::DSL::Truncate.
      #
      # @param value [String]
      # @param options [Hash<Symbol => Boolean|Integer|NilClass|String|
      #   Symbol]
      # @option options name [String|Symbol] The name of the geometry
      #   to use to determine the width if the width option is not
      #   given.
      # @option options truncate [Boolean] Whether to truncate the
      #   value.
      # @option options width [Integer] The width of the new value.
      # @return [Vedeu::DSL::Truncate]
      def initialize(value = '', options = {})
        @value   = value || ''
        @options = defaults.merge!(options)
      end

      # @return [String]
      def text
        if truncate?
          truncate

        else
          value

        end
      end

      protected

      # @!attribute [r] options
      # @return [Hash<Symbol => Boolean|Integer|NilClass|String|
      #   Symbol]
      attr_reader :options

      private

      # @macro defaults_method
      def defaults
        {
          name:     nil,
          truncate: false,
          width:    nil,
        }
      end

      # @macro geometry_by_name
      def geometry
        @_geometry ||= Vedeu.geometries.by_name(options[:name])
      end

      # @return [Boolean]
      def truncate?
        truthy?(options[:truncate]) && value.size > width
      end

      # @return [String]
      def truncate
        value.slice(0, width)
      end

      # @return [String]
      def value
        if present?(@value) && string?(@value)
          @value

        elsif present?(@value)
          @value.to_s

        else
          ''

        end
      end

      # Return the width of the interface when a name is given,
      # otherwise use the given width.
      #
      # @return [Integer]
      def width
        if present?(options[:width])
          options[:width]

        elsif present?(options[:name])
          geometry.bordered_width

        else
          value.size

        end
      end

    end # Truncate

  end # DSL

end # Vedeu
