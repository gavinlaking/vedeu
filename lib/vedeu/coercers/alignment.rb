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
      def initialize(value = :none)
        @_value = value || :none
      end

      # Return a boolean indicating alignment was set to :bottom.
      #
      # @return [Boolean]
      def bottom_aligned?
        _value == :bottom
      end

      # Return a boolean indicating alignment was set to :centre.
      #
      # @return [Boolean]
      def centre_aligned?
        _value == :centre
      end

      # An object is equal when its values are the same.
      #
      # @param other [void]
      # @return [Boolean]
      def eql?(other)
        self.class == other.class && value == other.value
      end
      alias_method :==, :eql?

      # Return a boolean indicating alignment was set to :left.
      #
      # @return [Boolean]
      def left_aligned?
        _value == :left
      end

      # Return a boolean indicating alignment was set to :middle.
      #
      # @return [Boolean]
      def middle_aligned?
        _value == :middle
      end

      # Return a boolean indicating alignment was set to :right.
      #
      # @return [Boolean]
      def right_aligned?
        _value == :right
      end

      # Return a boolean indicating alignment was set to :top.
      #
      # @return [Boolean]
      def top_aligned?
        _value == :top
      end

      # Return a boolean indicating alignment was set to, or is :none.
      #
      # @return [Boolean]
      def unaligned?
        _value == :none
      end

      # @return [Symbol]
      def value
        _value
      end

      private

      # @return [Boolean]
      def invalid?
        @_value.nil? || !(@_value.is_a?(Symbol)) || !values.include?(@_value)
      end

      # @return [Symbol]
      def _value
        @value ||= if @_value == :center
                     :centre

                   elsif invalid?
                     :none

                   else
                     @_value

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
