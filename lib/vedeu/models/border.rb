module Vedeu

  #
  #
  # @note Refer to UTF-8 U+2500 to U+257F for border characters. More details
  #   can be found at: http://en.wikipedia.org/wiki/Box-drawing_character
  #
  class Border

    include Presentation

    # Returns a new instance of Border.
    #
    # @param interface [Interface]
    # @param attributes [Hash]
    # @return [Border]
    def initialize(interface, attributes = {})
      @interface  = interface
      @attributes = defaults.merge(attributes)
    end

    def to_s
      out = ""

      out << top_border

      height.times do
        out << left_border
        out << horizontal_space
        out << right_border
      end

      out << bottom_border

      out
    end

    private

    attr_reader :attributes, :interface

    def width
      interface.width - 2
    end

    def height
      interface.height - 2
    end

    def bottom_border
      [on, bottom_left, off, horizontal_border, on, bottom_right, off].join
    end

    def horizontal_border
      ([on, horizontal, off] * width).join
    end

    def horizontal_space
      ' ' * width
    end

    def vertical_border
      [on, vertical, off].join
    end
    alias_method :left_border,  :vertical_border
    alias_method :right_border, :vertical_border

    def top_border
      [on, top_left, off, horizontal_border, on, top_right, off].join
    end

    def horizontal
      attributes[:horizontal]
    end

    def vertical
      attributes[:vertical]
    end

    def top_right
      attributes[:top_right]
    end

    def top_left
      attributes[:top_left]
    end

    def bottom_right
      attributes[:bottom_right]
    end

    def bottom_left
      attributes[:bottom_left]
    end

    def on
      "\e(0"
    end

    def off
      "\e(B"
    end

    # The default values for a new instance of Border.
    #
    # @return [Hash]
    def defaults
      {
        bottom_right: "\x6A", # ┘
        top_right:    "\x6B", # ┐
        top_left:     "\x6C", # ┌
        bottom_left:  "\x6D", # └
        horizontal:   "\x71", # ─
        colour:       {},
        style:        [],
        vertical:     "\x78", # │
      }
    end

  end # Border

end # Vedeu
