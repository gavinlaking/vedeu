module Vedeu

  module Models

    # A Cell represents a single square of the terminal.
    #
    class Cell

      # @!attribute [r] colour
      # @return [NilClass|String]
      attr_reader :colour

      # @!attribute [r] style
      # @return [NilClass|Array<Symbol|String>|Symbol|String]
      attr_reader :style

      # @!attribute [r] value
      # @return [NilClass|String]
      attr_reader :value

      # @!attribute [r] x
      # @return [NilClass|Fixnum]
      attr_reader :x

      # @!attribute [r] y
      # @return [NilClass|Fixnum]
      attr_reader :y

      # Returns a new instance of Vedeu::Models::Cell.
      #
      # @param attributes [Hash<Symbol => Array<Symbol|String>,
      #                                   Fixnum, String, Symbol]
      # @option attributes colour [NilClass|String]
      # @option attributes style
      #   [NilClass|Array<Symbol|String>|Symbol|String]
      # @option attributes value [NilClass|String]
      # @option attributes x [NilClass|Fixnum]
      # @option attributes y [NilClass|Fixnum]
      # @return [Vedeu::Models::Cell]
      def initialize(attributes = {})
        @attributes = defaults.merge!(attributes)

        @attributes.each do |key, value|
          instance_variable_set("@#{key}", value)
        end
      end

      # An object is equal when its values are the same.
      #
      # @param other [Vedeu::Models::Cell]
      # @return [Boolean]
      def eql?(other)
        self.class == other.class && value == other.value && x == other.x &&
          y == other.y
      end
      alias_method :==, :eql?

      # @param options [Hash] Ignored.
      # @return [String]
      def to_html(options = {})
        ''
      end

      private

      # Returns the default options/attributes for this class.
      #
      # @return [Hash<Symbol => void>]
      def defaults
        {
          colour: nil,
          style:  nil,
          value:  nil,
          x:      nil,
          y:      nil,
        }
      end

    end # Cell

  end # Models

end # Vedeu
