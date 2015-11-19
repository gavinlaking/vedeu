module Vedeu

  module Geometries

    # The subclasses of this class, HorizontalAlignment and
    # VerticalAlignment provide the mechanism to align an interface or
    # view horizontally or vertically within the available terminal
    # space.
    #
    # @see Vedeu::Geometries::HorizontalAlignment
    # @see Vedeu::Geometries::VerticalAlignment
    #
    # @api private
    #
    class Alignment

      # @param (see #initialize)
      # @return (see #align)
      def self.align(value = nil)
        new(value).align
      end

      # @param value [NilClass|Symbol|Vedeu::Geometries::Alignment]
      # @return [Vedeu::Geometries::Alignment]
      def self.coerce(value = nil)
        if value.is_a?(self)
          value

        elsif value.is_a?(Symbol)
          new(value)

        else
          new(:none)

        end
      end

      # Returns a new instance of Vedeu::Geometries::Alignment.
      #
      # @param value [NilClass|Symbol]
      # @return [Vedeu::Geometries::Alignment]
      def initialize(value = nil)
        @value = value
      end

      # @raise [Vedeu::Error::NotImplemented] Subclasses of this class
      #   must implement this method.
      def align
        fail Vedeu::Error::NotImplemented, 'Subclasses implement this.'.freeze
      end

      # Return a boolean indicating alignment was set to :bottom.
      #
      # @return [Boolean]
      def bottom_aligned?
        value == :bottom
      end

      # Return a boolean indicating alignment was set to :centre.
      #
      # @return [Boolean]
      def centre_aligned?
        value == :centre
      end

      # Return a boolean indicating alignment was set to :left.
      #
      # @return [Boolean]
      def left_aligned?
        value == :left
      end

      # Return a boolean indicating alignment was set to :middle.
      #
      # @return [Boolean]
      def middle_aligned?
        value == :middle
      end

      # Return a boolean indicating alignment was set to :right.
      #
      # @return [Boolean]
      def right_aligned?
        value == :right
      end

      # Return a boolean indicating alignment was set to :top.
      #
      # @return [Boolean]
      def top_aligned?
        value == :top
      end

      # Return a boolean indicating alignment was set to, or is :none.
      #
      # @return [Boolean]
      def unaligned?
        value == :none
      end

      private

      # @return [Boolean]
      def none?
        @value == :none || @value.nil? || !(@value.is_a?(Symbol))
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

  end # Geometries

end # Vedeu
