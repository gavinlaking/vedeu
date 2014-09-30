module Vedeu

  # A Viewport is the visible part of an interface; in most cases, the whole
  # interface.
  #
  # When a buffer has more lines than the defined height of
  # the interface, the Viewport class provides 'scrolling' via the cursor's
  # position.
  class Viewport

    def initialize(interface)
      @interface = interface
    end

    def visible_lines
      lines[offset.y_offset...(offset.y_offset + interface.viewport_height)]
    end

    private

    attr_reader :interface

    def lines
      interface.lines
    end

    def offset
      @offset ||= CursorOffset.new(interface)
    end

  end
end

