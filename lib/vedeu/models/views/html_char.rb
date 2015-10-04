module Vedeu

  module Views

    # Represents a {Vedeu::Views::Char} as a HTML tag with value. By
    # default, a table cell is used.
    #
    class HTMLChar

      include Vedeu::Common

      # @param (see #initialize)
      # @return [String]
      def self.render(char, options = {})
        new(char, options).render
      end

      # Returns a new instance of Vedeu::Views::HTMLChar.
      #
      # @param char [Vedeu::Views::Char]
      # @param options [Hash<Symbol => String>]
      # @option options start_tag [String]
      # @option options end_tag [String]
      # @return [Vedeu::Views::HTMLChar]
      def initialize(char, options = {})
        @char    = char
        @options = options
      end

      # @return [String]
      def render
        "#{start_tag}#{tag_style}>#{tag_value}#{end_tag}".freeze
      end

      protected

      # @!attribute [r] char
      # @return [Vedeu::Views::Char]
      attr_reader :char

      private

      # @return [String]
      def tag_style
        return '' unless border || present?(value)

        out = " style='"
        out << tag_style_background unless char.background.empty?
        out << tag_style_foreground unless char.foreground.empty?
        out << "'"
      end

      # @return [String]
      def tag_style_background
        "border:1px #{char.background.to_html} solid;" \
          "background:#{char.background.to_html};".freeze
      end

      # @return [String]
      def tag_style_foreground
        "color:#{char.foreground.to_html};#{border_style}".freeze
      end

      # @return [String]
      def tag_value
        return '&nbsp;'.freeze if border || !present?(value)

        value
      end

      # @return [String]
      def border_style
        case border
        when :top_horizontal    then css(:top)
        when :left_vertical     then css(:left)
        when :right_vertical    then css(:right)
        when :bottom_horizontal then css(:bottom)
        when :top_left     then "#{css(:top)}#{css(:left)}".freeze
        when :top_right    then "#{css(:top)}#{css(:right)}".freeze
        when :bottom_left  then "#{css(:bottom)}#{css(:left)}".freeze
        when :bottom_right then "#{css(:bottom)}#{css(:right)}".freeze
        else
          ''
        end
      end

      # @param direction [Symbol]
      # @return [String]
      def css(direction)
        "border-#{direction}:1px #{char.foreground.to_html} solid;".freeze
      end

      # @return [Symbol|NilClass]
      def border
        char.border
      end

      # @return [String]
      def value
        char.value
      end

      # @return [String]
      def start_tag
        options[:start_tag]
      end

      # @return [String]
      def end_tag
        options[:end_tag]
      end

      # @return [Hash<Symbol => String>]
      def options
        defaults.merge!(@options)
      end

      # @return [Hash<Symbol => String>]
      def defaults
        {
          start_tag: '<td',
          end_tag:   '</td>',
        }
      end

    end # HTMLChar

  end # Views

end # Vedeu
