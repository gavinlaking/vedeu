module Vedeu

  module Geometry

    class Alignment

      # @param (see #initialize)
      # @return (see #align)
      def self.align(value = nil)
        new(value).align
      end

      # @param value [NilClass|Symbol]
      # @return [Vedeu::Geometry::Alignment]
      def initialize(value = nil)
        @value = value
      end

      # @raise [Vedeu::Error::InvalidSyntax] When the value is not one
      #   of :centre, :left, :right
      # @return [Symbol]
      def align
        return value if valid?

        fail Vedeu::Error::InvalidSyntax,
             'Cannot align as value is invalid or undefined.'.freeze
      end

      private

      # @return [Boolean]
      def align_value?
        @value.to_s.start_with?('align_')
      end

      # @return [Symbol]
      def coerced_value
        coerced = @value.to_s.gsub!('align_', '').to_sym

        coerced == :center ? :centre : coerced
      end

      # @return [Boolean]
      def none?
        @value.nil? || !(@value.is_a?(Symbol)) || @value == :alignment
      end

      # @return [Boolean]
      def valid?
        values.include?(value)
      end

      # @return [Symbol]
      def value
        @_value ||= if none?
                      :none

                    elsif @value == :center
                      :centre

                    elsif align_value?
                      coerced_value

                    else
                      @value.to_sym

                    end
      end

      # @return [Array<Symbol>]
      def values
        [
          :centre,
          :left,
          :none,
          :right,
        ]
      end

    end # Alignment

  end # Geometry

end # Vedeu
