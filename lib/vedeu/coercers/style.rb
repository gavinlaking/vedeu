# frozen_string_literal: true

module Vedeu

  module Coercers

    # Provides the mechanism to convert a value into a
    # {Vedeu::Presentation::Style}.
    #
    # @api private
    #
    class Style < Vedeu::Coercers::Coercer

      # Produces new objects of the correct class from the value,
      # ignores objects that have already been coerced.
      #
      # @return [Vedeu::Presentation::Style]
      def coerce
        if coerced?
          value

        elsif value.is_a?(Hash)
          if present?(value[:style])
            if value[:style].is_a?(klass)
              value[:style]

            else
              Vedeu::Coercers::Style.coerce(value[:style])

            end

          else
            klass.new

          end

        else
          klass.new(value)

        end
      end

      private

      # @return [Class]
      def klass
        Vedeu::Presentation::Style
      end

    end # Style

  end # Coercers

end # Vedeu
