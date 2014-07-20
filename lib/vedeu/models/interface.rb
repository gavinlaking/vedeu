require 'json'
require 'virtus'

require_relative 'attributes/line_collection'
require_relative 'presentation'
require_relative 'style'
require_relative '../output/interface_renderer'
require_relative '../support/coordinate'
require_relative '../support/queue'
require_relative '../support/terminal'

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
    attribute :z,       Integer, default: 1
    attribute :width,   Integer, default: Terminal.width
    attribute :height,  Integer, default: Terminal.height
    attribute :current, String,  default: ''
    attribute :cursor,  Boolean, default: true
    attribute :centred, Boolean, default: false

    def enqueue
      super(self.to_s)
    end

    def origin(index = 0)
      geometry.origin(index)
    end

    def refresh
      if enqueued?
        self.current = dequeue

      elsif no_content?
        self.current = clear_interface

      else
        self.current

      end
    end

    def to_json(*args)
      {
        colour: colour,
        style:  style_original,
        name:   name,
        lines:  lines,
        y:      y,
        x:      x,
        z:      z,
        width:  width,
        height: height,
        cursor: cursor
      }.to_json
    end

    def to_s
      clear_interface + render_content
    end

    private

    def no_content?
      self.current.nil? || self.current.empty?
    end

    def render_content
      InterfaceRenderer.render(self)
    end

    def clear_interface
      InterfaceRenderer.clear(self)
    end

    def geometry
      @_geometry ||= Coordinate.new(attributes)
    end
  end
end
