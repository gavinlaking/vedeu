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

      include Comparable
      include Vedeu::Presentation
      include Vedeu::Repositories::Defaults

      # @!attribute [r] name
      # @return [String|Symbol] The name of the interface/view this
      #   cell belongs to.
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

      # @return [String]
      def to_ast
        [
          '[',
          [
            position.to_ast,
            colour.to_ast,
            style.to_ast,
            ":#{type}",
          ].reject { |v| v.empty? }.join(' '),
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
      alias_method :to_hash, :to_h

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
