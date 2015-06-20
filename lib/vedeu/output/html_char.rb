require 'vedeu/support/common'

module Vedeu

  # Represents a {Vedeu::Char} as a HTML table cell.
  class HTMLChar

    include Vedeu::Common

    # @param char [Vedeu::Char]
    # @return [String]
    def self.render(char)
      new(char).render
    end

    # Returns a new instance of Vedeu::HTMLChar.
    #
    # @param char [Vedeu::Char]
    # @return [Vedeu::HTMLChar]
    def initialize(char)
      @char = char
    end

    # @return [String]
    def render
      "<td#{td_style}>#{td_value}</td>"
    end

    protected

    # @!attribute [r] char
    # @return [Vedeu::Char]
    attr_reader :char

    private

    # @return [String]
    def td_style
      return '' unless border || present?(value)

      " style='" \
      "background:#{bg};" \
      "color:#{fg};" \
      "border:1px #{bg} solid;" \
      "#{border_style}'"
    end

    # @return [String]
    def td_value
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
      when :top_left     then [css('top'), css('left')].join
      when :top_right    then [css('top'), css('right')].join
      when :bottom_left  then [css('bottom'), css('left')].join
      when :bottom_right then [css('bottom'), css('right')].join
      else
        ''
      end
    end

    # @return [String]
    def css(direction = '')
      "border-#{direction}:1px #{fg} solid;"
    end

    # @return [String]
    def fg
      @fg ||= colour_fg
    end

    # @return [String]
    def bg
      @bg ||= colour_bg
    end

    # @return [String]
    def colour_bg
      colour(char, 'background', '#000')
    end

    # @return [String]
    def colour_fg
      colour(char, 'foreground', '#222')
    end

    # @param char []
    # @param type [String]
    # @param default [String]
    # @return [String]
    def colour(char, type, default)
      parent_type         = ('parent_' + type).to_sym
      type_to_html        = char.send(type).send(:to_html)
      parent_type_to_html = char.send(parent_type).send(:to_html)

      if present?(type_to_html)
        type_to_html

      elsif present?(parent_type_to_html)
        parent_type_to_html

      else
        default

      end
    end

    # @return [Symbol|NilClass]
    def border
      char.border
    end

    # @return [String]
    def value
      char.value
    end

  end # HTMLChar

end # Vedeu
