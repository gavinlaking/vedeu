module Vedeu

  # A Viewport is the visible part of the content within an interface.
  #
  # When a buffer has more lines than the defined height, or more columns than
  # the defined width of the interface, the Viewport class provides 'scrolling'
  # via the cursor's position.
  #
  class Viewport

    extend Forwardable

    def_delegators :interface, :content, :height, :offset, :width

    # @see Viewport#show
    def self.show(interface)
      new(interface).show
    end

    # Returns an instance of Viewport.
    #
    # @param interface [Interface] An instance of interface.
    # @return [Viewport]
    def initialize(interface)
      @interface = interface
      @top       = 0
      @left      = 0
    end

    # Returns the visible content for the interface.
    #
    # @return [Array]
    def show
      line_adjustment
      column_adjustment

      return [] unless content?

      content[lines].map { |line| line.chars[columns] }.compact
    end

    private

    attr_reader :interface

    # Scrolls the content vertically when the stored y offset for the interface
    # is outside of the visible area.
    #
    # @return [Fixnum]
    def line_adjustment
      if offset.y < lines.min
        set_top(offset.y)

      elsif offset.y > lines.max
        set_top(offset.y - (lines.max - lines.min))

      else
        # @top does not need adjusting

      end
    end

    # Scrolls the content horizontally when the stored x offset for the
    # interface is outside of the visible area.
    #
    # @return [Fixnum]
    def column_adjustment
      if offset.x < columns.min
        set_left(offset.x)

      elsif offset.x > columns.max
        set_left(offset.x - (columns.max - columns.min))

      else
        # @left does not need adjusting

      end
    end

    # @param value [Fixnum]
    # @return [Fixnum]
    def set_top(value)
      @top = [[value, (content_height - height)].min, 0].max
    end

    # @param value [Fixnum]
    # @return [Fixnum]
    def set_left(value)
      @left = [value, 0].max
    end

    # @return [Range]
    def lines
      @top..(@top + height - 1)
    end

    # @return [Range]
    def columns
      @left..(@left + width - 1)
    end

    # Returns the height of the content, or when no content, the visible height
    # of the interface.
    #
    # @return [Fixnum]
    def content_height
      return height unless content?

      [content.size, height].max
    end

    # Returns the width of the content, or when no content, the visible width of
    # the interface.
    #
    # @return [Fixnum]
    def content_width
      return width unless content?

      [content_maximum_line_length, width].max
    end

    # Returns the character length of the longest line for this interface.
    #
    # @return [Fixnum]
    def content_maximum_line_length
      content.map { |line| line.size }.max
    end

    # Return a boolean indicating whether this interface currently has content.
    #
    # @return [Boolean]
    def content?
      content.any?
    end

  end # Viewport

end # Vedeu
