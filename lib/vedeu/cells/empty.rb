# frozen_string_literal: true

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

      include Vedeu::Presentation
      include Vedeu::Presentation::Colour
      include Vedeu::Presentation::Position
      include Vedeu::Presentation::Styles
      include Vedeu::Repositories::Defaults

      # @!attribute [r] name
      # @macro return_name
      attr_reader :name

      # @!attribute [r] value
      # @return [String]
      attr_reader :value

      # Returns the value represented as HTML.
      #
      # @return [String]
      def as_html
        '&nbsp;'
      end

      # An object is equal when its values are the same.
      #
      # @param other [void]
      # @return [Boolean]
      def eql?(other)
        self.class.equal?(other.class) && position == other.position
      end
      alias == eql?

      # @return [String]
      def text
        ' '
      end

      # @return [String]
      def to_ast
        [
          '[',
          [
            position.to_ast,
            colour.to_ast,
            style.to_ast,
            ":#{type}",
          ].reject(&:empty?).join(' '),
          ']',
        ].join
      end

      # @return [Hash<Symbol => Hash<Symbol => String>, String>]
      def to_h
        {
          name:  name.to_s,
          style: style.to_s,
          type:  type,
          value: value.to_s,
        }.merge!(colour.to_h).merge!(position.to_h)
      end
      alias to_hash to_h

      # Returns the object represented as HTML.
      #
      # @param options [Hash] Options provided by
      #   {Vedeu::Renderers::HTML}.
      # @return [String]
      def to_html(options = {})
        Vedeu::Cells::HTML.new(self, options).to_html
      end

      # @return [Symbol]
      def type
        :empty
      end

      private

      # @macro defaults_method
      def defaults
        {
          colour:   {},
          name:     nil,
          position: nil,
          style:    '',
          value:    '',
        }
      end

      # @macro border_by_name
      def border
        Vedeu.borders.by_name(name)
      end

      # @macro geometry_by_name
      def geometry
        Vedeu.geometries.by_name(name)
      end

      # @macro interface_by_name
      def interface
        Vedeu.interfaces.by_name(name)
      end

    end # Empty

  end # Cells

end # Vedeu
