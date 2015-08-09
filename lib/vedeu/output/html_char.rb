module Vedeu

  # Represents a {Vedeu::Views::Char} as a HTML tag with value. By default, a
  # table cell is used.
  #
  class HTMLChar

    include Vedeu::Common

    # @param char [Vedeu::Views::Char]
    # @param options [Hash<Symbol => String>]
    # @option options start_tag [String]
    # @option options end_tag [String]
    # @return [String]
    def self.render(char, options = {})
      new(char, options).render
    end

    # Returns a new instance of Vedeu::HTMLChar.
    #
    # @param char [Vedeu::Views::Char]
    # @param options [Hash<Symbol => String>]
    # @option options start_tag [String]
    # @option options end_tag [String]
    # @return [Vedeu::HTMLChar]
    def initialize(char, options = {})
      @char    = char
      @options = options
    end

    # @return [String]
    def render
      "#{start_tag}#{tag_style}>#{tag_value}#{end_tag}"
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
        "background:#{char.background.to_html};"
    end

    # @return [String]
    def tag_style_foreground
      "color:#{char.foreground.to_html};#{border_style}"
    end

    # @return [String]
    def tag_value
      return '&nbsp;' if border || !present?(value)

      value
    end

    # @return [String]
    def border_style
      case border
      when :top_horizontal    then css('top')
      when :left_vertical     then css('left')
      when :right_vertical    then css('right')
      when :bottom_horizontal then css('bottom')
      when :top_left     then "#{css('top')}#{css('left')}"
      when :top_right    then "#{css('top')}#{css('right')}"
      when :bottom_left  then "#{css('bottom')}#{css('left')}"
      when :bottom_right then "#{css('bottom')}#{css('right')}"
      else
        ''
      end
    end

    # @return [String]
    def css(direction = '')
      "border-#{direction}:1px #{char.foreground.to_html} solid;"
    end

    # # @return [String]
    # def fg
    #   @fg ||= colour(char, 'foreground', '#222')
    # end

    # # @return [String]
    # def bg
    #   @bg ||= colour(char, 'background', '#000')
    # end

    # @param char [Vedeu::Views::Char]
    # @param type [String] 'background' or 'foreground'
    # @param default [String] A default colour (CSS style; e.g. '#b2adf2')
    # @return [String]
    # def colour(char, type, default)
    #   parent_type         = char.send(:parent).send(type).send(:to_html)
    #   #parent_type         = ('parent_' + type).to_sym
    #   type_to_html        = char.send(type).send(:to_html)
    #   #parent_type_to_html = char.send(parent_type).send(:to_html)

    #   if present?(type_to_html)
    #     type_to_html

    #   elsif char.parent
    #     parent_type
    #     #char.parent.send(type).send(:to_html)

    #   else
    #     default

    #   end
    # end

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

end # Vedeu
