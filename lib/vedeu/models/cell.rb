module Vedeu

  module Models

    # A Cell represents a single square of the terminal.
    #
    # @api private
    #
    class Cell

      include Vedeu::Repositories::Defaults

      # @!attribute [r] colour
      # @return [NilClass|String]
      attr_reader :colour

      # @!attribute [r] name
      # @return [String|Symbol]
      attr_reader :name

      # @!attribute [r] style
      # @return [NilClass|Array<Symbol|String>|Symbol|String]
      attr_reader :style

      # @!attribute [r] value
      # @return [NilClass|String]
      attr_reader :value

      # @return [Boolean]
      def cell?
        true
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

      # @return [Vedeu::Interfaces::Interface]
      def interface
        @interface ||= Vedeu.interfaces.by_name(name)
      end

      # @return [Vedeu::Geometries::Position]
      def position
        Vedeu::Geometries::Position.coerce(@position)
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

      # @param _options [Hash] Ignored.
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
          name:     nil,
          style:    nil,
          value:    '',
          position: [1, 1],
        }
      end

    end # Cell

  end # Models

end # Vedeu
