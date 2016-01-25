# frozen_string_literal: true

module Vedeu

  module Coercers

    # Provides the mechanism to convert a value into a
    # {Vedeu::Views::Streams}.
    #
    # @api private
    #
    class Streams < Vedeu::Coercers::Coercer

      # @return [void]
      def coerce
      end

      private

      # @return [Class]
      def klass
        Vedeu::Views::Streams
      end

    end # Streams

  end # Coercers

end # Vedeu
