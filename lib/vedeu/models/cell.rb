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

      # Returns a new instance of Vedeu::Models::Cell.
      #
      # @param attributes [Hash<Symbol => Array<Symbol|String>,
      #                                   Fixnum, String, Symbol]
      # @option attributes colour [NilClass|String]
      # @option attributes style
      #   [NilClass|Array<Symbol|String>|Symbol|String]
      # @option attributes value [NilClass|String]
      # @option attributes position [Vedeu::Geometry::Position]
      # @return [Vedeu::Models::Cell]
      def initialize(attributes = {})
        defaults.merge!(attributes).each do |key, value|
          instance_variable_set("@#{key}", value || defaults.fetch(key))
        end
      end

      # An object is equal when its values are the same.
      #
      # @param other [Vedeu::Models::Cell]
      # @return [Boolean]
      def eql?(other)
        self.class == other.class && value == other.value &&
          position == other.position
      end
      alias_method :==, :eql?

      # @return [Vedeu::Geometry::Position]
      def position
        Vedeu::Geometry::Position.coerce(@position)
      end

      # @return [Hash]
      def to_hash
        {
          colour:   colour.to_s,
          style:    style.to_s,
          value:    value.to_s,
          position: position.to_s,
        }
      end

      # @param options [Hash] Ignored.
      # @return [String]
      def to_html(_options = {})
        ''
      end

      # @return [String]
      def to_s
        value.to_s
      end

      private

      # Returns the default options/attributes for this class.
      #
      # @return [Hash<Symbol => void>]
      def defaults
        {
          colour:   nil,
          style:    nil,
          value:    '',
          position: [1, 1],
        }
      end

    end # Cell

  end # Models

end # Vedeu
