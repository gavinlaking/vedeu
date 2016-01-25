# frozen_string_literal: true

module Vedeu

  module Coercers

    # Provides the mechanism to convert a value into a
    # {Vedeu::Presentation::Style}.
    #
    # @api private
    #
    class Style < Vedeu::Coercers::Coercer

      # @return [void]
      def coerce
        if coerced?
          value

        else


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
