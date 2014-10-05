module Vedeu

  # A Viewport is the visible part of an interface; in most cases, the whole
  # interface.
  #
  # When a buffer has more lines than the defined height of
  # the interface, the Viewport class provides 'scrolling' via the cursor's
  # position.
  class Viewport

    attr_reader :cursor

    def initialize(interface)
      @interface = interface

      @cursor = interface.cursor

      @content = Area.new({
        y_min:  @interface.top,
        x_min:  @interface.left,
        y:      @cursor.y,
        x:      @cursor.x,
        height: @interface.lines.size,
        width:  @interface.viewport_width })
      Vedeu.log("Viewport#initialize content: #{@content.inspect}")

      @visible = Area.new({
        y_min:  @content.y_offset,
        x_min:  @content.x_offset,
        y:      @cursor.y,
        x:      @cursor.x,
        height: @interface.viewport_height,
        width:  @interface.viewport_width })
      Vedeu.log("Viewport#initialize visible: #{@visible.inspect}")
    end

    def visible_lines
      interface.lines[@visible.y_min...@visible.y_max]
    end

    private

    attr_reader :interface

  end # Viewport

end # Vedeu
