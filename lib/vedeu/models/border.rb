module Vedeu

  #
  #
  # @note Refer to UTF-8 U+2500 to U+257F for border characters. More details
  #   can be found at: http://en.wikipedia.org/wiki/Box-drawing_character
  #
  class Border

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

    def enabled?
      options[:enabled]
    end

    def bottom?
      options[:show_bottom]
    end

    def left?
      options[:show_left]
    end

    def right?
      options[:show_right]
    end

    def top?
      options[:show_top]
    end

    def to_s
      to_viewport.map { |line| line.flatten.join }.join("\n")
    end

    def to_viewport
      return viewport unless enabled?

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

    def left
      return '' unless left?

      vertical_border
    end

    def right
      return '' unless right?

      vertical_border
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
      [*presentation, on, bl, off, *reset].join
    end

    def bottom_right
      [*presentation, on, br, off, *reset].join
    end

    def top_left
      [*presentation, on, tl, off, *reset].join
    end

    def top_right
      [*presentation, on, tr, off, *reset].join
    end

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
      [[*presentation, on, h, off, *reset].join] * width
    end

    def horizontal_space
      [' '] * width
    end

    def vertical_border
      [*presentation, on, v, off, *reset].join
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

    def presentation
      [colour.to_s, style.to_s]
    end

    def reset
      [interface.colour.to_s, interface.style.to_s]
    end

    # Returns a new Colour instance.
    #
    # @return [Colour]
    def colour
      @colour ||= Colour.new(attributes[:colour])
    end

    # Returns a new Style instance.
    #
    # @return [Style]
    def style
      @style ||= Style.new(attributes[:style])
    end

    # The default options for the instance.
    #
    # @return [Hash]
    def default_options
      {
        enabled:     false,
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
