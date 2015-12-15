module Vedeu

  module Coercers

    # The subclasses of this class, HorizontalAlignment and
    # VerticalAlignment provide the mechanism to validate a horizontal
    # or vertical alignment value.
    #
    # @see Vedeu::Coercers::HorizontalAlignment
    # @see Vedeu::Coercers::VerticalAlignment
    #
    # @api private
    #
    class Alignment

      # @param value [NilClass|Symbol|Vedeu::Coercers::Alignment]
      # @return [Vedeu::Coercers::Alignment]
      def self.coerce(value = nil)
        if value.is_a?(self)
          value

        elsif value.is_a?(Symbol)
          new(value)

        else
          new(:none)

        end
      end

      # Returns a new instance of Vedeu::Coercers::Alignment.
      #
      # @param value [NilClass|Symbol]
      # @return [Vedeu::Coercers::Alignment]
      def initialize(value = nil)
        @value = value
      end

      # @return [Symbol]
      def align
        value
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
      def invalid?
        @value.nil? || !(@value.is_a?(Symbol)) || !values.include?(@value)
      end

      # @return [Symbol]
      def value
        @_value ||= if @value == :center
                      :centre

                    elsif invalid?
                      :none

                    else
                      @value

                    end
      end

      # @return [Array<Symbol>]
      def values
        [
          :bottom,
          :centre,
          :center,
          :left,
          :middle,
          :none,
          :right,
          :top,
        ]
      end

    end # Alignment

  end # Coercers

end # Vedeu
