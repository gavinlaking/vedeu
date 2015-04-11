require 'vedeu/support/common'

module Vedeu

  # Represents a {Vedeu::Char} as a HTML table cell.
  #
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

    private

    # @!attribute [r] char
    # @return [Vedeu::Char]
    attr_reader :char

    # @return [String]
    def td_style
      return '' unless border || defined_value?(value)

      " style='" \
      "background:#{bg};" \
      "color:#{fg};" \
      "border:1px #{bg} solid;" \
      "#{border_style}'"
    end

    # @return [String]
    def td_value
      return '&nbsp;' if border || !defined_value?(value)

      value
    end

    # @return [String]
    def border_style
      case border
      when :top_horizontal    then border_css('top')
      when :left_vertical     then border_css('left')
      when :right_vertical    then border_css('right')
      when :bottom_horizontal then border_css('bottom')
      when :top_left     then [border_css('top'), border_css('left')].join
      when :top_right    then [border_css('top'), border_css('right')].join
      when :bottom_left  then [border_css('bottom'), border_css('left')].join
      when :bottom_right then [border_css('bottom'), border_css('right')].join
      else
        ''
      end
    end

    # @return [String]
    def border_css(direction = '')
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
      if defined_value?(char.background.to_html)
        char.background.to_html

      elsif defined_value?(char.parent_background.to_html)
        char.parent_background.to_html

      else
        '#000'

      end
    end

    # @return [String]
    def colour_fg
      if defined_value?(char.foreground.to_html)
        char.foreground.to_html

      elsif defined_value?(char.parent_foreground.to_html)
        char.parent_foreground.to_html

      else
        '#222'

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
