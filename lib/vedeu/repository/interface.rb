module Vedeu
  class Interface
    include Queue

    attr_accessor :attributes, :name, :cursor, :current

    def initialize(attributes = {})
      @attributes = attributes || {}
      @name       = attributes[:name]
      @cursor     = attributes.fetch(:cursor, true)
      @current    = []
    end

    # :nocov:
    def refresh
      if enqueued?
        @current = dequeue
      elsif @current.empty?
        Compositor.arrange(initial_state)

        @current = dequeue
      else
        @current
      end
    end
    # :nocov:

    def geometry
      @geometry ||= Geometry.new(attributes)
    end

    def colour
      @colour ||= Colour.new([foreground, background])
    end

    def cursor
      @cursor ? Cursor.show : Cursor.hide
    end

    def layer
      @layer ||= Layer.new(layer_attr).index
    end

    private

    def initial_state
      { name => Array.new(geometry.height) { [{ text: '' }] } }
    end

    def layer_attr
      attributes.fetch(:layer, 0)
    end

    def foreground
      attributes[:fg] || attributes[:foreground]
    end

    def background
      attributes[:bg] || attributes[:background]
    end
  end
end
