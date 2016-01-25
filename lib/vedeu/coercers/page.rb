# frozen_string_literal: true

module Vedeu

  module Coercers

    # Provides the mechanism to convert a value into a
    # {Vedeu::Models::Page}.
    #
    # @api private
    #
    class Page < Vedeu::Coercers::Coercer

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
        Vedeu::Models::Page
      end

    end # Page

  end # Coercers

end # Vedeu
