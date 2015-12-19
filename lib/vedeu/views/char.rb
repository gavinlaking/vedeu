require 'vedeu/geometries/positionable'

module Vedeu

  module Views

    # A Char represents a single character of the terminal. It is a
    # container for the a single character in a
    # {Vedeu::Views::Stream}.
    #
    # Though a multi-character String can be passed as a value, only
    # the first character is returned in the escape sequence.
    #
    class Char

      include Comparable
      include Vedeu::Repositories::Parent
      include Vedeu::Presentation

      # @!attribute [rw] border
      # @return [NilClass|Symbol]
      attr_accessor :border

      # @!attribute [rw] name
      # @return [String|Symbol]
      attr_accessor :name

      # @!attribute [rw] parent
      # @return [Vedeu::Views::Line]
      attr_accessor :parent

      # @!attribute [w] value
      # @return [String]
      attr_writer :value

      # Returns a new instance of Vedeu::Views::Char.
      #
      # @param attributes [Hash]
      # @option attributes border [NilClass|Symbol]
      #   A symbol representing the border 'piece' this
      #   {Vedeu::Views::Char} represents.
      # @option attributes colour [Vedeu::Colours::Colour]
      # @option attributes name [String|Symbol]
      # @option attributes parent [Vedeu::Views::Line]
      # @option attributes position [Vedeu::Geometries::Position]
      # @option attributes style [Vedeu::Presentation::Style]
      # @option attributes value [String]
      # @return [Vedeu::Views::Char]
      def initialize(attributes = {})
        defaults.merge!(attributes).each do |key, value|
          instance_variable_set("@#{key}", value)
        end
      end

      # @return [Hash<Symbol => void>]
      def attributes
        {
          border:   @border,
          colour:   colour,
          name:     @name,
          parent:   @parent,
          position: position,
          style:    @style,
          value:    value,
        }
      end

      # @return [Boolean]
      def cell?
        false
      end

      # When {Vedeu::Output::Viewport#show} has less lines that
      # required to fill the visible area of the interface, it creates
      # a line that contains a single {Vedeu::Views::Char} containing
      # a space (0x20); later, attempts to call `#chars` on an
      # expected {Vedeu::Views::Line} and fail; this method fixes that.
      #
      # @return [Array]
      def chars
        []
      end

      # An object is equal when its values are the same.
      #
      # @param other [Vedeu::Views::Char]
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

      # @return [String]
      def value
        return @value unless border

        Vedeu::EscapeSequences::Esc.border { @value }
      end

      # @return [String]
      def text
        if border
          ' '
        else
          @value
        end
      end

      # Returns a Hash of all the values before coercion.
      #
      # @note
      #   From this hash we should be able to construct a new instance
      #   of {Vedeu::Views::Char}, however, at the moment, `:parent`
      #   cannot be coerced.
      #
      # @return [Hash<Symbol => Hash, String>]
      def to_hash
        {
          border:   border.to_s,
          colour:   colour_to_hash,
          name:     name.to_s,
          parent:   parent_to_hash,
          position: position.to_h,
          style:    style.to_s,
          value:    value,
        }
      end

      # @param options [Hash<Symbol => String>]
      #   See {Vedeu::Views::HTMLChar#initialize}
      # @return [String]
      def to_html(options = {})
        @to_html ||= Vedeu::Views::HTMLChar.render(self, options)
      end

      private

      # @return [Hash<Symbol => String>]
      def colour_to_hash
        {
          background: background.to_s,
          foreground: foreground.to_s,
        }
      end

      # @return [Hash<Symbol => void>]
      def defaults
        {
          border:   nil,
          colour:   nil,
          name:     nil,
          parent:   nil,
          position: nil,
          style:    nil,
          value:    '',
        }
      end

      # @return [Hash<Symbol => String>]
      def parent_to_hash
        return {} unless parent

        {
          background: parent.background.to_s,
          foreground: parent.foreground.to_s,
          style:      parent.style.to_s,
        }
      end

    end # Char

  end # Views

end # Vedeu
