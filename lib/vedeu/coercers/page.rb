# frozen_string_literal: true

module Vedeu

  module Coercers

    # Provides the mechanism to convert a value into a
    # {Vedeu::Models::Page}.
    #
    # @api private
    #
    class Page < Vedeu::Coercers::Coercer

      # @param value
      #   [Vedeu::Models::Page|Vedeu::Models::Row|Array<void>|void]
      # @macro raise_invalid_syntax
      # @return [Vedeu::Models::Page]
      def coerce
        if coerced?
          value

        elsif value.is_a?(Vedeu::Models::Row)
          klass.new([value])

        elsif value.is_a?(Array) && value.empty?
          klass.new([Vedeu::Models::Row.coerce(value)])

        elsif value.is_a?(Array) || value.is_a?(Vedeu::Buffers::View)
          values = value.map { |v| Vedeu::Models::Row.coerce(v) }

          klass.new(values)

        else
          fail Vedeu::Error::InvalidSyntax,
               "Cannot coerce as value is not an Array, #{klass} " \
               "or Vedeu::Models::Row. Is a '#{value.class.name}'."

        end
      end

      private

      # @return [Class]
      def klass
        Vedeu::Models::Page
      end

    end # Page

  end # Coercers

end # Vedeu
