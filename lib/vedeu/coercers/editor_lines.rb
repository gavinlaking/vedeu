# frozen_string_literal: true

module Vedeu

  module Coercers

    # Provides the mechanism to convert a value into a
    # {Vedeu::Editor::Lines}.
    #
    # @api private
    #
    class EditorLines < Vedeu::Coercers::Coercer

      # @macro raise_fatal
      # @return [Vedeu::Editor::Lines]
      def coerce
        if coerced?
          klass.new(value.lines)

        elsif array?(value)
          collection = value.map do |line|
            Vedeu::Editor::Line.coerce(line)
          end

          klass.new(collection)

        elsif string?(value)
          collection = value.lines.map(&:chomp).map do |line|
            Vedeu::Editor::Line.coerce(line)
          end

          klass.new(collection)

        else
          klass.new

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
