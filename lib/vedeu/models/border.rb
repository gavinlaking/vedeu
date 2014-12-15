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
    # @param options [Hash]
    # @return [Border]
    def initialize(interface, attributes = {}, options = {})
      @interface  = interface
      @attributes = defaults.merge(attributes)
      @options    = default_options.merge(options)
    end

    def bottom?
      options[:show_bottom]
    end

    def bottom
      return [] unless bottom?

      out = []

      out << bottom_left if left?
      horizontal_border.each do |border|
        out << border
      end
      out << bottom_right if right?

      out
    end

    def left?
      options[:show_left]
    end

    def left
      return '' unless left?

      vertical_border
    end

    def right?
      options[:show_right]
    end

    def right
      return '' unless right?

      vertical_border
    end

    def top?
      options[:show_top]
    end

    def top
      return [] unless top?

      out = []
      out << top_left if left?
      horizontal_border.each do |border|
        out << border
      end
      out << top_right if right?

      out
    end

    def bottom_left
      [on, bl, off].join
    end

    def bottom_right
      [on, br, off].join
    end

    def top_left
      [on, tl, off].join
    end

    def top_right
      [on, tr, off].join
    end

    def to_s
      to_viewport.map { |line| line.flatten.join }.join("\n")
    end

    def to_viewport
      out = []

      out << top if top?

      viewport[0...height].each do |line|
        out << [left, line[0...width], right].flatten
      end

      out << bottom if bottom?

      out
    end

    private

    attr_reader :attributes, :interface, :options

    def width
      if left? && right?
        interface.width - 2

      elsif left? || right?
        interface.width - 1

      else
        interface.width

      end
    end

    def height
      if top? && bottom?
        interface.height - 2

      elsif top? || bottom?
        interface.height - 1

      else
        interface.height

      end
    end

    def horizontal_border
      [[on, h, off].join] * width
    end

    def horizontal_space
      [' '] * width
    end

    def vertical_border
      [on, v, off].join
    end

    def h
      attributes[:horizontal]
    end

    def v
      attributes[:vertical]
    end

    def tr
      attributes[:top_right]
    end

    def tl
      attributes[:top_left]
    end

    def br
      attributes[:bottom_right]
    end

    def bl
      attributes[:bottom_left]
    end

    def on
      "\e(0"
    end

    def off
      "\e(B"
    end

    def viewport
      interface.viewport
    end

    # The default options for the instance.
    #
    # @return [Hash]
    def default_options
      {
        show_bottom: true,
        show_left:   true,
        show_right:  true,
        show_top:    true,
      }
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
