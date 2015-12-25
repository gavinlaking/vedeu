# frozen_string_literal: true

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

      include Vedeu::Common

      # @!attribute [r] value
      # @return [Symbol]
      attr_reader :value

      # @param value [Symbol|Vedeu::Coercers::Alignment]
      # @return [Vedeu::Coercers::Alignment]
      def self.coerce(value = :none)
        return value if value.is_a?(self)

        new(value).coerce
      end

      # Returns a new instance of Vedeu::Coercers::Alignment.
      #
      # @param value [Symbol]
      # @return [Vedeu::Coercers::Alignment]
      def initialize(value = :none)
        @value = value || :none
      end

      # @return [Symbol]
      def coerce
        if value == :center
          @value = :centre

        elsif invalid?
          @value = :none

        end

        self
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

      # An object is equal when its values are the same.
      #
      # @param other [void]
      # @return [Boolean]
      def eql?(other)
        self.class == other.class && value == other.value
      end
      alias_method :==, :eql?

      # @return [Boolean]
      def invalid?
        !valid?
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

      # Return a boolean indicating the value is a valid alignment.
      #
      # @return [Boolean]
      def valid?
        present?(value) && value.is_a?(Symbol) && values.include?(value)
      end

      private

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
