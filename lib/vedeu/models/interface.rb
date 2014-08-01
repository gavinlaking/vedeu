require 'json'
require 'virtus'

require 'vedeu'
require 'vedeu/models/attributes/line_collection'
require 'vedeu/models/presentation'
require 'vedeu/models/style'
require 'vedeu/output/clear_interface'
require 'vedeu/output/render_interface'
require 'vedeu/support/geometry'
require 'vedeu/support/queue'
require 'vedeu/support/terminal'

module Vedeu
  class Interface
    include Vedeu::Queue
    include Virtus.model
    include Presentation
    include Style

    attribute :name,    String
    attribute :lines,   LineCollection
    attribute :y,       Integer, default: 1
    attribute :x,       Integer, default: 1
    attribute :width,   Integer, default: Terminal.width
    attribute :height,  Integer, default: Terminal.height
    attribute :current, String,  default: ''
    attribute :cursor,  Boolean, default: true
    attribute :centred, Boolean, default: false
    attribute :delay,   Float,   default: 0

    def initialize(attributes = {})
      super

      Vedeu.events.on(:refresh, self.delay) { refresh }

      self
    end

    def clear
      @_clear ||= ClearInterface.call(self)
    end

    def enqueue
      super(self.to_s)
    end

    def geometry
      @_geometry ||= Geometry.new(attributes)
    end

    def origin(index = 0)
      geometry.origin(index)
    end

    def refresh
      if enqueued?
        self.current = dequeue

      elsif no_content?
        self.current = clear

      else
        self.current

      end
      Terminal.output(self.current)

      self.current
    end

    def to_json(*args)
      {
        colour: colour,
        style:  style_original,
        name:   name,
        lines:  lines,
        y:      y,
        x:      x,
        width:  width,
        height: height,
        cursor: cursor
      }.to_json
    end

    def to_s
      RenderInterface.call(self)
    end

    private

    def no_content?
      self.current.nil? || self.current.empty?
    end
  end
end
