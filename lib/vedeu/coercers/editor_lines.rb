# frozen_string_literal: true

module Vedeu

  module Coercers

    # Provides the mechanism to convert a value into a
    # {Vedeu::Editor::Lines}.
    #
    # @api private
    #
    class EditorLines < Vedeu::Coercers::Coercer

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
        Vedeu::Editor::Lines
      end

    end # EditorLines

  end # Coercers

end # Vedeu
