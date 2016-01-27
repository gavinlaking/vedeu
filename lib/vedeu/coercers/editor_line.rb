# frozen_string_literal: true

module Vedeu

  module Coercers

    # Provides the mechanism to convert a value into a
    # {Vedeu::Editor::Line}.
    #
    # @api private
    #
    class EditorLine < Vedeu::Coercers::Coercer

      # @return [Vedeu::Editor::Line]
      def coerce
        if coerced?
          value

        elsif string?(value)
          klass.new(value.chomp)

        else
          klass.new

        end
      end

      private

      # @return [Class]
      def klass
        Vedeu::Editor::Line
      end

    end # EditorLine

  end # Coercers

end # Vedeu
