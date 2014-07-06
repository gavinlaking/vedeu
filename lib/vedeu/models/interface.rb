require 'virtus'

require_relative 'presentation'
require_relative 'line_collection'
require_relative '../output/interface_renderer'
require_relative '../support/esc'
require_relative '../support/cursor'
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
      Oj.dump(attributes, mode: :compat)
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
  end
end
