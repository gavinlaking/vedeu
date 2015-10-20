module Vedeu

  module Geometry

    # The subclasses of this class, HorizontalAlignment and
    # VerticalAlignment provide the mechanism to align an interface or
    # view horizontally or vertically within the available terminal
    # space.
    #
    # @see Vedeu::Geometry::HorizontalAlignment
    # @see Vedeu::Geometry::VerticalAlignment
    #
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

      # @raise [Vedeu::Error::NotImplemented] Subclasses of this class
      #   must implement this method.
      def align
        fail Vedeu::Error::NotImplemented, 'Subclasses implement this.'.freeze
      end

      private

      # @return [Boolean]
      def none?
        @value.nil? || !(@value.is_a?(Symbol))
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

                    else
                      @value.to_sym

                    end
      end

      # @return [Array<Symbol>]
      def values
        [
          :bottom,
          :centre,
          :left,
          :middle,
          :none,
          :right,
          :top,
        ]
      end

    end # Alignment

    # Provides the mechanism to align an interface/view horizontally
    # within the available terminal space.
    #
    class HorizontalAlignment < Vedeu::Geometry::Alignment

      # @raise [Vedeu::Error::InvalidSyntax] When the value is not one
      #   of :bottom, :centre, :left, :middle, :right, :top.
      # @return [Symbol]
      def align
        return value if valid?

        fail Vedeu::Error::InvalidSyntax,
             'No horizontal alignment value given. Valid values are :center, ' \
             ':centre, :left, :none, :right.'.freeze
      end

    end # HorizontalAlignment

    # Provides the mechanism to align an interface/view vertically
    # within the available terminal space.
    #
    class VerticalAlignment < Vedeu::Geometry::Alignment

      # @raise [Vedeu::Error::InvalidSyntax] When the value is not one
      #   of :bottom, :centre, :left, :middle, :right, :top.
      # @return [Symbol]
      def align
        return value if valid?

        fail Vedeu::Error::InvalidSyntax,
             'No vertical alignment value given. Valid values are :bottom, ' \
             ':middle, :none, :top.'.freeze
      end

    end # VerticalAlignment

  end # Geometry

end # Vedeu
