module Vedeu

  module Models

    # Represents an invisible escape character sequence.
    #
    class Escape

      # @!attribute [r] value
      # @return [String]
      attr_reader :value

      # Returns a new instance of Vedeu::Models::Escape.
      #
      # @param attributes [String]
      # @option attributes position
      #   [Vedeu::Geometry::Position|Array<Fixnum>]
      # @option attributes value [String]
      # @return [Vedeu::Models::Escape]
      def initialize(attributes = {})
        defaults.merge!(attributes).each do |key, value|
          instance_variable_set("@#{key}", value)
        end
      end

      # @return [NilClass]
      def null
        nil
      end
      alias_method :background, :null
      alias_method :colour,     :null
      alias_method :foreground, :null
      alias_method :style,      :null

      # An object is equal when its values are the same.
      #
      # @param other [Vedeu::Escape]
      # @return [Boolean]
      def eql?(other)
        self.class == other.class && value == other.value
      end
      alias_method :==, :eql?

      # @return [String]
      def position
        Vedeu::Geometry::Position.coerce(@position)
      end

      # Return an empty string as most escape sequences won't make
      # sense as HTML.
      #
      # @param options [Hash] Ignored.
      # @return [String]
      def to_html(options = {})
        ''
      end

<<<<<<< HEAD
      # @return [String]
      def to_s
        "#{position}#{value}"
      end
      alias_method :to_str, :to_s

      private
=======
    # @return [String]
    def to_html
      ''
    end

    # @return [String]
    def to_s
      "#{position}#{value}"
    end
    alias_method :to_str, :to_s
>>>>>>> Add #to_html to Vedeu::Escape.

      # @return [Hash]
      def defaults
        {
          position: [1, 1],
          value:    '',
        }
      end

    end # Escape

  end # Models

end # Vedeu
