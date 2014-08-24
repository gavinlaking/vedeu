module Vedeu
  class Interface

    extend Forwardable

    def_delegators :geometry, :north, :east, :south, :west,
                              :top, :right, :bottom, :left,
                              :width, :height, :origin,
                              :viewport_width, :viewport_height

    # @param  []
    # @param []
    # @return []
    def self.build(attributes = {}, &block)
      new(attributes, &block).attributes
    end

    # @param  []
    # @param []
    # @return []
    def initialize(attributes = {}, &block)
      @attributes = attributes

      if block_given?
        @self_before_instance_eval = eval('self', block.binding)

        instance_eval(&block)
      end
    end

    # @return []
    def attributes
      @_attributes ||= defaults.merge!(@attributes)
    end

    # @return []
    def name
      @name ||= attributes[:name]
    end

    # @return []
    def group
      @group ||= attributes[:group]
    end

    # @return []
    def lines
      @lines ||= Attributes.coercer(attributes[:lines], Line, :streams)
    end

    # @return []
    def colour
      @colour ||= Colour.new(attributes[:colour])
    end

    # @return []
    def style
      @style ||= Attributes.coerce_styles(attributes[:style])
    end

    # @return []
    def geometry
      @geometry ||= Geometry.new(attributes[:geometry])
    end

    # @return []
    def cursor
      @cursor ||= if cursor?
        Esc.string('show_cursor')

      else
        Esc.string('hide_cursor')

      end
    end

    # @return []
    def delay
      @delay || attributes[:delay]
    end

    # @return []
    def to_s
      Render.call(self)
    end
    alias_method :render, :to_s

    # @return []
    def clear
      Clear.call(self)
    end

    private

    def cursor?
      attributes[:cursor] == true
    end

    def defaults
      {
        name:     '',
        group:    '',
        lines:    [],
        colour:   {},
        style:    '',
        geometry: {},
        cursor:   true,
        delay:    0.0
      }
    end

  end
end
