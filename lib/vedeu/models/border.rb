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

    def to_s
      out = ""

      out << top_border if show_top?

      height.times do
        out << left_border if show_left?
        out << horizontal_space
        out << right_border if show_right?
      end

      out << bottom_border if show_bottom?

      out
    end

    private

    attr_reader :attributes, :interface, :options

    def width
      if show_left? && show_right?
        interface.width - 2

      elsif show_left? || show_right?
        interface.width - 1

      else
        interface.width

      end
    end

    def height
      if show_top? && show_right?
        interface.height - 2

      elsif show_top? || show_bottom?
        interface.height - 1

      else
        interface.height

      end
    end

    def bottom_border
      out = ""
      out << [on, bottom_left, off].join if show_left?
      out << horizontal_border
      out << [on, bottom_right, off].join if show_right?
      out
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
      out = ""
      out << [on, top_left, off].join if show_left?
      out << horizontal_border
      out << [on, top_right, off].join if show_right?
      out
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

    def show_bottom?
      options[:show_bottom]
    end

    def show_left?
      options[:show_left]
    end

    def show_right?
      options[:show_right]
    end

    def show_top?
      options[:show_top]
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
