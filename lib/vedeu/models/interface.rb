require 'virtus'

require_relative 'presentation'
require_relative 'line_collection'
require_relative '../output/interface_renderer'
require_relative '../support/esc'
require_relative '../support/queue'
require_relative '../support/terminal'

module Vedeu
  class Interface
    include Virtus.model
    include Presentation
    include Vedeu::Queue

    attribute :name,    String
    attribute :lines,   LineCollection
    attribute :y,       Integer, default: 1
    attribute :x,       Integer, default: 1
    attribute :z,       Integer, default: 1
    attribute :width,   Integer, default: Terminal.width
    attribute :height,  Integer, default: Terminal.height
    attribute :current, String,  default: ''
    attribute :cursor,  Boolean, default: true

    def geometry
      @geometry ||= Geometry.new(self)
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

    def to_json
      Oj.dump(json_attributes, mode: :compat)
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

    def json_attributes
      {
        colour: colour, # TODO: translate back?
        style:  style,
        name:   name,
        lines:  lines,
        y:      y,
        x:      x,
        z:      z,
        width:  width,
        height: height,
        cursor: cursor
      }
    end
  end
end
