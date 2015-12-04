module Vedeu

  module Cells

    # Provides the character/escape sequence to draw one cell of a
    # with a custom value, colour and style.
    #
    # The Vedeu::Cells::Empty object represents an empty cell with no
    # content and is the basis of all the Vedeu::Cells objects.
    #
    # @api private
    #
    class Empty

      include Comparable
      include Vedeu::Common
      include Vedeu::Presentation
      include Vedeu::Repositories::Defaults

      # @!attribute [r] name
      # @return [String|Symbol] The name of the interface/view this
      #   cell belongs to.
      attr_reader :name

      # @!attribute [r] value
      # @return [String]
      attr_reader :value

      # @return [Boolean]
      def cell?
        true
      end

      # An object is equal when its values are the same.
      #
      # @param other [void]
      # @return [Boolean]
      def eql?(other)
        self.class == other.class    &&
          position == other.position &&
          value    == other.value    &&
          colour   == other.colour
      end
      alias_method :==, :eql?

      # @return [String]
      def text
        ' '
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
      alias_method :to_str, :to_s

      private

      # @return [Hash<Symbol => Hash<void>|NilClass|String>]
      def defaults
        {
          colour:   {},
          name:     '',
          position: nil,
          style:    '',
          value:    '',
        }
      end

      # @return [Vedeu::Borders::Border]
      def border
        Vedeu.borders.by_name(name)
      end

      # @return [Vedeu::Geometries::Geometry]
      def geometry
        Vedeu.geometries.by_name(name)
      end

      # @return [Vedeu::Interfaces::Interface]
      def interface
        Vedeu.interfaces.by_name(name)
      end

    end # Empty

  end # Cells

end # Vedeu
