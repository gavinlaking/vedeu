# frozen_string_literal: true

module Vedeu

  module Coercers

    # Provides the mechanism to convert a value into a
    # {Vedeu::Models::Page}.
    #
    # @api private
    #
    class Page < Vedeu::Coercers::Coercer

      # @macro raise_fatal
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
          incoercible!

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
